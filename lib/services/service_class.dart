import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/SignUpBody.dart';

class ServiceClass extends ChangeNotifier {
  Logger logger = Logger();
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool loading = false;
  bool isBack = false;
  bool isComplete = false;

  Future<void> postSignUpBody(SignUpBody body) async {
    loading = true;
    isComplete = false;
    notifyListeners();
    isComplete = await register(body);
    loading = false;
    notifyListeners();
  }

  Future<bool> register(SignUpBody data) async {
    logger.w("test");
    final url = Uri.parse('https://foggy-boundless-avenue.glitch.me/signup');
    try {
      logger.w(data.toJson());
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'uid': '${data.uid}',
          'data': json.encode(data.toJson())
        },
      );
      logger.w(response.body);
    } catch (e) {
      logger.w(e);
      return false;
    }
    return true;
  }

// void getToken() async {
//   String deviceToken = "";
//   await FirebaseMessaging.instance
//       .getToken()
//       .then((token) => {deviceToken = token!});
//   logger.w(deviceToken);
//   saveToken(deviceToken);
// }
//
// void saveToken(String token) async {
//   var database = FirebaseFirestore.instance;
//   var uid = FirebaseAuth.instance.currentUser?.uid;
//   await database.collection('deviceToken').doc(uid).set({'token': token});
//   logger.w(uid);
// }
}
