import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/mypage/my_info_page.dart';
import 'package:connec/style/title.dart';
import '../../components/custom_dialog.dart';
import '../../components/member_item_widget.dart';
import 'member_management_page.dart';
import 'member_body_page.dart';
import '../network/network_management_page.dart';
import '../searchpage/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';


class AcquitanceListPage extends StatefulWidget {
  const AcquitanceListPage({Key? key}) : super(key: key);

  @override
  State<AcquitanceListPage> createState() => _AcquitanceListPageState();
}

class _AcquitanceListPageState extends State<AcquitanceListPage> {
  final logger = Logger();
  final TextStyle _nameStyle = const TextStyle(
    color: Color(0xff333333),
    fontSize: 15,
    fontFamily: 'S-CoreDream-6Bold',
    fontWeight: FontWeight.w500,
  );
  final TextStyle _classStyle = const TextStyle(
    color: Color(0xff999999),
    fontSize: 9,
    fontFamily: 'EchoDream',
    fontWeight: FontWeight.w200,
  );
  final TextStyle _contextStyle = const TextStyle(
    color: Color(0xffafafaf),
    fontSize: 11,
    fontFamily: 'EchoDream',
    fontWeight: FontWeight.w200,
  );
  final TextStyle _itemStyle = const TextStyle(
    color: Color(0xff333333),
    fontSize: 11,
    fontFamily: 'EchoDream',
    fontWeight: FontWeight.w200,
  );

  int _currentIndex = 1;

  List<Widget> list = [
    NetworkManagementPage(),
    AcquitanceListPage(),
    SearchPage(),
    // ExpandNetworkPage(),
    MyInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return CustomLoadingPage();
          } else {
            return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  toolbarHeight: 56,
                  backgroundColor: const Color(0xfffafafa),
                  shape: const Border(
                      bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff5f66f2),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: Text(
                    'CONNEC',
                    style: connecTitle,
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.link_sharp),
                        color: Color(0xff5f66f2),
                        onPressed: () async {
                          final db = FirebaseFirestore.instance;
                          final result = await db
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get();
                          logger.w(FirebaseAuth.instance.currentUser!.uid);
                          Clipboard.setData(
                              ClipboardData(text: result["uuid"]));
                        }),
                  ],
                ),
                body: Column(children: [
                  Container(
                      height: 540,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 18, bottom: 9),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snapshot.data['length'],
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      logger.w(snapshot.data);
                                  return AcquitanceManagementPage(
                                      snapshot.data!['list'][index]);
                                }));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 7),
                                child: SizedBox(
                                  width: 360,
                                  height: 130,
                                  child: MemberItemWidget(
                                    nameStyle: _nameStyle,
                                    classStyle: _classStyle,
                                    contextStyle: _contextStyle,
                                    itemStyle: _itemStyle,
                                    field: snapshot.data['list'][index]['title'],
                                    // field: snapshot.data['list'][index]['work'],
                                    rate: '0',
                                    relationship: '한 다리',
                                    capability: snapshot.data['list'][index]
                                        ['personality'][0],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ]))),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MemberBodyPage( mode: '0'),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(247.3, 55.9),
                      backgroundColor: Color(0xfffafafa),
                      side: const BorderSide(
                        color: Color(0xff5f66f2),
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      '지인을 등록 해주세요',
                      style: TextStyle(
                        color: Color(0xff5f66f2),
                        fontSize: 18,
                        fontFamily: 'EchoDream',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ]),
                bottomNavigationBar: Container(
                  height: 70,
                  child: BottomNavigationBar(
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      if (_currentIndex != index) {
                        setState(() {
                          _currentIndex = index;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => list[_currentIndex],
                            ));
                      }
                    },
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Color(0xff5f66f2),
                    showSelectedLabels: true,
                    fixedColor: Colors.white,
                    unselectedItemColor: Colors.white,
                    selectedFontSize: 12,
                    unselectedFontSize: 12,
                    items: [
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/images/navigation_icon_1.png",
                            height: 30,
                            width: 30,
                          ),
                          label: "네트워크"),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/images/navigation_icon_2.png",
                            height: 30,
                            width: 30,
                          ),
                          label: "지인관리"),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/images/navigation_icon_3.png",
                            height: 30,
                            width: 30,
                          ),
                          label: "검색"),
                      // BottomNavigationBarItem(
                      //     icon: Image.asset(
                      //       "assets/images/navigation_icon_4.png",
                      //       height: 30,
                      //       width: 30,
                      //     ),
                      //     label: "구인장터"),
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/images/navigation_icon_5.png",
                            height: 30,
                            width: 30,
                          ),
                          label: "마이페이지"),
                    ],
                  ),
                ));
          }
        });
  }

  Future _future() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final list = await db
        .collection("member")
        .where('uid',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    Map<String, dynamic> data = {};
    data['list'] = List.empty(growable: true);
    data['length'] = list.docs.length;
    for (var member in list.docs) {
      var memberData = member.data();
      QuerySnapshot<Map<String, dynamic>> tmp = await db
          .collection('workData')
          .where('code', isEqualTo: memberData['workArea'][0])
          .get();
      memberData['title'] = tmp.docs[0]['title'];
      tmp = await db
          .collection('localData')
          .where('code', isEqualTo: memberData['location'])
          .get();
      memberData['location'] = tmp.docs[0]['title'];
      data['list'].add(memberData);
    }
    return data;
  }
}
