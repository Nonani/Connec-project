import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/acquitance_list_page.dart';
import 'package:connec/pages/expand_network_page.dart';
import 'package:connec/pages/network_list_page.dart';
import 'package:connec/pages/network_management_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../components/custom_expansion_tile.dart';
import '../components/custom_notice_item.dart';
import 'mypage/my_info_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 2;
  Logger logger = Logger();
  List<Widget> list = [
    NetworkManagementPage(),
    AcquitanceListPage(),
    SearchPage(),
    ExpandNetworkPage(),
    MyInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return SafeArea(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: const Color(0xff5f66f2),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                    icon: Icon(Icons.link_sharp),
                    color: Color(0xff5f66f2),
                    onPressed: () async {
                      final db = FirebaseFirestore.instance;
                      final result = await db
                          .collection("users")
                          .doc("${FirebaseAuth.instance.currentUser!.uid}")
                          .get();
                      logger.w(FirebaseAuth.instance.currentUser!.uid);
                      Clipboard.setData(ClipboardData(text: result["uuid"]));
                    }),
              ],
              shape: Border(
                  bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
              backgroundColor: Color(0xfffafafa),
              elevation: 0,
              title: Text(
                'CONNEC',
                style: TextStyle(
                  color: Color(0xff5f66f2),
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              centerTitle: true,
            ),
            body: Container(),
            bottomNavigationBar: SizedBox(
              height: 70,
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  print('index test : ${index}');
                  setState(() {
                    _currentIndex = index;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => list[_currentIndex],
                      )).then((value) => setState(() {}));
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
            ),
          );
        }
      },
    );
  }

  Future _future() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final result = await db
        .collection("notification")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    if (result.data() == null) return {"list": []};
    // result.data()?.forEach((key, value) {
    //   print("${key}\t${value}");
    // });
    return result;
  }
}
