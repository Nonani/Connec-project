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
                  backgroundColor: const Color(0xfffafafa),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff5f66f2),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                body: Column(
                    children: [
                  Container(
                      height: 450,
                      width: 330,
                      margin: const EdgeInsets.only(top: 27, bottom: 9),
                      child:
                          SingleChildScrollView(
                            padding: EdgeInsets.only(left: 12.5, right: 11.5),
                              child: Center(
                                child: Column(
                                    children: [
                                      Column(),
                                      Padding(
                                        padding: const EdgeInsets.only(left:17.5, right: 17.5),
                                        child: Row(

                                          mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text("지인 평점",
                                                    style: _contextStyle),
                                                Text("지인 수",
                                                    style: _contextStyle),
                                                Text("지인 대표 분야",
                                                    style: _contextStyle)
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Text("/5.0",
                                                    style: _contextStyle),
                                                Text("",
                                                    style: _contextStyle),
                                                Text("",
                                                    style: _contextStyle)
                                              ],
                                            )
                                          ],),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:17.5, right: 18.5),
                                        child: Row(mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Text("지인 평점",
                                                    style: _contextStyle),
                                                Text("지인 수",
                                                    style: _contextStyle),
                                                Text("지인 대표 분야",
                                                    style: _contextStyle)
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Text("/5.0",
                                                    style: _contextStyle),
                                                Text("",
                                                    style: _contextStyle),
                                                Text("",
                                                    style: _contextStyle)
                                              ],
                                            )
                                          ],),
                                      )
                                      ]
                                ),
                              )
                          )
                  ),

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
