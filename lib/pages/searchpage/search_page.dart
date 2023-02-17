
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/member/member_list_page.dart';
import 'package:connec/pages/network/network_management_page.dart';
import 'package:connec/pages/searchpage/search_network_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../../components/custom_dialog.dart';
import '../mypage/my_info_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 2;
  Logger logger = Logger();
  List<Entry> data = [];
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
      future: getList(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (!snapshot.hasData) {
          return CustomLoadingPage();
        } else {
          data = snapshot.data!;
          List<Widget> workList = [];
          for(int index =0;index<data.length;index++){
            workList.add(EntryItem(data[index], 0, context));
          }
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
            body: SingleChildScrollView(
                child:Column(
                  children: workList,
                )
            ),
            bottomNavigationBar: SizedBox(
              height: 70,
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  print('index test : ${index}');
                  if (_currentIndex != index) {
                    setState(() {
                      _currentIndex = index;
                    });
                    Navigator.pushReplacement(context,
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
            ),
          );
        }
      },
    );
  }

  Future<List<Entry>> getList() async {
    Logger logger = Logger();
    final db = FirebaseFirestore.instance;
    List<Entry> list1 = [];
    final work1 =
        (await db.collection("workData").where("tier", isEqualTo: 1).get()).docs;

    for (var element1 in work1){
      List<Entry> list2 = [];

      final work2 = (await db
          .collection("workData")
          .where("tier", isEqualTo: 2)
          .where("parent", isEqualTo: "${element1.data()["code"]}")
          .get())
          .docs;
      for (var element2 in work2) {
        list2.add(Entry(title: element2.data()["title"], code: element2.data()["code"], children: []));
      }
      list1.add(Entry(title: element1.data()["title"], code: element1.data()["code"], children: list2));
    }

    return list1;
  }
}



class Entry {
  final String title;
  final String code;
  final List<Entry> children;

  Entry({required this.title,required this.code, required this.children});

  factory Entry.fromJson(Map<String, dynamic> json) {
    var childrenJson = json['children'] as List<dynamic>;
    List<Entry> children = childrenJson.map((i) => Entry.fromJson(i)).toList();
    return Entry(
      title: json['title'],
      code:json['code'],
      children: children,
    );
  }

}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry, this.num, this.context);

  final double num;
  final Entry entry;
  final BuildContext context;

  Widget _buildTiles1(Entry root) {
    // print(root.title);
    if (root.children.isEmpty)
      return ListTile(
        title: Text(
          root.title,
          style: TextStyle(
            color: Color(0xff666666),
            fontFamily: 'EchoDream',
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          // 이 부분을 go_router 패키지 써서
          // context.go('/${root.title}'), 이런 식으로 할 예정

        },
      );
    return Container(
      decoration: UnderlineTabIndicator(
          borderSide: BorderSide(width: 1, color: Color(0xff5f66f2))),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(left: 10),
        key: PageStorageKey<Entry>(root),
        title: Text(
          root.title,
          style: TextStyle(
            color: Color(0xff666666),
            fontSize: 16,
            fontFamily: 'EchoDream',
            fontWeight: FontWeight.w500,
          ),
        ),
        children: root.children.map(_buildTiles2).toList(),
      ),
    );
  }

  Widget _buildTiles2(Entry root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(
          root.title,
          style: TextStyle(
            color: Color(0xff666666),
            fontFamily: 'EchoDream',
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          // 이 부분을 go_router 패키지 써서
          // context.go('/${root.title}'), 이런 식으로 할 예정
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchNetworkPage(root.code),));
        },
      );
    return Container(
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(left: 10),
        key: PageStorageKey<Entry>(root),
        title: Text(
          root.title,
          style: TextStyle(
            color: Color(0xff666666),
            fontFamily: 'EchoDream',
            fontWeight: FontWeight.w500,
          ),
        ),
        children: root.children.map(_buildTiles1).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles1(entry);
  }
}
