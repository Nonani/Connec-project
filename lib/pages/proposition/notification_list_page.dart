import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/mypage/report_page.dart';
import 'package:connec/style/Notification/contextStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;

class NoticeListPage extends StatefulWidget {
  const NoticeListPage({Key? key}) : super(key: key);

  @override
  State<NoticeListPage> createState() => _NoticeListPageState();
}

class _NoticeListPageState extends State<NoticeListPage> {
  final db = FirebaseFirestore.instance;
  bool isSendState = true;
  bool isCompleteState = false;
  Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 56,
        backgroundColor: const Color(0xfffafafa),
        shape: const Border(
            bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff5f66f2),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '제안 현황',
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 20,
            fontFamily: 'S-CoreDream-5Medium',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print(isSendState);
                          if (!isSendState) {
                            setState(() {
                              isSendState = true;
                            });
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: isSendState
                                ? BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xff5f66f2),
                                        width: 2,
                                      ),
                                    ),
                                  )
                                : null,
                            child: !isSendState
                                ? Text(
                                    '보낸 제안',
                                    style: TextStyle(
                                      color: Color(0xffdbdbdb),
                                      fontSize: 18,
                                      fontFamily: 'S-CoreDream-5',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    '보낸 제안',
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 18,
                                      fontFamily: 'S-CoreDream-6',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                      ),
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        if (isSendState) {
                          setState(() {
                            isSendState = false;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: !isSendState
                            ? BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xff5f66f2),
                                    width: 2,
                                  ),
                                ),
                              )
                            : null,
                        child: !isSendState
                            ? Text(
                                '받은 제안',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 18,
                                  fontFamily: 'S-CoreDream-6',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : Text(
                                '받은 제안',
                                style: TextStyle(
                                  color: Color(0xffdbdbdb),
                                  fontSize: 18,
                                  fontFamily: 'S-CoreDream-5',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ))
                  ],
                )),
            const SizedBox(
              height: 12,
            ),
            FutureBuilder(
              future: _future(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  logger.w(snapshot.data.length);
                  if (isSendState) {
                    return Flexible(
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data["send"].length,
                        itemBuilder: (context, index) {
                          return buildSendItem(snapshot.data["send"], index);
                        },
                      ),
                    );
                  } else {
                    return Flexible(
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data["receive"].length,
                        itemBuilder: (context, index) {
                          return buildReceiveItem(
                              snapshot.data["receive"], index);
                        },
                      ),
                    );
                  }
                } else {
                  return const Expanded(
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(),
          ),
          ToggleSwitch(
              minWidth: 90.0,
              minHeight: 40.0,
              cornerRadius: 20.0,
              activeBgColor: [Color(0xff5f66f2)],
              activeFgColor: Colors.white,
              inactiveBgColor: Color(0x29000000),
              inactiveFgColor: Color(0xff666666),
              labels: ['진행 중', '진행완료'],
              onToggle: (index) {
                isCompleteState = index == 0 ? false : true;
              }),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  GestureDetector buildReceiveItem(List<dynamic> data, int index) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.only(left: 12, top: 12, bottom: 15),
        decoration: const BoxDecoration(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildReceiveItemTitle(data, index),
                buildItemPopupMenu(data, index)
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 7, top: 13),
              child: Column(
                children: [
                  buildItemState(data, index),
                  const SizedBox(
                    height: 7,
                  ),
                  buildItemTime(data, index)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  buildSendItem(List<dynamic> data, int index) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(left: 12, top: 12, bottom: 15),
        decoration: const BoxDecoration(
          color: Color(0xfffafafa),
          boxShadow: [
            BoxShadow(
              color: Color(0x29000000),
              offset: Offset(1, 1),
              blurRadius: 15,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${data[index]['primary']}',
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  '${data[index]['secondary']}',
                  style: TextStyle(
                    color: Color(0xffafafaf),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.network(
                  data[index]['urlImage'],
                  width: 100,
                  height: 100,
                ),
                Column(
                  children: [
                    Text(
                      '진행 상태',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '이름',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '전화번호',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '제안 목적',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      '제안 날짜',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      data[index]['state'],
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      data[index]['name'],
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      data[index]['number'],
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      data[index]['purpose'],
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      data[index]['date'],
                      style: TextStyle(
                          color: Color(0xff666666),
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Text buildReceiveItemTitle(List<dynamic> data, int index) {
    String text = "";
    text = '${data[index]['name']}님이 나에게 요청';

    return Text(text, style: contextTitle);
  }

  Text buildSendItemTitle(List<dynamic> data, int index) {
    String text = "";

    text = '내가 ${data[index]['name']}에게 요청';

    return Text(text, style: contextTitle);
  }

  Row buildItemState(List<dynamic> data, int index) {
    String text = "";
    if (data[index]['state'] == 'waiting') {
      text = '미확인';
    } else if (data[index]['state'] == 'rejected') {
      text = '거절';
    } else {
      text = '수락';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('상태', style: contextKey),
        const SizedBox(
          width: 8,
        ),
        Text(text, style: contextValue)
      ],
    );
  }

  Row buildItemTime(List<dynamic> data, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('시간', style: contextKey),
        const SizedBox(
          width: 8,
        ),
        Text(data[index]['date'], style: contextValue),
      ],
    );
  }

  PopupMenuButton buildItemPopupMenu(List<dynamic> data, int index) {
    List<String> menu = ['제안확정', '신고하기'];
    return PopupMenuButton<String>(
      // Callback that sets the selected popup menu item.
      onSelected: (String item) {
        if (item == "제안확정") {
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportPage(
                  to: data[index]['to'],
                  from: FirebaseAuth.instance.currentUser!.uid,
                ),
              ));
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: menu[0],
          child: Text(menu[0]),
        ),
        PopupMenuItem<String>(
          value: menu[1],
          child: Text(menu[1]),
        ),
      ],
    );
  }

  Future _future() async {
    final url =
        Uri.parse('https://foggy-boundless-avenue.glitch.me/proposition/list');
    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{'uid': FirebaseAuth.instance.currentUser!.uid},
      );
      logger.w(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      logger.w(e);
    }
    return null;
  }
}
