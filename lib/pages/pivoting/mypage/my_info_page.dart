import 'package:connec/components/custom_dialog.dart';
import 'package:connec/style/divider_style.dart';
import 'package:connec/style/icon_style.dart';
import 'package:connec/style/padding_style.dart';
import 'package:connec/style/text_style.dart';
import 'package:connec/style/title_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
              iconTheme: IconThemeData(color: Color(0xff5f66f2)),
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
                          color: Color(0xff5f66f2),
                        ),
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
                               return completeDialog(
                                   "마이페이지 링크가\n 복사되었습니다",
                                   "프로젝트 경험을 공유해보세요"
                               );
                            });
                      }),
                  ListTile(
                    title: Text('로그아웃'),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('회원탈퇴'),
                    onTap: () async {
                      final url = Uri.parse(
                          'https://foggy-boundless-avenue.glitch.me/unregister');
                      await http.post(
                        url,
                        headers: <String, String>{
                          'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: <String, String>{
                          'uid':
                              FirebaseAuth.instance.currentUser!.uid.toString(),
                        },
                      ).then((res) {
                        FirebaseAuth.instance.signOut();
                        Navigator.pop(context);
                      });
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
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffafafaf),
                        ),
                        child:
                            Image.network(snapshot.data["profile_image_url"]),
                      ),
                    ),
                  ),
                  Container(
                      margin: bottomPadding10,
                      child: Center(
                        child: Text(
                          "${snapshot.data["name"]}",
                          style: labelStyle
                        ),
                      )),
                  Container(
                    margin: bottomPadding10,
                    child: Center(
                      child: Text("${snapshot.data["work"]}",
                        style: contextStyle
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10.0, right: 10, bottom: 10),
                    child: greyDivider
                  ),
                  Container(
                    margin: leftPadding20,
                    child: Text(
                      "프로젝트 키워드",
                      style: labelStyle
                    ),
                  ),
                  Container(
                    margin: leftPadding30,
                    child: Text(
                      "#${snapshot.data['project_keyword']} ",
                      style: contextStyle
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10.0, right: 10, bottom: 10),
                    child: greyDivider
                  ),
                  Container(
                    margin: leftPadding20,
                    child: Text(
                      "개인정보",
                      style: labelStyle
                    ),
                  ),
                  Container(
                    margin: leftPadding30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "생년월일 : ${snapshot.data["age"].substring(0, 10)}",
                          style: contextStyle
                        ),
                        Text(
                          "성 별  : ${snapshot.data["gender"]}",
                          style: contextStyle
                        ),
                        Text(
                          "전화번호 : ${snapshot.data["phone_number"]}",
                          style: contextStyle
                        ),
                        Text(
                          "활동지역 : ${snapshot.data["location"]}",
                          style: contextStyle
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10.0, right: 10, bottom: 10),
                    child: greyDivider
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
                                style: labelStyle
                              ),
                              Text(
                                "※ 최대 10개",
                                style: constraintStyle
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ProjectRegistPage(),
                                    )).then((value) => setState(() {}));
                              },
                              icon: addIcon
                          )
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
                                  margin: topPadding10,
                                  child: Text(
                                    "프로젝트 ${idx + 1}",
                                    style: indexStyle
                                  )),
                              TextButton(
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
                                    style: linkStyle
                                  )),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 10),
                                child: greyDivider
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
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> keywords = data['project_keyword'];
      data['project_keyword'] = keywords.keys.toList(growable: false)
        ..sort((k1, k2) => keywords[k2].compareTo(keywords[k1]));
      data['project_keyword'] = data['project_keyword'].join(" #");
      logger.w(data);
      return data;
    } catch (e) {
      logger.w(e);
    }

    return null;
  }
}
