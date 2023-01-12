import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_item_widget.dart';
import 'package:connec/pages/acquitance_management_page.dart';
import 'package:connec/pages/add_member_page.dart';
import 'package:connec/pages/member_body_page.dart';
import 'package:connec/pages/network_management_page.dart';
import 'package:connec/pages/network_reduction_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../components/custom_expansion_tile.dart';
import '../services/service_class.dart';
import 'expand_network_page.dart';

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

  int _currentIndex = 0;

  List<Widget> list = [
    NetworkManagementPage(),
    AcquitanceListPage(),
    ExpansionTileSample(),
    ExpandNetworkPage(),
    ExpandNetworkPage(),
  ];

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
                  title: const Text(
                    'CONNEC',
                    style: TextStyle(
                      color: Color(0xff5f66f2),
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  centerTitle: true,
                  actions: const [
                    IconButton(
                        icon: Icon(Icons.link_sharp),
                        color: Color(0xff5f66f2),
                        onPressed: null),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AcquitanceManagementPage(snapshot.data!['list'][index]),
                                    ));
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
                                    field: snapshot.data['list'][index]['work'],
                                    rate: '0',
                                    relationship: '0',
                                    capability: snapshot.data['list'][index]['capability'],
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
                            builder: (context) => MemberBodyPage(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(247.3, 55.9),
                      backgroundColor: Color(0xfffafafa),
                      side: BorderSide(
                        color: Color(0xff5f66f2),
                        width: 2,
                      ),
                    ),
                    child: Text(
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
                      print('index test : ${index}');
                      if (_currentIndex != index) {
                        setState(() {
                          _currentIndex = index;
                        });
                        Navigator.push(
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
                      BottomNavigationBarItem(
                          icon: Image.asset(
                            "assets/images/navigation_icon_4.png",
                            height: 30,
                            width: 30,
                          ),
                          label: "구인장터"),
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
    print(FirebaseAuth.instance.currentUser!.uid.toString());
    final list = await db
        .collection("member")
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    Map <String, dynamic> data = {};
    logger.w(list.docs);
    data['list'] = List.empty( growable: true);
    data['length'] = list.docs.length;
    list.docs.forEach((member) {
      data['list'].add(member.data());
    });
    logger.w(data['list'][1]);
    return data;
  }
}
