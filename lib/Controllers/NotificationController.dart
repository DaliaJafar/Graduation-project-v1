import 'dart:convert';

import 'package:http/http.dart' as http;
class NotificationController{
  void sendNotification(String token, String title, String body) async {
  var serverKey =
      'AAAA1MJsAfA:APA91bFtvvuZAxo4rVO4yttjYrHD8qkHE7cuKF1OHG9deBF969QOof0eRtgF5o30VeVaSHk0Wy_H6LqNwVeUnmxQxGgH0sElVFdKWttI6yIJPX7FGYBXWQliTasq19ZCra_Yk8rsUqvm';

  try {
    http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{'body': body, 'title': title},
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': token,
        },
      ),
    );
  } catch (e) {
    print("error push notification");
  }
}

}