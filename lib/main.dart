import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth.dart';
import 'package:flutter_application_1/landing.dart';
import 'package:flutter_application_1/recovery.dart';
import 'package:flutter_application_1/reg.dart';
import 'package:flutter_application_1/homepage.dart'; // Импорт HomePage
import 'package:flutter_application_1/page_one.dart';
import 'package:flutter_application_1/page_two.dart';
import 'package:flutter_application_1/page_three.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://kzpvadkdauczgfismnic.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt6cHZhZGtkYXVjemdmaXNtbmljIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4NzIyMjksImV4cCI6MjA1NTQ0ODIyOX0.-_6FyFtJLrqo9b23ZR64fV1e9BjAx7gCFB5GYjN4Kmo",
  );
  runApp(const AppTheme());
}

class AppTheme extends StatelessWidget {
  const AppTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xff2B2D42)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/auth': (context) => AuthPage(),
        '/reg': (context) => RegPage(),
        '/recovery': (context) => RecoveryPage(),
        '/homepage': (context) => HomePage(), // Добавлено
        '/page1': (context) => PageOne(),
        '/page2': (context) => PageTwo(),
        '/page3': (context) => PageThree(),
      },
    );
  }
}
