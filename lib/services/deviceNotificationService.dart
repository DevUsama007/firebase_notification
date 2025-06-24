import 'dart:convert';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

Future<void> sendPushNotificationV1(String title, String body,
    {String topic = 'all'}) async {
  const serviceAccountPath = 'assets/json/service-account.json';
  final projectId = 'flutternotification-3541a';

  // Load service account credentials
  final serviceAccount = File(serviceAccountPath);
  final jsonCredentials = json.decode(await serviceAccount.readAsString());

  // authenticate using service account
  final accountCredentials =
      ServiceAccountCredentials.fromJson(jsonCredentials);
  final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

  final client = await clientViaServiceAccount(accountCredentials, scopes);

  try {
    // payload
    final url =
        'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

    final message = {
      'message': {
        'topic': topic,
        'notification': {
          'title': title,
          'body': body,
        },
        'android': {
          'priority': 'high',
        },
        'apns': {
          'headers': {'apns-priority': '10'},
          'payload': {
            'aps': {'sound': 'default'}
          }
        },
      }
    };

    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(message),
    );

    print('FCM Response: ${response.body}');
  } catch (e) {
    print('Error sending notification: $e');
  } finally {
    client.close();
  }
}
