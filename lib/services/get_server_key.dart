import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKey() async {
    final scopes = [
      // 'https://www.googleapis.com/auth/firebase.email',
      // 'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging'
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
        
        }),
        scopes);
    final accesssServerKey = client.credentials.accessToken.data;
    return accesssServerKey;
  }
}
