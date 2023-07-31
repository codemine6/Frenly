import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServices {
  final url = 'https://fcm.googleapis.com/fcm/send';
  final serverKey =
      'AAAAx3P4BrM:APA91bH64jfndGd3AGfLX5xv7iY_ugsRfnMbgrQ-fxSrllIn4zcg5bj-XdvZJy6ZR24r8qv10DscnrwDR3jeWVDlEQhMWE7d4S3Cb7eLf-Z2nj2yeCQKbCtCbT8BRg88Sq4hdQmqvAg0';

  getDio() {
    final dio = Dio();
    dio.options.headers['Authorization'] = 'key=$serverKey';
    return dio;
  }

  init() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final token = await FirebaseMessaging.instance.getToken();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'token': token});
  }

  sendFollowNotification(String token) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await getDio().post(
        url,
        data: {
          'to': token,
          'notification': {
            'title': 'New Followers',
            'body': '${user?.displayName} start following you.',
          }
        },
      );
    } catch (_) {}
  }

  sendMessageNotification(String token, String message) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      await getDio().post(url, data: {
        'to': token,
        'notification': {
          'title': 'Message from ${user?.displayName}',
          'body': '"$message"',
        },
      });
    } catch (_) {}
  }
}
