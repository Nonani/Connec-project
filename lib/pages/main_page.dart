import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/common_bottom_navigation_bar.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../components/custom_notice_item.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Logger logger = Logger();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return CustomLoadingPage();
        } else {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    icon: Icon(Icons.link_sharp),
                    color: Color(0xff5f66f2),
                    onPressed: () async {
                      final db = FirebaseFirestore.instance;
                      final result = await db
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get();
                      logger.w(FirebaseAuth.instance.currentUser!.uid);
                      Clipboard.setData(ClipboardData(text: result["uuid"]));
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                  child:Icon(
                                  Icons.check_circle,
                                      size: 100,
                                      color: Color(0xff5f66f2))
                                  ),
                                  Text(
                                    '코드가 클립보드에\n  복사되었습니다.',
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      );
                    }),
              ],
              shape: const Border(
                  bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
              backgroundColor: Color(0xfffafafa),
              elevation: 0,
              title: Text(
                'CONNEC',
                style: connecTitle,
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 45, left: 23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '알림',
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 20,
                          fontFamily: 'S-CoreDream-6',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 20,
                        alignment: Alignment.center,
                        width: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xff5f66f2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          '${snapshot.data['list'].length}',
                          style: const TextStyle(
                            color: Color(0xfffafafa),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-6',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 143,
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 26,
                    right: 26,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xff5f66f2), width: 1.5),
                      bottom: BorderSide(color: Color(0xff5f66f2), width: 1.5),
                    ),
                    color: Color(0xffeeeeee),
                  ),
                  child: snapshot.data['list'].length == 0
                      ? Center(
                          child: Text(
                            '새로운 알림이 없습니다',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(children: [
                            ListView.builder(
                              shrinkWrap: true,
                              // 리스트 자식 높이 크기의 합 만큼으로 영역 고정
                              physics: const NeverScrollableScrollPhysics(),
                              // 스크롤 안되도록 설정하는 옵션 값
                              itemCount: snapshot.data['list'].length,
                              itemBuilder: (BuildContext context, int index) {
                                final notice = snapshot.data['list'][index];
                                return CustomNoticeItem(notice: notice);
                              },
                            ),
                          ]),
                        ),
                ),
              ],
            ),

            bottomNavigationBar: CommonBottomNavigationBar(),
          );
        }
      },
    );
  }

  Future _future() async {

    FirebaseFirestore db = FirebaseFirestore.instance;
    final result = await db
        .collection("notification")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    if (result.data() == null) return {"list": []};

    List list = [];
    for (int i = 0; i < result.data()!['list'].length; i++) {
      if (result.data()!['list'][i]['to_uid'] ==
              FirebaseAuth.instance.currentUser!.uid.toString() &&
          result.data()!['list'][i]['state'] == "waiting") {
        list.add(result.data()!['list'][i]);
      }
    }
    return {"list": list};
  }
}
