import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/style/title_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../components/custom_edit_textform.dart';

class ChangeEmailPage extends StatefulWidget {
  const ChangeEmailPage({Key? key}) : super(key: key);

  @override
  State<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final _formKey = GlobalKey<FormState>();
  String email="";
  Logger logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: const Color(0xfffafafa),
        shape: const Border(
            bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff5f66f2),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '이메일 변경',
          style: featureTitle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 47.1),
              child: loginEditTextForm(
                label: "이메일",
                hint: "example@connec.co.kr",
                isSecret: false,
                onSaved: (newValue) => email = newValue,
              ),
            ),
          ],
        ),
      )),
        bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final db = FirebaseFirestore.instance;
              final user = (await db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get()).data();
              user!["email"]= email.toString();
              db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(user);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff5f66f2),
            minimumSize: const Size(100, 56),
          ),
          child: const Text(
            '변경하기',
            style: TextStyle(
              color: Color(0xfffafafa),
              fontSize: 20,
              fontFamily: 'S-CoreDream-4',
            ),
          ),
        ),
    );
  }
}
