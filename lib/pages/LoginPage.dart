import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/SocialSignUpPage.dart';
import 'package:connec/services/KakaoLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../components/LoginIconButton.dart';
import '../components/CustomEditTextForm.dart';
import 'SearchPasswordPage.dart';
import 'SignUpPage.dart';

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        title: Text("로그인",
            style: TextStyle(
                fontFamily: "EchoDream", fontSize: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.15,
              child: Center(
                child: Text(
                  "CONNEC",
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "EchoDream",
                      fontWeight: FontWeight.w800,
                      color: Color(0xff5f66f2)),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoginEditTextForm(
                    label: "이메일",
                    hint: "example@connec.co.kr",
                    isSecret: false,
                    onSaved: (newValue) {
                      email = newValue;
                      print(email);
                    },
                  ),
                  LoginEditTextForm(
                    label: "비밀번호",
                    hint: "비밀번호를 입력해주세요",
                    isSecret: true,
                    onSaved: (newValue) {
                      password = newValue;
                      print(password);
                    },
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    width: double.infinity,
                    height: 70,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: password);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                logger.w('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                logger.w(
                                    'Wrong password provided for that user.');
                              } else {
                                logger.w(e);
                              }
                            }
                          }
                        },
                        child: Text(
                          "이메일 로그인",
                          style: TextStyle(
                              fontFamily: "EchoDream",
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xff5f66f2),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )))),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchPasswordPage(),
                          ));
                    },
                    child: Text(
                      "비밀번호 찾기",
                      style: TextStyle(color: Color(0xffbdbdbd)),
                    )),
                SizedBox(
                  height: size.height * 0.01,
                  child: VerticalDivider(
                    color: Color(0xffbdbdbd),
                    //color of divider
                    width: 10,
                    //width space of divider
                    thickness: 1,
                    //thickness of divier line
                    indent: 10,
                    //Spacing at the top of divider.
                    endIndent: 10, //Spacing at the bottom of divider.
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ));
                    },
                    child: Text(
                      "회원가입",
                      style: TextStyle(color: Color(0xffbdbdbd)),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: Text(
              "다른 방법으로 로그인 하기",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )),
            SizedBox(height: size.height * 0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: size.width * 0.01),
                customImageButton(AssetImage("assets/images/kakao_btn.png"),
                    () async {
                  await loginWithKakao(context);
                }),
                customImageButton(AssetImage("assets/images/naver_btn.png"),
                    () {
                  print("clicked!!");
                }),
                customImageButton(AssetImage("assets/images/facebook_btn.png"),
                    () {
                  print("clicked!!");
                }),
                SizedBox(width: size.width * 0.01),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> loginWithKakao(BuildContext context) async {
    bool isLogined = await KakaoLogin().login();
    if (isLogined) {
      kakao.User user = await kakao.UserApi.instance.me();
      final result = await FirebaseFirestore.instance
          .collection("users")
          .doc("kakao${user!.id}")
          .get();
      if (result.data() == null) {  //첫 카카오 로그인인 경우
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => SocialSignUpPage(
                      serviceName: "kakao",
                      uid: user!.id,
                    ))));
      } else {  //이전에 로그인을 하여 회원가입 정보를 넣은 경우
        final url = Uri.parse('https://foggy-boundless-avenue.glitch.me/signin');
        try{
          http.Response response = await http.post(
            url,
            headers: <String, String> {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: <String, String> {
              'uid': "kakao${user.id}",
            },
          );
          if(response.statusCode == 200){
            Map<String,dynamic> jsonData = jsonDecode(response.body);
            try{
              FirebaseAuth.instance.signInWithCustomToken(jsonData["token"]);
            }catch(e){
              logger.w(e);
            }
          }
        }catch(e){
          logger.w(e);
        }
      }
    }
  }
}
