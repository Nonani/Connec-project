import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/pages/login/reset_password_page.dart';
import 'package:connec/pages/login/social_signup_page.dart';
import 'package:connec/services/kakao_login.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../components/login_icon_button.dart';
import '../../components/custom_edit_textform.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final logger = Logger();
  String email = "";
  String password = "";
  String device_token = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        title: Text("로그인", style: featureTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height * 0.18),
              width: double.infinity,
              height: size.height * 0.072,
              child: Center(
                child: Text(
                  'CONNEC',
                  style: TextStyle(
                    color: Color(0xff5f66f2),
                    fontSize: 40,
                    fontFamily: 'S-CoreDream-8',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.34),
            Center(
              child: Text(
                '카카오톡으로 로그인하기',
                style: TextStyle(
                  color: Color(0xff5f66f2),
                  fontSize: 17,
                  fontFamily: 'S-CoreDream-6',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customImageButton(AssetImage("assets/images/kakao_btn.png"),
                    () async {
                  await loginWithKakao(context);
                }, 70),
                SizedBox(height: size.height * 0.03,),
                Text(
                  '아이콘을 눌러\n카카오톡과 연결해주세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xffbdbdbd),
                    fontSize: 11.5,
                    fontFamily: 'S-CoreDream-4',
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

  Future<void> loginWithKakao(BuildContext context) async {
    bool isLogined = await KakaoLogin().login();
    if (isLogined) {
      kakao.User user = await kakao.UserApi.instance.me();
      logger.w(user!.kakaoAccount!.profile!.profileImageUrl);
      final result = await FirebaseFirestore.instance
          .collection("users")
          .doc("kakao:${user!.id}")
          .get();
      if (result.data() == null) {
        //첫 카카오 로그인인 경우
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => SocialSignUpPage(
                      serviceName: "kakao",
                      uid: "kakao:${user!.id}",
                      profileImageUrl: user!.kakaoAccount!.profile!.profileImageUrl,
                    ))));
      } else {
        //이전에 로그인을 하여 회원가입 정보를 넣은 경우
        showCustomDialog(context);
        final url =
            Uri.parse('https://foggy-boundless-avenue.glitch.me/signin');
        try {
          http.Response response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: <String, String>{
              'uid': "kakao:${user.id}",
            },
          );
          if (response.statusCode == 200) {
            Map<String, dynamic> jsonData = jsonDecode(response.body);
            try {
              await FirebaseAuth.instance
                  .signInWithCustomToken(jsonData["token"]);
              getToken();
            } catch (e) {
              logger.w(e);
            }
          }
        } catch (e) {
          logger.w(e);
        }
        Navigator.pop(context);
      }
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) => {
          setState(() {
            device_token = token!;
            logger.w(device_token);
          })
        });
    saveToken(device_token);
  }

  void saveToken(String token) async {
    var database = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser?.uid;
    await database.collection('deviceToken').doc(uid).set({'token': token});
    logger.w(uid);
  }
}
