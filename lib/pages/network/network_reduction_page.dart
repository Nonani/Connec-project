import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_expansion_tile.dart';
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
                      height: 724,
                      width: 330,
                      margin: const EdgeInsets.only(top: 13, bottom: 10.5),
                      child: SingleChildScrollView(
                          child: Column(children: [
                            Container(
                                padding: EdgeInsets.only(top: 13, bottom: 13),
                                height: 224,
                                child: Column(children: [
                                  SizedBox(height: 121),
                                  Text(
                                    snapshot.data['name'],
                                    style: const TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 27,
                                      fontFamily: 'EchoDream',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 26),
                                ])),
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                                "지인 평점", style: contextKey),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                                "지인 수", style: contextKey),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10),
                                              child:
                                              Text("지인 성격", style: contextKey)),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .end,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(
                                                "${snapshot.data['rate']}/5.0",
                                                style: contextValue),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10),
                                            child: Text(acquitances.toString(),
                                                style: contextValue),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(
                                                  snapshot
                                                      .data['personality'][0],
                                                  style: contextValue)),
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
                                  Column(children: [
                                    Column(children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("이름", style: contextKey),
                                          Text(snapshot.data['name'], style: contextValue),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("평점", style: contextKey),
                                          Text("${snapshot.data['rate']} / 5.0", style: contextValue),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ]),
                                    Column(children: workSection(snapshot.data['workArea'])),
                                    Column(children: careerSection(snapshot.data['career'])),
                                    Column(children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("지역", style: contextKey),
                                          Text(snapshot.data['location'], style: contextValue),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("성별", style: contextKey),
                                          Text(snapshot.data['gender'], style: contextValue),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("나이", style: contextKey),
                                          Text(snapshot.data['age'], style: contextValue),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("성격", style: contextKey),
                                          Text(snapshot.data['personality'][0], style: contextValue),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("", style: contextKey),
                                          Text(snapshot.data['personality'][1], style: contextValue),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("소개", style: contextKey),
                                          Text(snapshot.data['introduction'], style: contextValue),
                                        ],
                                      ),
                                    ]),
                                  ]),
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
                      .update({
                    'list': FieldValue.arrayRemove([uid])
                  });
                  db.collection('networks').doc(uid).update({
                    'list': FieldValue.arrayRemove(
                        [FirebaseAuth.instance.currentUser!.uid])
                  });
                  Navigator.of(context).pop();
                },
                style: featureButton,
                child: Text(
                  '삭제하기',
                  style: buttonText,
                ),
              ),
            );
          }
        });
  }

  List<Widget> careerSection(List<dynamic> career){
    List<Widget> result = [];
    for (int index = 0; index < career.length; index++) {
      String text = index > 0 ? "" : "경력";
      result.add(
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              text,
              style: contextKey,
            ),
            Text(
              career[index],
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
  List<Widget> workSection(List<String> workArea) {
    List<Widget> result = [];
    for (int index = 0; index < workArea.length; index++) {
      String text = index > 0 ? "" : "전문분야";
      result.add(
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              text,
              style: contextKey,
            ),
            Text(
              workArea[index],
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

  Future _future() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var user = await db.collection('users').doc(uid).get();
    Map<String, dynamic>? result = user.data();
    String location = ((await db
        .collection('localData')
        .where('code', isEqualTo: result!['location'])
        .get())
        .docs[0])
        .data()['title'];
    result!['location'] = location;
    List<dynamic> workArea = await parseWork(result!['workArea']);
    result['workArea'] = workArea;
    logger.w(workArea);
    return result;
  }

  Future<List<String>> parseWork(List<dynamic> data) async {
    List<String> result = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    for (String element in data) {
      String primary =
      (await db.collection('workData').doc('${element[0]}00').get())
          .data()!['title'];
      String secondary =
      (await db.collection('workData').doc(element).get()).data()!['title'];
      result.add("$primary > $secondary");
    }
    return result;
  }
}
