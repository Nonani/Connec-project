
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> postData(SignUpBody body) async {
    loading = true;
    notifyListeners();
    isComplete = await register(body);
    loading = false;
    notifyListeners();
  }

  Future<bool> register(SignUpBody data) async {
    switch (data.serviceName) {
      case 'kakao':
        //백엔드 요청보내고 계정 생성 성공 응답을 받으면
        // firestore에 signupbody를 넣어
        final url = Uri.parse('https://foggy-boundless-avenue.glitch.me/signup');
        try{
          http.Response response = await http.post(
            url,
            headers: <String, String> {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: <String, String> {
              'uid': 'kakao:${data.uid}',
            },
          );
          logger.w(response.body);
        }catch(e){
          logger.w(e);
          return false;
        }
        try{
          db.collection("users").doc("${data.serviceName}:${data.uid}").set(data.toJson());
        }catch(e){
          logger.w(e);
          return false;
        }

        return true;
      case 'naver':
        return true;
      case 'facebook':
        return true;
      default:
        // sign up with email and password
        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: data.email!,
            password: data.password!,
          );
          data.uid = credential.user?.uid;
          logger.w(data.toJson().toString());
          db.collection("users").doc(data.uid).set(data.toJson());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            logger.w('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            logger.w('The account already exists for that email.');
          }
          logger.w(e);
          return false;
        } catch (e) {
          logger.w(e);
          return false;
        }
        return true;
    }
  }
}
