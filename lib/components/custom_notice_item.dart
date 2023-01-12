import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CustomNoticeItem extends StatefulWidget {
  const CustomNoticeItem({Key? key, required this.notice}) : super(key: key);
  final Map<String, dynamic> notice;

  @override
  State<CustomNoticeItem> createState() => _CustomNoticeItemState();
}

class _CustomNoticeItemState extends State<CustomNoticeItem> {
  @override
  Widget build(BuildContext context) {
    if(widget.notice["from_uid"] !=FirebaseAuth.instance.currentUser!.uid.toString())
      return ReceiveNetworkRequest(widget.notice);
    else return SentNetworkRequest(widget.notice);
  }

  Widget ReceiveNetworkRequest(Map<String, dynamic> notice) {
    final db = FirebaseFirestore.instance;
    Logger logger = Logger();

    try {
      switch (notice["case"]) {
        case "waiting":
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 4),
                Expanded(child: Text("${notice["from"]}님이 요청을 보냈습니다.")),
                Row(
                  children: [
                    IconButton(
                        iconSize: 10,
                        onPressed: () async {
                          // 기존 값 인덱스 삭제
                          db
                              .collection('notification')
                              .doc(notice["from_uid"])
                              .update({
                            'list': FieldValue.arrayRemove([notice])
                          });
                          db
                              .collection('notification')
                              .doc(notice["to_uid"])
                              .update({
                            'list': FieldValue.arrayRemove([notice])
                          });
                          notice["case"] = "accepted";
                          //수정된 값 인덱스 추가
                          db
                              .collection('notification')
                              .doc(notice["from_uid"])
                              .update({
                            'list': FieldValue.arrayUnion([notice])
                          });
                          db
                              .collection('notification')
                              .doc(notice["to_uid"])
                              .update({
                            'list': FieldValue.arrayUnion([notice])
                          });
                          Navigator.push(
                              context,
                              DialogRoute(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("요청 수락"),
                                    content: Text(
                                        "${notice["from_uid"]}님의 요청을 수락하였습니다."),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Close")),
                                    ],
                                  ))).then((value) => setState(() {}));
                        },
                        icon: Image.asset("assets/images/accept_btn.png")),
                    IconButton(
                        iconSize: 10,
                        onPressed: () {},
                        icon: Image.asset("assets/images/reject_btn.png")),
                  ],
                ),
              ]);
        case "rejected":
          return Container();
        case "accepted":
          return Container();
        default:
          return Container();
      }
    } catch (e) {
      logger.w(e);
      return Container();
    }
  }

  Widget SentNetworkRequest(Map<String, dynamic> notice) {
    Logger logger = Logger();
    try {
      switch (notice["case"]) {
        case "waiting":
          return Container(
            child: Text("${notice["to"]}님이 요청을 확인중입니다."),
          );
        case "rejected":
          return Container(
            child: Text("${notice["to"]}님이 요청을 거절하였습니다."),
          );
        case "accepted":
          return Container(
            child: Text("${notice["to"]}님이 요청을 수락하였습니다."),
          );
        default:
          return Container();
      }
    } catch (e) {
      logger.w(e);
      return Container();
    }
  }
}

