import 'package:connec/components/custom_dialog.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../legacy/network/expand_network_page.dart';

import '../project/project_detail_page.dart';
import '../project/project_regist_page.dart';
import 'edit_myinfo_page.dart';

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
          return customLoadingDialog();
        } else {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.blue),
              elevation: 0,
              toolbarHeight: 80,
              backgroundColor: const Color(0xfffafafa),
              shape: const Border(
                  bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
              title: Text(
                '마이페이지',
                style: featureTitle,
              ),
              centerTitle: true,
            ),
            endDrawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 230),
                      width: 100,
                      height: 100,
                      child: DrawerHeader(
                        child: Image.asset(
                          "assets/images/connec_logo2.png",
                          color: Colors.blue,
                        ),
                        margin: EdgeInsets.all(0.0),
                        padding: EdgeInsets.all(0.0),
                      )),
                  ListTile(
                    title: Text('수정하기'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditMyInfoPage(
                                snapshot.data["location"],
                                snapshot.data["work"]),
                          )).then((value) => setState(() {}));
                    },
                  ),
                  ListTile(
                      title: Text('공유하기'),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.of(context).pop(true);
                              });
                              return Dialog(
                                // The background color
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: Icon(Icons.check_circle,
                                              size: 100,
                                              color: Color(0xff5f66f2))),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              '프로젝트 참여 동의서 작성\n   링크가 복사되었습니다',
                                              style: TextStyle(
                                                color: Color(0xff333333),
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                  "프로젝트의 경험을 공유해보세요",
                                                  style: TextStyle(
                                                    color: Color(0xff333333),
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ))
                                          ]),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }),
                  ListTile(
                    title: Text('코드 입력하기'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpandNetworkPage()));
                    },
                  ),
                  ListTile(
                    title: Text('로그아웃'),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('회원탈퇴'),
                    onTap: () async{
                      Logger logger = Logger();
                      final url =
                      Uri.parse('https://foggy-boundless-avenue.glitch.me/unregister');
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
                      } catch (e) {
                        logger.w(e);
                      }
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
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
                        child:
                            Image.network(snapshot.data["profile_image_url"]),
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
                          "생년월일 : ${snapshot.data["age"].substring(0,10)}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontFamily: 'EchoDream',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "성 별  : ${snapshot.data["gender"]}",
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
                    child: Column(children: [
                      Row(
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
                                    )).then((value) => setState(() {}));
                              },
                              icon: Icon(
                                Icons.add_circle,
                                color: Colors.blue,
                              ))
                        ],
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data['projects'].length <= 10
                              ? snapshot.data['projects'].length
                              : 10,
                          itemBuilder: (BuildContext context, int idx) {
                            Map<String, dynamic> item =
                                snapshot.data['projects'][idx];
                            return Column(children: [
                              Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    item['name'],
                                    style: TextStyle(
                                        fontFamily: 'EchoDream', fontSize: 17),
                                  )),
                              Container(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProjectDetailPage(
                                                      idx,
                                                        item["docId"],
                                                        snapshot
                                                            .data['name'])));
                                      },
                                      child: Text(
                                        item['introduction'],
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline),
                                      ))),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                ),
                              ),
                            ]);
                          })
                    ]),
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
