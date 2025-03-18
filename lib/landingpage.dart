import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/authpage.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  bool _isLoggedIn = false;
  Future<void> _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  void initState() {
    _checkAuth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? HomePage() : const AuthPage();
  }

}