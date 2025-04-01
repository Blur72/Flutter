import 'package:flutter/material.dart';
import 'package:flutter_application_1/authpage.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:flutter_application_1/landingpage.dart';
import 'package:flutter_application_1/recovery.dart';
import 'package:flutter_application_1/reg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://vhdsykipnfvohmmuvbnw.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZoZHN5a2lwbmZ2b2htbXV2Ym53Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk4NzIyMTUsImV4cCI6MjA1NTQ0ODIxNX0._mQBBbehC3mfQ4OSr6Jd54Y9wJFe031ctO-0GlTvwSs",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xff2B2D42),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xff2B2D42)),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide.none,
              ),
            ),
          ),
        ),
        useMaterial3: true,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => Landingpage(),
        '/auth': (context) => AuthPage(),
        '/reg': (context) => RegPage(),
        '/home': (context) => HomePage(),
        '/recovery': (context) => RecoveryPage(),
      },
    );
  }
}
