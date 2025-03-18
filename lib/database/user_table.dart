import 'package:supabase_flutter/supabase_flutter.dart';

class UserTable {
  final Supabase _supabase = Supabase.instance;

  Future<void> addUser(String name, String email, String password)async{
    try {
      await _supabase.client.from('users').insert({
        'name' : name,
        'email' : email,
        'password' : password,
        'avatar' : 'https://vhdsykipnfvohmmuvbnw.supabase.co/storage/v1/object/public/storages//default_person.jpg',
        'description' : ''
      });
    } catch (e) {
      print(e);
    };
  }

}
