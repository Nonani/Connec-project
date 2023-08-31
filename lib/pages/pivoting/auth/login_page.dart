import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/pages/pivoting/auth/social_signup_page.dart';
import 'package:connec/services/kakao_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final logger = Logger();
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.15,
                  left: size.width * 0.3,
                  right: size.width * 0.3),
              child: Image.asset(
                'assets/images/connec_logo2.png',
                color: Color(0xff5f66f2),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.1),
              child: Text(
                '개발자 평판조회 서비스',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff5f66f2),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.07,
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
            SizedBox(height: size.height * 0.15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    await loginWithKakao(context);
                  },
                  child: Image.asset(
                      "assets/images/kakao_login_medium_wide.png"),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  '버튼을 눌러\n카카오톡과 연결해주세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff5f66f2),
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
      logger.w(user.kakaoAccount!.profile!.profileImageUrl);
      FirebaseFirestore.instance
          .collection("users")
          .doc("kakao:${user.id}")
          .get()
          .then((result) {
        if (result.data() == null) {
          //첫 카카오 로그인인 경우
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => SocialSignUpPage(
                        uid: "kakao:${user.id}",
                        profileImageUrl:
                            user.kakaoAccount!.profile!.profileImageUrl,
                      ))));
        } else {
          //이전에 로그인을 하여 회원가입 정보를 넣은 경우
          showCustomDialog(context);
          final url =
              Uri.parse('https://foggy-boundless-avenue.glitch.me/signin');
          try {
            http.post(
              url,
              headers: <String, String>{
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: <String, String>{
                'uid': "kakao:${user.id}",
              },
            ).then((response) async {
              logger.w(response.body);
              if (response.statusCode == 200) {
                Map<String, dynamic> jsonData = jsonDecode(response.body);
                try {
                  await FirebaseAuth.instance
                      .signInWithCustomToken(jsonData["token"]);
                  // getToken();
                } catch (e) {
                  logger.w(e);
                }
                // error handling
              }
            });
          } catch (e) {
            logger.w(e);
          }
          Navigator.pop(context);
        }
      });
    }
  }

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) => {
  //         setState(() {
  //           device_token = token!;
  //           logger.w(device_token);
  //         })
  //       });
  //   saveToken(device_token);
  // }

  void saveToken(String token) async {
    var database = FirebaseFirestore.instance;
    var uid = FirebaseAuth.instance.currentUser?.uid;
    await database.collection('deviceToken').doc(uid).set({'token': token});
    logger.w(uid);
  }
}
