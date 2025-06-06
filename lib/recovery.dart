import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/auth.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  TextEditingController emailController = TextEditingController();
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Восстановление доступа"),
        leading: IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.back)),
      ),
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text("Для восстановления доступа к аккаунту, введите свою почту для отправки сообщения",
              textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: emailController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blueGrey)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blueGrey)),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Отправить на почту'),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.9,
                child: ElevatedButton(onPressed: () async {
                  if(emailController.text.isEmpty){
                    print('Поле пустое');
                  } else {
                    await authService.recoveryPassword(emailController.text);
                    print('Письмо отправлено');
                    emailController.clear();
                    Navigator.popAndPushNamed(context, '/');
                  }
                }, 
                child: Text("Отправить на почту"))),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
            ),
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
                  child: Text("Зарегистрироваться",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.popAndPushNamed(context, '/reg');
                  },
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}