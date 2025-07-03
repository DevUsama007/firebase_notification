import 'dart:convert';

import 'package:firebase_notification/services/getServerKeyFromJson.dart';
import 'package:firebase_notification/services/get_server_key.dart';
import 'package:firebase_notification/services/notification_services.dart';
import 'package:firebase_notification/services/sendNotificationToTopic.dart';
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
    _notificationServices.subcribeTopic('all');
    _notificationServices.requestNotificationPermission();
    _notificationServices.firebaseInit(context);
    _notificationServices.setupInteractMessage(context);
    // _notificationServices.isTokenRefresh();
    _notificationServices.getDeviceToken().then(
      (value) async {
        print(value);
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
                        // value.toString(),
                        "eIyPLh7vRq2zKDc3qRlIRx:APA91bGMT7RqtjCzk6TS9JPkWXn_SJ_22DOmUsJX1Z_w04YKbjsjkHfCY2llxqR_onlAf7xUn_BAM_gxfzGNYdtBne25VmizP1MMVN2ea2IenpYoxWQpzq8",
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
                  'Send Notification deviceId',
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
                child: Text("Get serverkey")),
            ElevatedButton(
                onPressed: () async {
                  SendNotificationToTopicService.sendNotificationTopicService(
                      "all",
                      'HI ',
                      'Good Morning',
                      {'screen': "Cart Screen", 'type': "dumy"});
                },
                child: Text("Send notification to the device topic")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => _notificationServices.subcribeTopic('all'),
                    child: Text('Subscribe')),
                ElevatedButton(
                    onPressed: () =>
                        _notificationServices.unsubcribeTopic('all'),
                    child: Text('Unsubcribe')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
