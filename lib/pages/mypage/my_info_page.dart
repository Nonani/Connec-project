import 'package:connec/components/custom_dialog.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../project_regist_page.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CustomLoadingDialog();
        } else {
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
                onPressed: () => FirebaseAuth.instance.signOut(),
              ),
              title: Text(
                '마이페이지',
                style: featureTitle,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 200,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 110, right: 110, top: 35, bottom: 45),
                        child: Image.network(snapshot.data["profile_image_url"]),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffafafaf),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Text(
                          "${snapshot.data["name"]}",
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text("${snapshot.data["work"]}"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10.0, right: 10, bottom: 10),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "프로젝트 키워드",
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 17,
                        fontFamily: 'EchoDream',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "#AI #머신러닝 #HR테크 #자연어처리\n#블록체인 #앱서비스 #백엔드",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontFamily: 'EchoDream',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10.0, right: 10, bottom: 10),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "개인정보",
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 17,
                        fontFamily: 'EchoDream',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "나 이 : ${snapshot.data["age"]}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontFamily: 'EchoDream',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "성 별 : ${snapshot.data["gender"]}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontFamily: 'EchoDream',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "전화번호 : ${snapshot.data["phone_number"]}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontFamily: 'EchoDream',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "활동지역 : ${snapshot.data["location"]}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontFamily: 'EchoDream',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10.0, right: 10, bottom: 10),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "프로젝트\t",
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 17,
                                fontFamily: 'EchoDream',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "※ 최대 10개",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontFamily: 'EchoDream',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProjectRegistPage(),
                                  ));
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future _future() async {
    Logger logger = Logger();

    final url =
        Uri.parse('https://foggy-boundless-avenue.glitch.me/mypage/info');
    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'uid': FirebaseAuth.instance.currentUser!.uid.toString(),
        },
      );
      logger.w(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      logger.w(e);
    }

    return null;
  }
}
