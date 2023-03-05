import 'package:flutter/material.dart';

import '../pages/member/member_list_page.dart';
import '../pages/mypage/my_info_page.dart';
import '../pages/network/network_management_page.dart';
import '../pages/searchpage/search_page.dart';

class CommonBottomNavigationBar extends StatefulWidget {
  @override
  State<CommonBottomNavigationBar> createState() => _CommonBottomNavigationBarState();
}

class _CommonBottomNavigationBarState extends State<CommonBottomNavigationBar> {
  int _currentIndex = 2;
  List<Widget> list = [
    NetworkManagementPage(),
    SearchPage(),
    MyInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
