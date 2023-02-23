import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class ContactDetailPage extends StatefulWidget {
  const ContactDetailPage({Key? key, required this.notice, required this.type})
      : super(key: key);
  final Map<String, dynamic> notice;
  final String type;

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  Logger logger = Logger();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            )),
        shape: const Border(
            bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        title: Text(
          '알림 확인',
          style: featureTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 24, top: 48),
              child: Text(
                '${widget.notice['from']}이 내 지인에게\n요청을 하였습니다.',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 20,
                  fontFamily: 'S-CoreDream-6',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 26, top: 36),
              child: Text(
                '나의 지인에 대한 정보 확인',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 7,
                left: 26,
                right: 26,
              ),
              decoration: BoxDecoration(
                color: Color(0xffeeeeee),
                border: Border(
                  top: BorderSide(
                    color: Color(0xff5f66f2),
                    width: 1.5,
                  ),
                  bottom: BorderSide(
                    color: Color(0xff5f66f2),
                    width: 1.5,
                  ),
                ),
              ),
              child: FutureBuilder(
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(
                          top: 15, left: 76, right: 76, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '내 지인',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // SizedBox(
                          //   height: 8,
                          // ),
                          // Text(
                          //   '웹개발',
                          //   style: TextStyle(
                          //     color: Color(0xff333333),
                          //     fontFamily: 'S-CoreDream-5',
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '관계',
                                style: TextStyle(
                                    color: Color(0xffafafaf),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '한 다리',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '평점',
                                style: TextStyle(
                                    color: Color(0xffafafaf),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '${snapshot.data['rate']} / 5.0',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '능력',
                                style: TextStyle(
                                    color: Color(0xffafafaf),
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '한 다리',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  }
                },
                future: _future(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 26, top: 20),
              child: Text(
                '${widget.notice["to"]}의 메시지',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(18),
              margin: EdgeInsets.only(
                top: 7,
                left: 26,
                right: 26,
              ),
              decoration: BoxDecoration(
                color: Color(0xffeeeeee),
                border: Border(
                  top: BorderSide(
                    color: Color(0xff5f66f2),
                    width: 1.5,
                  ),
                  bottom: BorderSide(
                    color: Color(0xff5f66f2),
                    width: 1.5,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  '${widget.notice["context"]}',
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 26, top: 30),
              child: widget.type == "member"
                  ? Text(
                      '오픈채팅방 링크를 지인에게 공유해주세요',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : Text(
                      '수락 후 아래의 오픈채팅방 링크로 연락하세요',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
            Container(
              padding: EdgeInsets.all(18),
              margin: EdgeInsets.only(
                top: 7,
                left: 26,
                right: 26,
              ),
              decoration: BoxDecoration(
                color: Color(0xffeeeeee),
                border: Border(
                  top: BorderSide(
                    color: Color(0xff5f66f2),
                    width: 1.5,
                  ),
                  bottom: BorderSide(
                    color: Color(0xff5f66f2),
                    width: 1.5,
                  ),
                ),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Clipboard.setData(
                        ClipboardData(text: '${widget.notice["chatLink"]}'));
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        // The background color
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '코드가 클립보드에\n복사되었습니다',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("확인"))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    '${widget.notice["chatLink"]}',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                contactAccept(widget.notice);
                Navigator.pop(context);
              },
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Color(0xff5f66f2),
                ),
                child: Center(
                  child: Text(
                    '수락',
                    style: TextStyle(
                        color: Color(0xfffafafa),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                contactReject(widget.notice);
                Navigator.pop(context);
              },
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Color(0xff5f66f2),
                ),
                child: Center(
                  child: Text(
                    '거절',
                    style: TextStyle(
                        color: Color(0xfffafafa),
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future _future() async {
    final result =
        await db.collection("member").doc(widget.notice["member_id"]).get();
    logger.w(result.data);
    logger.w(widget.notice);
    return result.data();
  }

  void contactAccept(Map<String, dynamic> notice) {
    db.collection('notification').doc(notice["from_uid"]).update({
      'list': FieldValue.arrayRemove([notice])
    });
    db.collection('notification').doc(notice["to_uid"]).update({
      'list': FieldValue.arrayRemove([notice])
    });
    notice["state"] = "accepted";
    //수정된 값 인덱스 추가
    db.collection('notification').doc(notice["from_uid"]).update({
      'list': FieldValue.arrayUnion([notice])
    });
    db.collection('notification').doc(notice["to_uid"]).update({
      'list': FieldValue.arrayUnion([notice])
    });
  }

  void contactReject(Map<String, dynamic> notice) {
    db.collection('notification').doc(notice["from_uid"]).update({
      'list': FieldValue.arrayRemove([notice])
    });
    db.collection('notification').doc(notice["to_uid"]).update({
      'list': FieldValue.arrayRemove([notice])
    });
    notice["state"] = "rejected";
    //수정된 값 인덱스 추가
    db.collection('notification').doc(notice["from_uid"]).update({
      'list': FieldValue.arrayUnion([notice])
    });
    db.collection('notification').doc(notice["to_uid"]).update({
      'list': FieldValue.arrayUnion([notice])
    });
  }
}
