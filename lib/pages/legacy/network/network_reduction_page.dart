import 'dart:convert';

import 'package:connec/style/button_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../../style/Member/contextstyle.dart';



class NetworkReductionPage extends StatefulWidget {
  String uid;
  final logger = Logger();

  NetworkReductionPage(this.uid, {Key? key}) : super(key: key);

  @override
  State<NetworkReductionPage> createState() => _NetworkReductionPage(this.uid);
}
class _NetworkReductionPage extends State<NetworkReductionPage>{
  String uid;
  final logger = Logger();
  _NetworkReductionPage(this.uid);

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: _future(),
        builder: (BuildContext context, snapshot) {
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
                                            child: Text(snapshot.data['acquitances'].toString(),
                                                style: contextValue),
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(
                                                  snapshot.data['personality'][0],
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
                                    Column(children: workSection(snapshot.data['workArea'], snapshot.data['career'])),
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
                  final url =
                  Uri.parse('https://foggy-boundless-avenue.glitch.me/member/delete');
                  try {
                    await http.post(
                      url,
                      headers: <String, String>{
                        'Content-Type': 'application/x-www-form-urlencoded',
                      },
                      body: <String, String>{
                        'uid': FirebaseAuth.instance.currentUser!.uid,
                        'memberUid': uid,
                      },
                    );
                  }catch (e){
                    logger.w("error");
                  }
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


  List<Widget> workSection(List<dynamic> workArea, List<dynamic> career) {
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

  Future _future() async {
    final url =
    Uri.parse('https://foggy-boundless-avenue.glitch.me/member/detail');
    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'uid': uid,
        },
      );
      return json.decode(response.body);
    }catch (e){
      return null;
    }

  }
}
