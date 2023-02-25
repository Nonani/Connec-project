import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:toggle_switch/toggle_switch.dart';

class NoticeListPage extends StatefulWidget {
  const NoticeListPage({Key? key}) : super(key: key);

  @override
  State<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends State<NoticeListPage> {
  final db = FirebaseFirestore.instance;
  int initialIndex = 0;
  Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: statusBarHeight),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30, top: 20),
              child: ToggleSwitch(
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeBgColors: [
                  [Color(0xff5f66f2)],
                  [Color(0xff5f66f2)],
                ],
                initialLabelIndex: initialIndex,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.white,
                inactiveFgColor: Colors.black,
                totalSwitches: 2,
                customTextStyles: [
                  TextStyle(
                    color: initialIndex == 0 ? Color(0xfffafafa) : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  TextStyle(
                    color: initialIndex != 0 ? Color(0xfffafafa) : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )
                ],
                labels: ['현재', '과거'],
                radiusStyle: true,
                onToggle: <int>(index) {
                  print('switched to: $index');

                  setState(() {
                    initialIndex = index;
                  });
                },
              ),
            ),
            SizedBox(
              height: 12,
            ),
            FutureBuilder(
              future: _future(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  logger.w(snapshot.data.length);
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(left: 12),
                          padding:
                              EdgeInsets.only(left: 12, top: 12, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              snapshot.data[index]['member_id'] == ''
                                  ? Text(
                                      '${snapshot.data[index]['to']}님의 지인',
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : Text(
                                      '${snapshot.data[index]['to']}',
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                              Text(
                                '디자인/개발 > 개발 외주 > 웹 개발',
                                style: TextStyle(
                                    color: Color(0xff999999),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 7, top: 13),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '상태',
                                          style: TextStyle(
                                              color: Color(0xffafafaf),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          snapshot.data[index]['state'] ==
                                                  'waiting'
                                              ? '미확인'
                                              : snapshot.data[index]['state'] ==
                                                      'reject'
                                                  ? '거절됨'
                                                  : '수락됨',
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '시간',
                                          style: TextStyle(
                                              color: Color(0xffafafaf),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          snapshot.data[index]['date'],
                                          style: TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xfffafafa),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x29000000),
                                offset: Offset(3, 3),
                                blurRadius: 15,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future _future() async {
    final notice = await db
        .collection("notification")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    List list = [];
    if (initialIndex == 0) {
      //  현재 알림 목록을 불러와야 할 때
      for (int i = 0; i < notice.data()!['list']!.length; i++) {
        var noticeItem = notice.data()!['list'][i];
        if (noticeItem['case'] == "contact" &&
            noticeItem['to_uid'] == FirebaseAuth.instance.currentUser!.uid &&
            noticeItem['state'] == 'waiting') {
          //제안이 대기중인 경우
          // if(noticeItem['member_uid'] !=''){
          //   //  유저와 멤버 간의 연락인 경우
          //   final member_info = (await db.collection("member").doc(noticeItem['member_id']).get()).data();
          //   logger.w(noticeItem['member_id']);
          // }else{
          //   // 유저와 유저 간의 연락인 경우
          // }
          list.add(noticeItem);
        }
      }
    } else {
      for (int i = 0; i < notice.data()!['list']!.length; i++) {
        var noticeItem = notice.data()!['list'][i];

        if (noticeItem['case'] == "contact" &&
            noticeItem['to_uid'] == FirebaseAuth.instance.currentUser!.uid &&
            noticeItem['state'] != 'waiting') {
          //제안이 대기중인 경우
          // if(noticeItem['member_uid'] !=''){
          //   //  유저와 멤버 간의 연락인 경우
          //   final member_info = (await db.collection("member").doc(noticeItem['member_id']).get()).data();
          //   logger.w(noticeItem['member_id']);
          // }else{
          //   // 유저와 유저 간의 연락인 경우
          // }
          list.add(noticeItem);
        }
      }
    }

    return list;
  }
}
