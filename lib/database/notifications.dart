import 'package:supabase_flutter/supabase_flutter.dart';

class Notifications {
  Supabase supabase = Supabase.instance;

  Future<void> addNotification(String uid, String title, String message, bool isRead) async {
    try {
      await supabase.client.from('notifications').insert({
        'user_id': uid,
        'title': title,
        'message': message,
        'isRead': false
      });
    } catch (e) {
      print(e);
    }
  }
}
