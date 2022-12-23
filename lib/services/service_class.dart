import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/SignUpBody.dart';
class ServiceClass extends ChangeNotifier{
  Logger logger = Logger();
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool loading = false;
  bool isBack = false;
  bool isComplete = false;
  Future<void> postData(SignUpBody body) async {
    loading = true;
    notifyListeners();
    sleep(Duration(seconds: 5));
    isComplete = await register(body);
    loading = false;
    notifyListeners();
  }

  Future<bool> register(SignUpBody data) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
