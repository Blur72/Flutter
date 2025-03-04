// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageThree extends StatefulWidget {
  const PageThree({super.key});

  @override
  State<PageThree> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Ямашева 73",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down_sharp),
              ],
            ),

            SizedBox(height: screenHeight * 0.02),
            CircleAvatar(
              radius: screenWidth * 0.15,
              backgroundImage: AssetImage('images/marsik.png'),
            ),
            // SizedBox(height: screenHeight * 0.01),
            // Text(
            //   "Пидастро",
            //   style: TextStyle(
            //     fontSize: screenWidth * 0.06,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Text(
              "@yamasheva73",
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("52", style: TextStyle(fontSize: screenWidth * 0.04)),
                    Text(
                      "Подписки",
                      style: TextStyle(fontSize: screenWidth * 0.03),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("52", style: TextStyle(fontSize: screenWidth * 0.04)),
                    Text(
                      "Подписчиков",
                      style: TextStyle(fontSize: screenWidth * 0.03),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("52", style: TextStyle(fontSize: screenWidth * 0.04)),
                    Text(
                      "Лайков",
                      style: TextStyle(fontSize: screenWidth * 0.03),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {},
              child: Text("Изменить профиль"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(screenWidth * 0.8, screenHeight * 0.05),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            ElevatedButton(
              onPressed: () {},
              child: Text("Добавить описание"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(screenWidth * 0.8, screenHeight * 0.05),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.list, size: screenWidth * 0.05),
                Icon(Icons.lock, size: screenWidth * 0.05),
                Icon(Icons.bookmark, size: screenWidth * 0.05),
                Icon(Icons.favorite, size: screenWidth * 0.05),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Divider(),
            SizedBox(height: screenHeight * 0.03),
            Image.asset('images/qwerty.png', width: screenWidth * 0.1),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Опубликуйте свой самый\n популярный видосик",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              onPressed: () {},
              child: Text("Загрузить"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(screenWidth * 0.3, screenHeight * 0.05),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
