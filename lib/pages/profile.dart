import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/database/user_table.dart';
import 'package:flutter_application_1/storage/image.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ignore: unused_field
  File? _selectedFile;
  XFile? _file;
  String? url;
  UserTable userTable = UserTable();
  Supabase supabase = Supabase.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future selectedImageGallery() async {
    final returnImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (returnImage != null) {
      setState(() {
        _selectedFile = File(returnImage.path);
        _file = returnImage;
      });
    }
  }

  uploadImage() async {
    await StorageCloud().uploadImage(_file!);
  }

  downdloadUrl() async {
    try {
      final fileName = path.basename(_file!.path);
      final image = supabase.client.storage
          .from("storages")
          .getPublicUrl(fileName);

      setState(() {
        url = image;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserImage(String uid, String url) async {
    try {
      await supabase.client.from('users').update({'avatar': url}).eq('id', uid);
    } catch (e) {
      print(e);
    }
  }

  final String user = Supabase.instance.client.auth.currentUser!.id.toString();

  Future<Map<String, dynamic>?> getUserById() async {
    final doc =
        await Supabase.instance.client
            .from("users")
            .select()
            .eq('id', user)
            .single();

    return doc;
  }

  Future<void> _showEditDialog(
    String title,
    String currentValue,
    bool isName,
    Map<String, dynamic> docs,
  ) async {
    final controller = isName ? _nameController : _descriptionController;
    controller.text = currentValue;

    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Изменить $title'),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Введите новое значение'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await userTable.updateUser(
                      isName ? controller.text : docs["name"],
                      isName ? docs["description"] : controller.text,
                      user,
                    );
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    setState(() {});
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$title успешно обновлен(о)')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Произошла ошибка при обновлении'),
                      ),
                    );
                  }
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserById(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return const Center(child: Text("Ошибка загрузки данных"));
          }

          final docs = snapshot.data!;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.15,
                      backgroundImage: NetworkImage(docs["avatar"] ?? ''),
                    ),
                    FloatingActionButton.small(
                      onPressed: () async {
                        try {
                          await selectedImageGallery();
                          await uploadImage();
                          await downdloadUrl();
                          await updateUserImage(user, url!);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Фото успешно обновлено")),
                          );
                        } catch (e) {
                          print("Ошибка: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Произошла ошибка")),
                          );
                        }
                      },
                      child: const Icon(Icons.camera),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.08),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        // ignore: deprecated_member_use
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: Colors.white,
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          leading: const Icon(Icons.email),
                          title: Text(docs["email"] ?? "Нет данных"),
                          subtitle: const Text("Почта"),
                          onTap: () {},
                        ),
                      ),
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        color: Colors.white,
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(docs["name"] ?? "Нет данных"),
                          subtitle: const Text("Имя"),
                          trailing: const Icon(Icons.edit),
                          onTap:
                              () => _showEditDialog(
                                'имя',
                                docs["name"] ?? "",
                                true,
                                docs,
                              ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        color: Colors.white,
                        child: ListTile(
                          leading: const Icon(Icons.description),
                          title: Text(docs["description"] ?? "Нет данных"),
                          subtitle: const Text("Описание"),
                          trailing: const Icon(Icons.edit),
                          onTap:
                              () => _showEditDialog(
                                'описание',
                                docs["description"] ?? "",
                                false,
                                docs,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
              ],
            ),
          );
        },
      ),
    );
  }
}
