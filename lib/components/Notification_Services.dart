// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:googleapis_auth/auth_io.dart' as auth;

// class PushNotificationService {
//   static Future<String?> getAccessToken() async {
//     final serviceAccountJson = {
//       "type": "service_account",
//       "project_id": "delibox-36e5f",
//       "private_key_id": "ad0aa5bcf3126a441f14e99cf8f7e5d72ef80d7d",
//       "private_key":
//           "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQClN9qFxU94/yeX\nGD0LsSGyTn+g5fwI098lxT5Ge7wTSO2tU8MYBt5XKy95dgAZlOZy1WHs9fjwLeyH\nr/bI6FVA7ezho6A456j6oJXoMJ+fvXwICxowX+NMGu6qocEM79N/D1REJr3ZpcqN\nJ/Cxfjly77qPWh5QzuX9EFJIasRhpO7xtmgXGySwOTPvUfvy9oDqhExPxx5lpqmG\nWDoV2peQLh+tNdTWDkz8/c2Ti4yBTi9Cnf8CMIRb7DWKF2mGH/ltGQri/lbiWL7Y\nz79ZmDBEAXL19YXfSbR9DE2DG7D6IxvRto1t4i4LGxUmtWutg09nBMrr8WzWJeXR\nrZWNxP2VAgMBAAECgf8Aq5Hybx9jaBu3KJM+M/m9yUT2WEdBJF/NM7q0U2m00bRz\n4gCjrAD/z60JAlP9xpMBWmYVI683cZXI9x7/Ty0JW1AuXw89ep9mFhlKfzbEFoCv\nOOYnOGO9fvwCtS8dIz5fxZKbx9s4X2ny7Y8p7hQ54yGF/TA1/FIZ5e00cbCVUlk1\noWB6WmNT/4P+Va+VgMJSWavyziSURoW2PHshv1MT4TvhnKq5SZeWbDm6bBW+ucu0\n5GP8tP58Hp1iBZQT2nWmVacol99YKMcWI1cgB51x3IOZIP+N7ipSPMUbkHw60Fnh\nCOFt9mx3sVFimzkfmOJZQkghISNSPWTZe5sZRvECgYEA0gER/u9gp1sYwyGXFNX6\nMw88Vzi1x7iyRZjH1CGuQZZ8hyxwr+YTMx2dc4JdpoBC8OgH+DaqyF1BTU7vBLo+\npPPZsAFIoe7lK24VFFHpUFyQ+1OsoZk7cixxcl9JI2vAGdEckxBUlLgDdGI9Qbcf\nlewRvIbwTJcPY8gDiXCq0L0CgYEAyWeiFZA6WiVZ7iIJ8awQB06L90wqOkXR4k8C\nCzckIkwPdJPMOnZ90GBx+/Y/g+PbRYsVxbzyqSUEIIHJoaPOsoYRLSnBBrK9yJvy\nowtERQA4PzysYb/0iQnGvvdTWAJFmY6JYf94429MhBmDYxkycX2aA/+ixBrX+jsA\n5QqLibkCgYA32h0FJnkYSXweeZKK8hXm+ohb0jNWeOLA689JteN4giOAd+tIfPJi\nR+AWVne9zqL/G1bzRubI/zRc8T9UjIwYptogm1bL6pN8p3xnuRlKTDQrA6gIGo7a\n4MMTXhA/oWqn8xucaV11aDNTAsWz8pYt82kMMP87/3kSWqHGLfbgKQKBgQDDRIrN\nRUyN4fDTBIWHnj7cFrd1SI8YeGEJfXiJzyhlaEED0dgMRp2szhU1KIZkJSKOxk6R\nrKPIgm8B5VPMN7lLNNiqZPUUvW9rdGdG1MGX9KKUDQtEqos34hajR7+ycGFyg9OH\nA939BAe3e9T6248goZoVjmAMqcoEffhcGGE5YQKBgQCBDu9tHxeGr7pknF22DWup\njaLBDp41pTQwQlBeyxdH8XWIILQMDXqDJBXmdlzLWxnuqfqvXM5KqkNvjDHpbR3I\nT9J5md6trRoMsDisVIaXUCGX6wOx6hp93VOwhGs1rocFo97crxV5uS5eXM6ieSD2\nXjlhue2eeuR/FK5W4pG68A==\n-----END PRIVATE KEY-----\n",
//       "client_email":
//           "delibox-bassem-siam@delibox-36e5f.iam.gserviceaccount.com",
//       "client_id": "116975212250233451356",
//       "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//       "token_uri": "https://oauth2.googleapis.com/token",
//       "auth_provider_x509_cert_url":
//           "https://www.googleapis.com/oauth2/v1/certs",
//       "client_x509_cert_url":
//           "https://www.googleapis.com/robot/v1/metadata/x509/delibox-bassem-siam%40delibox-36e5f.iam.gserviceaccount.com",
//       "universe_domain": "googleapis.com"
//     };

//     List<String> scopes = [
//       "https://www.googleapis.com/auth/userinfo.email",
//       "https://www.googleapis.com/auth/firebase.database",
//       "https://www.googleapis.com/auth/firebase.messaging"
//     ];
//      try {
//       http.Client client = await auth.clientViaServiceAccount(
//           auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

//       auth.AccessCredentials credentials =
//           await auth.obtainAccessCredentialsViaServiceAccount(
//               auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
//               scopes,
//               client);

//       client.close();
//       print(
//           "Access Token: ${credentials.accessToken.data}"); // Print Access Token
//       return credentials.accessToken.data;
//     } catch (e) {
//       print("Error getting access token: $e");
//       return null;
//     }
//   }

//   static sendNotificationToSelectDriver(
//       String deviceToken, BuildContext context, String tripId) async {
//     final String? serverkey = await getAccessToken();

//     const String FCMEndPoint =
//         "https://fcm.googleapis.com/v1/projects/delibox-36e5f/messages:send";

//     final Map<String, dynamic> message = {
//       'message': {
//         'token': deviceToken,
//       },
//       "notification": {
//         "title": 'dwwdw',
//         "body": 'dwwdwdw11111',
//       },
//       "data": {'tripID': tripId}
//     };

//     final http.Response response = await http.post(
//       Uri.parse(FCMEndPoint),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $serverkey'
//       },
//       body: jsonEncode(message),
//     );

//     if (response.statusCode == 200) {
//       print('Notification sent successfully');
//     } else {
//       print('Notification filed , not sent : ${response.statusCode}');
//     }
//   }
// }
