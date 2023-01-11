import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/network_reduction_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../components/custom_expansion_tile.dart';
import '../services/service_class.dart';
import 'expand_network_page.dart';
import 'network_list_page.dart';

class NetworkManagementPage extends StatefulWidget {
  const NetworkManagementPage({Key? key}) : super(key: key);

  @override
  State<NetworkManagementPage> createState() => _NetworkManagementPageState();
}

class _NetworkManagementPageState extends State<NetworkManagementPage> {
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
    NetworkManagementPage(),
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
                      height: 635,
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 12),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        SizedBox(
                          width: double.infinity,
                          height: 220,
                          child: Image.network(""),
                        ),
                        Column(children: [
                          Container(
                            width: double.infinity,
                            height: 0,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff5f66f2),
                                width: 1.5,
                              ),
                            ),
                          ),
                          Container(
                            width: 360,
                            height: 34,
                            alignment: Alignment.center,
                            child: Text(
                              "한 다리",
                              style: TextStyle(
                                color: Color(0xff5f66f2),
                                fontSize: 16,
                                fontFamily: 'EchoDream',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 0,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff5f66f2),
                                width: 1.5,
                              ),
                            ),
                          )
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(160, 43),
                                  backgroundColor: const Color(0xff5f66f2),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ExpandNetworkPage(),
                                      ));
                                },
                                child: const Text(
                                  "네트워크 확장",
                                  style: TextStyle(
                                    color: Color(0xfffafafa),
                                    fontSize: 15,
                                    fontFamily: 'EchoDream',
                                  ),
                                )),
                            const SizedBox(width: 13),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(160, 43),
                                  backgroundColor: const Color(0xff5f66f2),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NetworkListPage(),
                                      ));
                                },
                                child: const Text(
                                  "네트워크 축소",
                                  style: TextStyle(
                                    color: Color(0xfffafafa),
                                    fontSize: 15,
                                    fontFamily: 'EchoDream',
                                  ),
                                ))
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,//snapshot.data['list'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: EdgeInsets.only(bottom: 14),
                                child: SizedBox(
                                  width: 360,
                                  height: 300,
                                ),
                              );
                          },
                        ),
                      ]))),
                ]),
                bottomNavigationBar: Container(
                  height: 65,
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
        .collection("networks")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    logger.w(result);
    return result;
  }
}
