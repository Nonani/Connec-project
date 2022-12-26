import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff5f66f2),
            ),
            onPressed: () async => await FirebaseAuth.instance.signOut(),
          ),
        ],
        shape: Border(bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
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
      bottomNavigationBar: Container(
        height: 70,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            print('index test : ${index}');
            setState(() {
              _currentIndex = index;
            });
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
}
