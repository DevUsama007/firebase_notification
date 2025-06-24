import 'dart:convert';

import 'package:firebase_notification/services/getServerKeyFromJson.dart';
import 'package:firebase_notification/services/get_server_key.dart';
import 'package:firebase_notification/services/notification_services.dart';
import 'package:firebase_notification/services/send_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homescreenview extends StatefulWidget {
  const Homescreenview({super.key});

  @override
  State<Homescreenview> createState() => _HomescreenviewState();
}

class _HomescreenviewState extends State<Homescreenview> {
  NotificationServices _notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notificationServices.requestNotificationPermission();
    _notificationServices.firebaseInit(context);
    _notificationServices.setupInteractMessage(context);
    // _notificationServices.isTokenRefresh();
    _notificationServices.getDeviceToken().then(
      (value) async {
        print(value);
        // String serverkey = await GetServerKey.getServerKey();
        // print('server_key:');
        // print(serverkey.toString());
        // var data = {
        //   'to': value.toString(),
        //   'priority': 'high',
        //   'notification': {
        //     'title': 'Usama Basharat',
        //     'body': 'Here i am for you',
        //   },
        //   'data': {'type': 'msj', 'id': '1234 '}
        // };
        // print('Device token');
        // print(value);
        // await http.post(
        //     Uri.parse(
        //         "https://fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send"),
        //     body: jsonEncode(data),
        //     headers: {
        //       'Context-Type': 'application/json: charset=UTF-8',
        //       'Authorization': 'server_key'
        //     });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('Flutter Notication'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () async {
                _notificationServices.getDeviceToken().then(
                  (value) async {
                    print('Deviev token :${value}');
                    await SendNotificationService.sendNotificationService(
                        value.toString(),
                        // "dnqrZB-wRoureeA4FobR_Q:APA91bHNpmSaB79X2HJgoYv7NcbD_4zHuBynMtv6OjMeMVHJMTkwLjJf3NAfisq4l7E3ZnoBZpNSGtfK0cn4hHFwaZAtkdk1C-aEDnN_jG7X2hTL0-QH0aw",
                        "Usama Notification",
                        "I am here for coding",
                        {'screen': "Cart Screen", 'type': "dumy"});
                    // print('Device token');
                    // print(value);
                  },
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  'Send Notification',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  String serverKey =
                      await Getserverkeyfromjson().getServerKey();
                  print(serverKey);
                },
                child: Text("Get serverkey"))
          ],
        ),
      ),
    );
  }
}
