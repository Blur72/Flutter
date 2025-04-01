import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    emailController.text = 'zxcvbn@gmail.com';
    passwordController.text = 'zxcvbn';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Text(
                "Войти в MishTok",
                textScaler: TextScaler.linear(2.5),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: Text("Восстановить пароль"),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/recovery');
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      print("Поля не заполнены!");
                    } else {
                      var user = await authService.signIn(
                        emailController.text,
                        passwordController.text,
                      );
                      if (user != null) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);
                        Navigator.popAndPushNamed(context, '/home');
                      } else {
                        print("Неправильные данные");
                      }
                    }
                  },
                  child: Text("Войти"),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25),
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
                  Text("У вас нет аккаунта?  "),
                  InkWell(
                    child: Text(
                      "Зарегистрироваться",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/reg');
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
