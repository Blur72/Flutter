import 'package:flutter_application_1/database/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService{
  final Supabase _supabase = Supabase.instance;

  Future<LocalUser?> signIn(String email, String password)async{
    try {
      var userDb = await _supabase.client.auth.signInWithPassword(
        password: password,
        email: email,
      );

      User user = userDb.user!;

      return LocalUser.fromSupabase(user);

    } catch (e) {
      return null;
    }
  }

  Future<LocalUser?> signUp(String email, String password) async {
    try {
      var userDb = await _supabase.client.auth.signUp(
        password: password,
        email: email,
      );

      User user = userDb.user!;

      return LocalUser.fromSupabase(user);

    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    return await _supabase.client.auth.signOut();
  }

  Future<void> recoveryPassword(String email) async {
    return await _supabase.client.auth.resetPasswordForEmail(email);
  }
}