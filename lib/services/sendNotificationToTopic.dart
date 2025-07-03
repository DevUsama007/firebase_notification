import 'dart:convert';

import 'package:firebase_notification/services/get_server_key.dart';
import 'package:http/http.dart' as http;

class SendNotificationToTopicService {
  static Future<void> sendNotificationTopicService(String topic, String title,
      String body, Map<String, dynamic>? data) async {
    String serverKey = await GetServerKey().getServerKey();
    print('ServerKey ${serverKey}');
    // print("serverkey: ${serverKey}");
    String url =
        "https://fcm.googleapis.com/v1/projects/flutternotification-3541a/messages:send";

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };
    Map<String, dynamic> message = {
      "message": {
        'topic': topic.toString(),
        "notification": {"body": body, "title": title.toString()},
        "data": data
      }
    };
    // hit api
    final http.Response response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(message));
    if (response.statusCode == 200) {
      print("notification send");
    } else {
      print('Notificaiton not send');
    }
  }
}
