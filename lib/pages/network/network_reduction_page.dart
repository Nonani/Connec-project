import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/style/buttonstyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../style/contextstyle.dart';

class NetworkReductionPage extends StatelessWidget {
  String uid = "";
  int acquitances = 0;

  NetworkReductionPage(this.uid, this.acquitances, {Key? key})
      : super(key: key);

  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return const SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                toolbarHeight: 56,
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color(0xff5f66f2),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              extendBodyBehindAppBar: true,
              body: Center(
                child: Column(children: [
                  Container(
                      width: double.infinity,
                      height: 250,
                      child: Image.network("")),
                  Container(
                      height: 450,
                      width: 330,
                      margin: const EdgeInsets.only(top: 13, bottom: 10.5),
                      child: SingleChildScrollView(
                          child: Column(children: [
                            Container(
                              padding: EdgeInsets.only(top: 13, bottom: 13),
                              child: Text(
                                snapshot.data['name'],
                                style: const TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 21,
                                  fontFamily: 'EchoDream',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              width: 336,
                              height: 0,
                              margin: const EdgeInsets.only(
                                  top: 7.5, bottom: 10.5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xff5f66f2),
                                  width: 1,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                              const EdgeInsets.only(left: 17.5, right: 17.5),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 13),
                                    child: const Text(
                                      '네트워크 정보',
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 16,
                                        fontFamily: 'EchoDream',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "지인 평점", style: contextKey),
                                          Text("지인 수", style: contextKey),
                                          Text("지인 대표 분야",
                                              style: contextKey)
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .end,
                                        children: [
                                          Text("${snapshot.data['rate']}/5.0",
                                              style: contextValue),
                                          Text(acquitances.toString(),
                                              style: contextValue),
                                          Text(snapshot.data['personality'][0],
                                              style: contextValue)
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: 336,
                                    height: 0,
                                    margin: const EdgeInsets.only(
                                        top: 7.5, bottom: 10.5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xffdbdbdb),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 13),
                                    child: const Text(
                                      '개인정보',
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 16,
                                        fontFamily: 'EchoDream',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text("이름", style: contextKey),
                                          Text(
                                              "직군/직무", style: contextKey),
                                          Text("경력", style: contextKey),
                                          Text("활동지", style: contextKey),
                                          Text("성별", style: contextKey),
                                          Text("나이", style: contextKey),
                                          Text("능력", style: contextKey),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .end,
                                        children: [
                                          Text(snapshot.data['name'],
                                              style: contextValue),
                                          Text(snapshot.data['personality'][0],
                                              style: contextValue),
                                          Text(snapshot.data['work'],
                                              style: contextValue),
                                          Text(snapshot.data['location'],
                                              style: contextValue),
                                          Text(snapshot.data['gender'],
                                              style: contextValue),
                                          Text(snapshot.data['age'],
                                              style: contextValue),
                                          Text(snapshot.data['introduction'],
                                              style: contextValue),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]))),
                ]),
              ),
              bottomNavigationBar: ElevatedButton(
                onPressed: () async {
                  FirebaseFirestore db = FirebaseFirestore.instance;
                  db
                      .collection('networks')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({'list': FieldValue.arrayRemove([uid])});
                  db
                      .collection('networks')
                      .doc(uid)
                      .update({
                    'list': FieldValue.arrayRemove(
                        [FirebaseAuth.instance.currentUser!.uid])
                  });
                  Navigator.of(context).pop();
                },
                style: featureButton,
                child: Text('삭제하기',
                  style: buttonText,
                ),
              ),
            );
          }
        });
  }

  Future _future() async {
    logger.w(uid);
    FirebaseFirestore db = FirebaseFirestore.instance;
    var user = await db.collection('users').doc(uid).get();
    var result = user.data();
    return result;
  }
}
