import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class StorageCloud{
  final Supabase supabase = Supabase.instance;

  Future<void> uploadImage(XFile imageUrl) async {
    try {
      final fileName = path.basename(imageUrl.path);
      await supabase.client.storage
        .from("storages")
        .upload(fileName, File(imageUrl.path))
        .then((value) => print("Completed"));
    } catch(e) {
      return;
    }
  }
}