import 'dart:developer';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NotificationAccessToken {
  static String? _token;

  //to generate token only once for an app run
  static Future<String?> get getToken async => _token ?? await _getAccessToken();

  // to get admin bearer token
  static Future<String?> _getAccessToken() async {
    try {
      const fMessagingScope =
          'https://www.googleapis.com/auth/firebase.messaging';

      final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": dotenv.env['PROJECT_ID'],
          "private_key_id": dotenv.env['PRIVATE_KEY_ID'],
          "private_key": dotenv.env['PRIVATE_KEY'],
          "client_email": dotenv.env['CLIENT_EMAIL'],
          "client_id": dotenv.env['CLIENT_ID'],
          "auth_uri": dotenv.env['AUTH_URI'],
          "token_uri": dotenv.env['TOKEN_URI'],
          "auth_provider_x509_cert_url": dotenv.env['AUTH_PROVIDER_X509_CERT_URL'],
          "client_x509_cert_url": dotenv.env['CLIENT_X509_CERT_URL'],
        }),
        [fMessagingScope],
      );

      _token = client.credentials.accessToken.data;

      return _token;
    } catch (e) {
      log('$e');
      return null;
    }
  }
}
