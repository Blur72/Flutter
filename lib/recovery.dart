import 'package:flutter/material.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RecoveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          // Добавлено для прокрутки, если элементы не помещаются
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.center, // Выравнивание по центру
            children: [
              Text(
                "Восстановление пароля",
                // ignore: deprecated_member_use
                textScaleFactor: 2.5, // Исправлено на textScaleFactor
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 300), // Отступ между заголовком и полем ввода
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Введите почту',
                  ),
                ),
              ),

              SizedBox(height: 400), // Отступ между полем ввода и кнопкой
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.1,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Отправить"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
