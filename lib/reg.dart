import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/auth.dart';
import 'package:flutter_application_1/database/notifications.dart';
import 'package:flutter_application_1/database/user_table.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  AuthService authService = AuthService();
  UserTable userTable = UserTable();
  Notifications notifications = Notifications();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "Зарегистрироваться в MishTok",
                  textScaler: TextScaler.linear(2.5),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: nameController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    prefixIcon: Icon(Icons.people),
                    hintText: 'Введите имя пользователя',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: emailController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Введите почту',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Введите пароль',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  controller: repeatController,
                  obscureText: true,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Повторите пароль',
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isNotEmpty ||
                        repeatController.text.isNotEmpty ||
                        passwordController.text.isNotEmpty ||
                        nameController.text.isNotEmpty) {
                      if (repeatController.text == passwordController.text) {
                        var user = await authService.signUp(
                          emailController.text,
                          passwordController.text,
                        );
                        if (user != null) {
                          await userTable.addUser(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                          await notifications.addNotification(
                            user.id!,
                            "Регистрация",
                            "Успешно пройдена",
                            false,
                          );
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', true);
                          Navigator.popAndPushNamed(context, "/");
                        } else {
                          print("Пользователь не зарегистрирован");
                        }
                      } else {
                        print("Пароли не совпадают");
                      }
                    } else {
                      print("Поля не заполнены!");
                    }
                  },
                  child: Text("Зарегистрироваться"),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "Продолжая пользоваться аккаунтом, относящимся к региону RU, вы принимаете Условия использования и подтверждаете, что ознакомились с документами <Политики и конфиденциальности> и Политики использования файлов coockie>",
                  style: TextStyle(fontSize: 11),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Уже есть аккаунт?  "),
                  InkWell(
                    child: Text(
                      "Войти",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/auth');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
