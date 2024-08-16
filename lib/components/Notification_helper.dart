import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import '../components/components.dart';

class NotificationsHelper {
  // creat instance of fbm
  final _firebaseMessaging = FirebaseMessaging.instance;

  // initialize notifications for this app or device
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // get device token
    String? deviceToken = await _firebaseMessaging.getToken();
    print(
        "===================Device FirebaseMessaging Token====================");
    print(deviceToken);
    print(
        "===================Device FirebaseMessaging Token====================");
  }

  // handle notifications when received
  void handleMessages(RemoteMessage? message) {
    if (message != null) {
      // navigatorKey.currentState?.pushNamed(NotificationsScreen.routeName, arguments: message);
      showToast(
          text: 'on Background Message notification',
          state: ToastStates.success);
    }
  }

  // handel notifications in case app is terminated
  void handleBackgroundNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then((handleMessages));
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessages);
  }

  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "delibox-36e5f",
      "private_key_id": "d0bfa4be95a81721371d4f1848072d39ddbbfe4c",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCnl8sWb8WVmCJ/\n32DLmAAQEmkdEzAUjHotUWCI0twyWkz7WRCbuBBCsL5oD8h05mi+Br3ES2rwYPFM\nPY2ptQS5xcDwBhKuZ36PZ4ZBAUAtbv+hTQaJLlbBWfFpoZIaMcwWZVMlaORKCp9R\nkWRRQrCJWmx56y51sSxgtB1CcnbvsJZSpFO5WvuwkNPEc/dPjtB38KiCVPkMTEdS\nHBN8U+3kLuVo7lFrP6QQ4ZnEC9G+YbePB8EOogTKRSRr+EbE8fdYNADtaxGgZU06\nEkB1POx9GbbRQuw0CEMFDZzN5q9NYl9f+kvxywjZ8tb7oZ0pbjqTQlCcs1MZ2Quk\n6NLDhqzDAgMBAAECggEALgugerue16kC4Ysn9wf+DGxigOCCt0KZVtYi5bS5VwRE\nXlJsI7yAizIwPjsH4kZjxMHpZYMrEHwyD7Zhs5zOfZP9nHSusUgyF4hj9Hw5e8Ih\nbdnRz+LxZxIlJ9aCY7wGzKhuHbsh7c3ZU/nUTBc8laBIaX7aNu/Et5UE7Pqx/sxc\n9/+36W+jQlS8+gvj7F8VO/LPBNhNBYkCtprvOIVRuac9na2Qo4A+JziP3I+9wYX2\nbKSsoUmzid28AgAzO6IVtsEE/NXFowqug6VKyf4I5Or7p6c/mlF75yE/3Y85OX6H\nGdHzXmi3s2uuFzRxku4mL1bzqxXyxai7lDABJ8gewQKBgQDp311LB2iLxAPk2pr5\nibC1PDTW70ZMTZ7R/WQz774+QJeP6cLe2yOr777R3+JdlCer0x4/NjIgXLBlVa1b\nHRf2Ssyxqf+ZReRv2HIkaap9gSVlPvdtqSZ7VcMs1AbsssBNX2B5Oe7JxBOaLC8Z\numMJKES+9JNFjjCYMxIbeQ/kEwKBgQC3cxGT1uP0NDToj7JKr49utCe3MRSBf2GB\nR3Gyvk9OWWP9pejnum+3E+6PD+3SNbftnN+8ZMJI+vEMUfmFqWzZ/80cSBKE0y1F\ntF+6AvkSNz42hVDSfRqeTZmr581okZgjV701LvHa/g1k+fMy8XqV24Uap+c2o7/d\nH9aVSSNKkQKBgQCHv3bPTgWI2sXH2HuLzDgdekzRVSFguM0u5f17h/TM/YD7r5vE\n7z3NVuNTvrgNySkduvUbi8GctzBMIWb2M/TsqI4Xsa0Csmbd5KycJhknsAactee4\nZy5G+IjJRGigi0DDqFC/DLlls8INAwhzzpQdhJoinKO/A8GBFmO0PpjSsQKBgH+w\nn46JKBhF8oHh65cixjKnQXG4vu44bPUgdpqU7vy5KelW/1u0oKgNPqLj0oTcEU9a\nPz2R4M4NpZUOxiDsQjEnZWyHGiTMHRoEqBEAmr+8JhirCQvKOqnvl8RZT9e2Z/BJ\n1RBcwcnNxiL/+/D8tnfy2Z4pOr4Ekrrmu2UkCGWRAoGAamSw8CTQq/O9hHX6640G\ns6V70otRUQYpj0yf+2mNPZx8rkawjlINZtKHE315FLcay6aYqDVxJr49j4s32DTL\n3mVV+qiQJX23yHuU47EEhBQw8uC3JBDKnWydDXt0eXVBJCX1b0JFpnuAOzew4QBY\nbg38HdEprG7TpmMKj4J3FMs=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-2nplq@delibox-36e5f.iam.gserviceaccount.com",
      "client_id": "113790320477453784860",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-2nplq%40delibox-36e5f.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
              scopes,
              client);

      client.close();

      print(
          "Access Token: ${credentials.accessToken.data}"); // Print Access Token
      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }

  Map<String, dynamic> getBody({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) {
    return {
      "message": {
        "token": fcmToken,
        "notification": {"title": title, "body": body},
        "android": {
          "notification": {
            "notification_priority": "PRIORITY_MAX",
            "sound": "default"
          }
        },
        "apns": {
          "payload": {
            "aps": {"content_available": true}
          }
        },
        "data": {
          "type": type,
          "id": userId,
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      }
    };
  }

  Future<void> sendNotifications({
    required String fcmToken,
    required String title,
    required String body,
    required String userId,
    String? type,
  }) async {
    try {
      var serverKeyAuthorization = await getAccessToken();

      // change your project id
      const String urlEndPoint =
          "https://fcm.googleapis.com/v1/projects/delibox-36e5f/messages:send";

      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $serverKeyAuthorization';

      var response = await dio.post(
        urlEndPoint,
        data: getBody(
          userId: userId,
          fcmToken: fcmToken,
          title: title,
          body: body,
          type: type ?? "message",
        ),
      );

      // Print response status code and body for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error sending notification: $e");
    }
  }
}
