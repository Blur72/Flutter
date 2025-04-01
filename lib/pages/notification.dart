import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  static Stream<int> getUnreadCount() {
    final user = Supabase.instance.client.auth.currentUser!.id.toString();
    return Supabase.instance.client
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('user_id', user)
        .map((event) => event.where((doc) => doc['isRead'] == false).length);
  }

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final String user = Supabase.instance.client.auth.currentUser!.id.toString();
  String searchQuery = '';

  Widget cardNot(BuildContext context, dynamic docs) {
    return ListTile(
      leading: Icon(Icons.notifications, color: Colors.yellow),
      title: Text(docs['title']),
      subtitle: Text(docs['message']),
      trailing: CircleAvatar(
        radius: 5,
        backgroundColor: docs['isRead'] == true ? Colors.green : Colors.red,
      ),
      onTap: () async {
        await Supabase.instance.client
            .from('notifications')
            .update({'isRead': true})
            .eq('id', docs['id']);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Поиск по заголовку',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: Supabase.instance.client
            .from('notifications')
            .stream(primaryKey: ['id'])
            .eq('user_id', user),
        builder: (context, snapshot) {
          final filteredDocs =
              snapshot.data!.where((doc) {
                return doc['title'].toLowerCase().contains(searchQuery);
              }).toList();

          return ListView.builder(
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              return cardNot(context, filteredDocs[index]);
            },
          );
        },
      ),
    );
  }
}
