import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  String id;
  String title;
  String message;
  NotificationScreen(
      {super.key,
      required this.id,
      required this.title,
      required this.message});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaitons'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: ListTile(
              leading: Text(widget.id),
              title: Text(widget.title),
              subtitle: Text(widget.message),
            ),
          )
        ],
      ),
    );
  }
}
