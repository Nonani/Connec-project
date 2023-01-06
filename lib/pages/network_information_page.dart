import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../components/custom_edit_textform.dart';
import 'package:http/http.dart' as http;
import '../components/custom_expansion_tile.dart';
import '../services/service_class.dart';
import 'expand_network_page.dart';

class NetworkInformationPage extends StatefulWidget {
  const NetworkInformationPage({Key? key}) : super(key: key);

  @override
  State<NetworkInformationPage> createState() => _NetworkInformationPageState();
}

class _NetworkInformationPageState extends State<NetworkInformationPage> {
  final logger = Logger();
  final TextStyle _nameStyle = const TextStyle(
    color: Color(0xff333333),
    fontSize: 19,
    fontFamily: 'S-CoreDream-6Bold',
    fontWeight: FontWeight.w500,
  );
  final TextStyle _contextStyle = const TextStyle(
    color: Color(0xffafafaf),
    fontSize: 13,
    fontFamily: 'EchoDream',
    fontWeight: FontWeight.w200,
  );

  int _currentIndex = 0;

  List<Widget> list = [
    NetworkInformationPage(),
    ExpandNetworkPage(),
    ExpansionTileSample(),
    ExpandNetworkPage(),
    ExpandNetworkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ServiceClass>(context, listen: false);
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
                          child: const Text(
                            '김컨넥',
                            style: TextStyle(
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
                          margin: const EdgeInsets.only(top: 7.5, bottom: 10.5),
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
                                      Text("지인 평점", style: _contextStyle),
                                      Text("지인 수", style: _contextStyle),
                                      Text("지인 대표 분야", style: _contextStyle)
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("/5.0", style: _contextStyle),
                                      Text("", style: _contextStyle),
                                      Text("", style: _contextStyle)
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
                                      Text("이름", style: _contextStyle),
                                      Text("직군/직무", style: _contextStyle),
                                      Text("경력", style: _contextStyle),
                                      Text("활동지", style: _contextStyle),
                                      Text("성별", style: _contextStyle),
                                      Text("나이", style: _contextStyle),
                                      Text("능력", style: _contextStyle),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text("", style: _contextStyle),
                                      Text("", style: _contextStyle),
                                      Text("", style: _contextStyle),
                                      Text("", style: _contextStyle),
                                      Text("", style: _contextStyle),
                                      Text("", style: _contextStyle),
                                      Text("", style: _contextStyle),
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
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5f66f2),
                  minimumSize: const Size(100, 56),
                ),
                child: const Text(
                  '삭제하기',
                  style: TextStyle(
                    color: Color(0xfffafafa),
                    fontSize: 20,
                    fontFamily: 'EchoDream',
                  ),
                ),
              ),
            );
          }
        });
  }

  Future _future() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    print(FirebaseAuth.instance.currentUser!.uid.toString());
    final result = await db
        .collection("notification")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    // logger.w(result.data());
    result.data()?.forEach((key, value) {
      print("${key}\t${value}");
    });
    return result;
  }
}
