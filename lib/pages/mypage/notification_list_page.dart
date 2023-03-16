import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/mypage/report_page.dart';
import 'package:connec/style/Notification/contextStyle.dart';
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
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: ToggleSwitch(
                minWidth: 90.0,
                cornerRadius: 20.0,
                activeBgColors: const [
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
                    color: initialIndex == 0
                        ? const Color(0xfffafafa)
                        : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  TextStyle(
                    color: initialIndex != 0
                        ? const Color(0xfffafafa)
                        : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  )
                ],
                labels: const ['현재', '과거'],
                radiusStyle: true,
                onToggle: <int>(index) {
                  print('switched to: $index');

                  setState(() {
                    initialIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            FutureBuilder(
              future: _future(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  logger.w(snapshot.data.length);
                  return Flexible(
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return snapshot.data[index]['to_uid'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? buildReceiveItem(snapshot, index)
                            : buildSendItem(snapshot, index);
                      },
                    ),
                  );
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
    );
  }

  GestureDetector buildReceiveItem(AsyncSnapshot<dynamic> snapshot, int index) {
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
                buildReceiveItemTitle(snapshot, index),
                buildItemPopupMenu(snapshot, index)
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 7, top: 13),
              child: Column(
                children: [
                  buildItemState(snapshot, index),
                  const SizedBox(
                    height: 7,
                  ),
                  buildItemTime(snapshot, index)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  buildSendItem(AsyncSnapshot snapshot, int index) {
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
                buildSendItemTitle(snapshot, index),
                buildItemPopupMenu(snapshot, index)
              ],
            ),

            Container(
              padding: const EdgeInsets.only(left: 7, top: 13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildItemState(snapshot, index),
                  const SizedBox(height: 7),
                  buildItemTime(snapshot, index)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Text buildReceiveItemTitle(AsyncSnapshot snapshot, int index) {
    String text = "";
    if (snapshot.data[index]['member_id'] != '') {
      text = '${snapshot.data[index]['from']}님이 나의 지인에게 요청';
    } else {
      text = '${snapshot.data[index]['from']}님이 나에게 요청';
    }
    return Text(
        text,
        style: contextTitle
    );
  }
  Text buildSendItemTitle(AsyncSnapshot snapshot, int index) {
    String text = "";
    if (snapshot.data[index]['member_id'] != '') {
      text = '내가 ${snapshot.data[index]['to']}의 지인에게 요청';
    } else {
      text = '내가 ${snapshot.data[index]['to']}에게 요청';
    }
    return Text(
      text,
      style: contextTitle
    );
  }
  Row buildItemState(AsyncSnapshot snapshot, int index){
    String text = "";
    if (snapshot.data[index]['state'] == 'waiting') {
      text = '미확인';
    } else if(snapshot.data[index]['state'] == 'rejected') {
      text = '거절';
    } else {
      text = '수락';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '상태',
          style: contextKey
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: contextValue
        )
      ],
    );
  }
  Row buildItemTime(AsyncSnapshot snapshot, int index){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '시간',
          style: contextKey
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          snapshot.data[index]['date'],
          style: contextValue
        ),
      ],
    );
  }
  PopupMenuButton buildItemPopupMenu(AsyncSnapshot snapshot, int index){
    List<String> menu = ['제안확정', '신고하기' ];
    return PopupMenuButton<String>(
      // Callback that sets the selected popup menu item.
      onSelected: (String item) {
        if( item == "제안확정"){

        }
        else{
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ReportPage(to: snapshot.data[index]['to'], from: FirebaseAuth.instance.currentUser!.uid,),
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
            noticeItem['state'] == 'waiting') {
          list.add(noticeItem);
        }
      }
    } else {
      // 과거 알림 목록을 불러와야 할 때
      for (int i = 0; i < notice.data()!['list']!.length; i++) {
        var noticeItem = notice.data()!['list'][i];

        if (noticeItem['case'] == "contact" &&
            noticeItem['state'] != 'waiting') {
          list.add(noticeItem);
        }
      }
    }
    logger.w(list);

    return list;
  }

}
