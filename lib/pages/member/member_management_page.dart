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
                width: double.infinity, height: 250, child: Image.network("")),
            Container(
                height: 450,
                width: 330,
                margin: const EdgeInsets.only(top: 13, bottom: 10.5),
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 13, bottom: 13),
                    child: Text(data['title'],
                      style: contextTitle
                    ),
                  ),
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
                    padding: const EdgeInsets.only(left: 17.5, right: 17.5),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("관계", style: contextKey),
                            Text('한 다리', style: contextValue),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("평점", style: contextKey),
                            Text("${data['rate']} / 5.0",
                                style: contextValue),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "전문분야",
                              style: contextKey,
                            ),
                            SizedBox(width: 20,),
                            FutureBuilder(
                              future: workString(data['workArea']),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Expanded(
                                    child: Text(
                                      snapshot.data!,
                                      style: contextValue,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                } else {
                                  return Text("불러오는 중",
                                      style: contextValue);
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("경력", style: contextKey),
                            SizedBox(width: 20),
                            Text(data['career'][0],
                                style: contextValue),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("지역", style: contextKey),
                            Text(data['location'],
                                style: contextValue),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("성별", style: contextKey),
                            Text(data['gender'],
                                style: contextValue),
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
                            Text(data['personality'][0],
                                style: contextValue),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("소개", style: contextKey),
                            Text(data['introduction'],
                                style: contextValue),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]))),
          ]),
        ),
        bottomNavigationBar: Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemberBodyPage(mode: data['docId'],),
                    ));
              },
              style: memberMangeButton,
              child: Text('수정',
                style: buttonText
              ),
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
              child: Text('삭제',
                style: buttonText
              ),
            ),
          ),
        ]));
  }

  Future<String> workString(List<dynamic> workData) async {
    logger.w(workData);
    String ret = "";
    FirebaseFirestore db = FirebaseFirestore.instance;
    for (String code in workData) {
      QuerySnapshot<Map<String, dynamic>> data =
          await db.collection('workData').where('code', isEqualTo: code).get();
      ret = "> ${data.docs[0]['title']}";
      data = await db
          .collection('workData')
          .where('code', isEqualTo: data.docs[0]['parent'])
          .get();
      ret = "> ${data.docs[0]['title']}" + ret;
      data = await db
          .collection('workData')
          .where('code', isEqualTo: data.docs[0]['parent'])
          .get();
      ret = data.docs[0]['title'] + ret;
    }
    logger.w(ret);
    return ret;
  }
}
