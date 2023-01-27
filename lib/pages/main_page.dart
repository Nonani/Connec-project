import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/pages/acquitance_list_page.dart';
import 'package:connec/pages/expand_network_page.dart';
import 'package:connec/pages/network_management_page.dart';
import 'package:connec/pages/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../components/custom_notice_item.dart';
import 'mypage/my_info_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 2;
  Logger logger = Logger();
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
        if(!snapshot.hasData){
          return CustomLoadingPage();
        }else{
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    icon: Icon(Icons.link_sharp),
                    color: Color(0xff5f66f2),
                    onPressed: () async{
                      final db = FirebaseFirestore.instance;
                      final result = await db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
                      logger.w(FirebaseAuth.instance.currentUser!.uid);
                      Clipboard.setData(ClipboardData(text: result["uuid"]));
                    }),
              ],
              shape: const Border(bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
              backgroundColor: Color(0xfffafafa),
              elevation: 0,
              title: const Text(
                'CONNEC',
                style: TextStyle(
                  color: Color(0xff5f66f2),
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 23, top: 54),
                  child: const Text(
                    '어떤 사람을 찾으시나요?',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 17, right: 17),
                    width: double.infinity,
                    height: 41,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(),));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                            side: BorderSide(
                              width: 1.0,
                              color: Color(0xff5f66f2),
                            ),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search,
                              size: 30,
                              color: Color(0xff5f66f2),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '키워드로 검색해 보세요.',
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 15,
                                fontFamily: 'S-CoreDream-4Regular',
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ],
                        ))),
                Padding(
                  padding: const EdgeInsets.only(top: 45, left: 23),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '알림',
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 20,
                          fontFamily: 'S-CoreDream-6',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 20,
                        alignment: Alignment.center,
                        width: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xff5f66f2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          '${snapshot.data['list'].length}',
                          style: const TextStyle(
                            color: Color(0xfffafafa),
                            fontSize: 13,
                            fontFamily: 'S-CoreDream-6',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 143,
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 26,
                    right: 26,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xff5f66f2), width: 1.5),
                      bottom: BorderSide(color: Color(0xff5f66f2), width: 1.5),
                    ),
                    color: Color(0xffeeeeee),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true, // 리스트 자식 높이 크기의 합 만큼으로 영역 고정
                          physics: const NeverScrollableScrollPhysics(), // 스크롤 안되도록 설정하는 옵션 값
                          itemCount: snapshot.data['list'].length,
                          itemBuilder: (BuildContext context, int index) {
                            final notice = snapshot.data['list'][index];
                            return CustomNoticeItem(notice: notice);
                          },
                        ),
                      ]
                    ),
                  ),
                ),
              ],
            ),
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
                      )).then((value) => setState((){}));
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
            ),
          );
        }
      },

    );
  }
  Future _future() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final result = await db
        .collection("notification").doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    if(result.data() == null)
      return {"list":[]};
    // result.data()?.forEach((key, value) {
    //   print("${key}\t${value}");
    // });
    return result;
  }
}
