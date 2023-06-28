import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/proposition/contact_report_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import '../../components/custom_dialog.dart';
import '../../style/Member/contextstyle.dart';
import '../../style/buttonstyle.dart';

class ContactSendAcceptedPage extends StatefulWidget {
  const ContactSendAcceptedPage(this.data, {Key? key}) : super(key: key);
  final dynamic data;

  @override
  State<ContactSendAcceptedPage> createState() => _ContactSendAcceptedPageState();
}

class _ContactSendAcceptedPageState extends State<ContactSendAcceptedPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xfffafafa),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff5f66f2),
        elevation: 0,
        title: Text(
          '제안 세부내용',
          style: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CustomLoadingDialog();
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 18),
                    child: Text(
                      '▶ 인재의 개인정보',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      margin: EdgeInsets.only(
                          left: 80, right: 80, top: 18, bottom: 20),
                      child: Image.network(
                        "${widget.data["urlImage"]}",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${widget.data["primary"]}',
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 21,
                        fontFamily: 'S-CoreDream-6Bold',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${widget.data["primary"]} > ${widget.data["secondary"]}',
                      style: TextStyle(
                        color: Color(0xffafafaf),
                        fontSize: 12,
                        fontFamily: 'S-CoreDream-4Regular',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Container(
                    height: 0,
                    margin: EdgeInsets.only(
                        top: 30, left: 17.5, right: 17.5, bottom: 30),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff5f66f2),
                        width: 1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '평점',
                          style: TextStyle(
                            color: Color(0xffafafaf),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-4Regular',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Text(
                          '${snapshot.data["rate"]} / 5.0',
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-5',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 30, right: 30),
                      child: Column(
                          children: workSection(snapshot.data['workArea'],
                              snapshot.data['career']))),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '지역',
                          style: TextStyle(
                            color: Color(0xffafafaf),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-4Regular',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Text(
                          '${snapshot.data["location"]}',
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-5',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '성별',
                          style: TextStyle(
                            color: Color(0xffafafaf),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-4Regular',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Text(
                          snapshot.data["gender"],
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-5',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '나이',
                          style: TextStyle(
                            color: Color(0xffafafaf),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-4Regular',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Text(
                          snapshot.data["age"],
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-5',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, bottom: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '직업',
                          style: TextStyle(
                            color: Color(0xffafafaf),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-4Regular',
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        Text(
                          snapshot.data["work"],
                          style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-5',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 18),
                    child: Text(
                      '▶ 제안 보낸 내용',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 26, top: 18),
                    child: Text(
                      '제안 목적',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 16,
                        fontFamily: 'S-CoreDream-5',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      left: 26,
                      right: 26,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffeeeeee),
                    ),
                    child: Center(child: Text(widget.data["context"])),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 26, top: 18),
                    child: Text(
                      '제안 내용',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: 16,
                        fontFamily: 'S-CoreDream-5',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      left: 26,
                      right: 26,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffeeeeee),
                    ),
                    child: Text(widget.data["purpose"]),
                  ),
                  Container(
                    height: 57,
                    margin: EdgeInsets.only(top: 50, bottom: 20),
                    padding: EdgeInsets.only(left: 26, right: 26),
                    decoration: BoxDecoration(
                      color: Color(0xffe2e2e2).withOpacity(0.38999998569488525),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '진행 상태',
                          style: TextStyle(
                            color: Color(0xff333333),
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '제안 승낙',
                          style: TextStyle(
                            color: Color(0xff5f66f2),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
        future: _future(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xff5f66f2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: ElevatedButton(
                style: featureButton,
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ContactReportPage(),));
                },
                child: Text(
                  '평가',
                  style: TextStyle(
                    color: Color(0xfffafafa),
                    fontSize: 20,
                    fontFamily: 'S-CoreDream-4',
                  ),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: featureButton,
                onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactReportPage(to_uid: widget.data!['to_uid'], name: widget.data!['to_uid'])));
                },
                child: Text(
                  '신고',
                  style: TextStyle(
                    color: Color(0xfffafafa),
                    fontSize: 20,
                    fontFamily: 'S-CoreDream-4',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> workSection(List<dynamic> workArea, List<dynamic> career) {
    List<Widget> result = [];
    for (int index = 0; index < workArea.length * 2; index++) {
      String text = index > 0 ? "" : "전문분야";
      String data = index % 2 == 0 ? workArea[index ~/ 2] : career[index ~/ 2];
      result.add(
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          text,
          style: contextKey,
        ),
        Text(
          data,
          style: contextValue,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ]));
      result.add(
        SizedBox(
          height: 10,
        ),
      );
    }
    return result;
  }

  Future? _future() async {
    Logger logger = Logger();
    logger.w(widget.data);
    final url = Uri.parse(
        'https://foggy-boundless-avenue.glitch.me/proposition/detail');
    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'uid': "${widget.data!['to_uid']}",
        },
      );
      return jsonDecode(response.body);
    } catch (e) {
      print("Error getting document: $e");
    }
    return null;
  }
}
