import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/main.dart';
import 'package:connec/pages/searchpage/contact_detail_page.dart';
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
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //알림창 리스트 안에 들어갈 아이템 위젯을 관리하는 클래스
    switch (widget.notice["case"]) {
      case "network":
        if (widget.notice["from_uid"] !=
            FirebaseAuth.instance.currentUser!.uid.toString()) {
          return ReceiveNetworkRequest(widget.notice);
        } else {
          return SentNetworkRequest(widget.notice);
        }
      case "contact":
        if (widget.notice["from_uid"] !=
            FirebaseAuth.instance.currentUser!.uid.toString()) {
          //보낸 사람

          return (widget.notice["member_id"] == '')
              ? ReceiveContactUserRequest(widget.notice)
              : ReceiveContactMemberRequest(widget.notice);
        } else {
          return Container();
          // return ReceiveContactUserRequest(widget.notice);
          // return SentContactRequest(widget.notice);
        }
      default:
        return Container();
    }
  }

  Widget ReceiveNetworkRequest(Map<String, dynamic> notice) {
    Logger logger = Logger();

    try {
      switch (notice["state"]) {
        case "waiting":
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 4),
                Expanded(child: Text("${notice["from"]}님이 네트워크 요청을 보냈습니다.")),
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
                          notice["state"] = "accepted";
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
                          db
                              .collection('networks')
                              .doc(notice['from_uid'])
                              .update({
                            'list': FieldValue.arrayUnion([notice['to_uid']])
                          });
                          db
                              .collection('networks')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({
                            'list': FieldValue.arrayUnion([notice['from_uid']])
                          });
                          Navigator.push(
                              context,
                              DialogRoute(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("요청 수락"),
                                        content: Text(
                                            "${notice["from_uid"]}님의 네트워크 요청을 수락하였습니다."),
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
                        onPressed: () {
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
                          notice["state"] = "rejected";
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
                                        title: Text("요청 거절"),
                                        content: Text(
                                            "${notice["from_uid"]}님의 네트워크 요청을 거절하였습니다."),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text("Close")),
                                        ],
                                      ))).then((value) => setState(() {}));
                        },
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
      switch (notice["state"]) {
        case "waiting":
          return Container(
            child: Text("${notice["to"]}님이 네트워크 요청을 확인중입니다."),
          );
        case "rejected":
          return Container(
            child: Text("${notice["to"]}님이 네트워크 요청을 거절하였습니다."),
          );
        case "accepted":
          return Container(
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 15,
                  ),
                  child: Text(
                    '${notice["to"]}이 네트워크 요청을 거절했습니다.',
                    style: TextStyle(
                      color: Color(0xff333333),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await db
                        .collection('notification')
                        .doc(notice["from_uid"])
                        .update({
                      'list': FieldValue.arrayRemove([notice])
                    });
                    notice['state'] = 'confirmed';
                    await db
                        .collection('notification')
                        .doc(notice["from_uid"])
                        .update({
                      'list': FieldValue.arrayUnion([notice])
                    });
                    //db에서 case network -> checked_network
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, top: 15, right: 5),
                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                    decoration: BoxDecoration(
                      color: Color(0xff5f66f2),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Text(
                      '확인완료',
                      style: TextStyle(
                        color: Color(0xfffafafa),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        default:
          return Container();
      }
    } catch (e) {
      logger.w(e);
      return Container();
    }
  }

  Widget ReceiveContactMemberRequest(Map<String, dynamic> notice) {
    Logger logger = Logger();

    try {
      switch (notice["state"]) {
        case "waiting":
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 4),
                Expanded(
                    child: Text(
                        "${notice["from"]}님이 ${notice["to"]}님의 지인에 대한 제안 요청을 하였습니다.")),
                Row(
                  children: [
                    IconButton(
                        iconSize: 8,
                        onPressed: () {
                          // 기존 값 인덱스 삭제
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactDetailPage(
                                  notice: notice,
                                  type: "member",
                                ),
                              ));
                        },
                        icon: Image.asset("assets/images/accept_btn.png")),
                    IconButton(
                        iconSize: 8,
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

  Widget ReceiveContactUserRequest(Map<String, dynamic> notice) {
    Logger logger = Logger();

    try {
      switch (notice["state"]) {
        case "waiting":
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 4),
                Expanded(
                    child: Text(
                        "${notice["from"]}님이 ${notice["to"]}에게 제안 요청을 하였습니다.")),
                Row(
                  children: [
                    IconButton(
                        iconSize: 8,
                        onPressed: () {
                          // 기존 값 인덱스 삭제
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContactDetailPage(
                                    notice: notice, type: "user"),
                              ));
                        },
                        icon: Image.asset("assets/images/accept_btn.png")),
                    IconButton(
                        iconSize: 8,
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
}
