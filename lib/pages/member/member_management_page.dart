import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/style/buttonstyle.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../style/contextstyle.dart';
import 'member_body_page.dart';

class AcquitanceManagementPage extends StatelessWidget {
  Map<String, dynamic> data;

  AcquitanceManagementPage(this.data, {Key? key}) : super(key: key);

  final logger = Logger();

  @override
  build(BuildContext context) {
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
              height: 700,
              width: 330,
              margin: const EdgeInsets.only(top: 13, bottom: 10.5),
              child: SingleChildScrollView(
                  child: Column(children: [
                Column(children: [
                  SizedBox(height: 121),
                  Text(data['bTitle'], style: contextTitle),
                  SizedBox(height: 26),
                  FutureBuilder(
                    future: workString(data['workArea']),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data![0],
                          style: contextValue,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      } else {
                        return Text("불러오는 중", style: contextValue);
                      }
                    },
                  ),
                  SizedBox(height: 23)
                ]),
                Container(
                  width: 336,
                  height: 0,
                  margin: const EdgeInsets.only(top: 7.5, bottom: 10.5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff5f66f2),
                      width: 1,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 17.5, right: 17.5),
                  child: Column(children: [
                    Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("관계", style: contextKey),
                          Text('한 다리', style: contextValue),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("평점", style: contextKey),
                          Text("${data['rate']} / 5.0", style: contextValue),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
                    FutureBuilder(
                      future: workString(data['workArea']),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(children: workSection(snapshot.data!, data['career']));
                        } else {
                          return Column(children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("전문분야", style: contextKey),
                                  Text("불러오는 중", style: contextValue)
                                ]),
                            SizedBox(
                              height: 10,
                            ),
                          ]);
                        }
                      },
                    ),
                    Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("지역", style: contextKey),
                          Text(data['location'], style: contextValue),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("성별", style: contextKey),
                          Text(data['gender'], style: contextValue),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("나이", style: contextKey),
                          Text(data['age'], style: contextValue),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("성격", style: contextKey),
                          Text(data['personality'][0], style: contextValue),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("", style: contextKey),
                          Text(data['personality'][1], style: contextValue),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("소개", style: contextKey),
                          Text(data['introduction'], style: contextValue),
                        ],
                      ),
                    ]),
                  ]),
                ),
              ])),
            )
          ]),
        ),
        bottomNavigationBar: Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemberBodyPage(
                        mode: data['docId'],
                      ),
                    ));
              },
              style: memberMangeButton,
              child: Text('수정', style: buttonText),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                FirebaseFirestore db = FirebaseFirestore.instance;
                await db.collection('member').doc(data['docId']).delete();
                Navigator.of(context).pop();
              },
              style: memberMangeButton,
              child: Text('삭제', style: buttonText),
            ),
          ),
        ]));
  }

  List<Widget> workSection(List<String> workArea, List<dynamic> career) {
    List<Widget> result = [];
    for (int index = 0; index < workArea.length * 2; index++) {
      String text = index > 0 ? "" : "전문분야";
      String data = index % 2 == 0? workArea[index ~/ 2]: career[index ~/ 2];
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

  Future<List<String>> workString(List<dynamic> workArea) async {
    List<String> ret = [];
    FirebaseFirestore db = FirebaseFirestore.instance;
    for (String code in workArea) {
      String primary = (await db
              .collection('workData')
              .where('code', isEqualTo: '${code[0]}00')
              .get())
          .docs[0]
          .data()['title'];

      String secondary =
          (await db.collection('workData').where('code', isEqualTo: code).get())
              .docs[0]
              .data()['title'];
      ret.add('$primary > $secondary');
    }
    return ret;
  }
}
