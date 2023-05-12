import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/common_bottom_navigation_bar.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'expand_network_page.dart';
import 'network_list_page.dart';
import 'package:http/http.dart' as http;
class NetworkManagementPage extends StatefulWidget {
  const NetworkManagementPage({Key? key}) : super(key: key);

  @override
  State<NetworkManagementPage> createState() => _NetworkManagementPageState();
}

class _NetworkManagementPageState extends State<NetworkManagementPage> {
  final logger = Logger();

  int connectionCount = 0;
  List<String> connectionText = ['한 다리', '두 다리', '세 다리', '전체 사용자'];
  List<String> userText = ['총 지인', '전체 사용자 수'];
  List<String> connectionList = [
    "assets/images/first_deg.png",
    "assets/images/second_deg.png",
    "assets/images/third_deg.png",
    "assets/images/third_deg.png"
  ];

  @override
  Widget build(BuildContext context) {
    //var provider = Provider.of<ServiceClass>(context, listen: false);
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
        title: GestureDetector(
          child: Text(
            'CONNEC',
            style: connecTitle,
          ),
          onTap: () => Navigator.of(context).pop(),
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
                    .doc("${FirebaseAuth.instance.currentUser!.uid}")
                    .get();
                Clipboard.setData(ClipboardData(text: result["uuid"]));
                showDialog(
                    context: context,
                    builder: (context) {
                      Future.delayed(Duration(seconds: 3), () {
                        Navigator.of(context).pop(true);
                      });
                      return Dialog(
                        // The background color
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '코드가 클립보드에\n복사되었습니다',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 12),
              child: Column(children: [
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: Image.asset(connectionList[connectionCount]),
                ),
                Column(children: [
                  Container(
                    width: 360,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() =>
                                connectionCount = (connectionCount + 1) % 4);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(186, 36),
                            backgroundColor: const Color(0xfffafafa),
                            side: const BorderSide(
                              color: Color(0xff5f66f2),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            connectionText[connectionCount],
                            style: const TextStyle(
                              color: Color(0xff5f66f2),
                              fontSize: 16,
                              fontFamily: 'EchoDream',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )),
                  ),
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
                                  builder: (context) => ExpandNetworkPage(),
                                ));
                          },
                          child: const Text(
                            "지인 등록",
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
                                  builder: (context) => NetworkListPage(),
                                ));
                          },
                          child: const Text(
                            "지인 삭제",
                            style: TextStyle(
                              color: Color(0xfffafafa),
                              fontSize: 15,
                              fontFamily: 'EchoDream',
                            ),
                          ))
                    ],
                  ),
                ]),
                FutureBuilder(
                    future: getMemberInfo(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data['count'][connectionCount] != 0) {
                        return Column(children: [
                          Container(
                            padding: EdgeInsets.only(left: 35, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  userText[connectionCount ~/ 3],
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 17,
                                    fontFamily: 'EchoDream',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 18, height: 0),
                                Text(
                                  "${snapshot.data['count'][connectionCount].toString()}명",
                                  style: const TextStyle(
                                    color: Color(0xff5f66f2),
                                    fontSize: 17,
                                    fontFamily: 'EchoDream',
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 35, top:10, right: 30, bottom: 16),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                color: Color(0xff5f66f2),
                                width: 2,
                              )),
                            ),
                          ),
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot
                                .data['data'][connectionCount].keys.length,
                            itemBuilder: (BuildContext context, int fIdx) {
                              var fKeys = snapshot
                                  .data['data'][connectionCount].keys
                                  .toList();
                              return Padding(
                                  padding: EdgeInsets.only(bottom: 0),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 35, bottom: 10),
                                          child: Text(
                                            snapshot.data['dict']
                                                [connectionCount][fKeys[fIdx]],
                                            style: const TextStyle(
                                              color: Color(0xff333333),
                                              fontSize: 16,
                                              fontFamily: 'EchoDream',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 0,
                                          margin: const EdgeInsets.only(
                                              left: 35, right: 30, bottom: 16),
                                          decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                              color: Color(0xff5f66f2),
                                              width: 2,
                                            )),
                                          ),
                                        ),
                                        ListView.builder(
                                            primary: false,
                                            shrinkWrap: true,
                                            itemCount: snapshot
                                                .data['data'][connectionCount][
                                                    snapshot
                                                        .data['data']
                                                            [connectionCount]
                                                        .keys
                                                        .toList()[fIdx]]
                                                .length,
                                            itemBuilder: (BuildContext context,
                                                int sIdx) {
                                              var sKeys = snapshot.data['data']
                                                      [connectionCount][
                                                  snapshot
                                                      .data['data']
                                                          [connectionCount]
                                                      .keys
                                                      .toList()[fIdx]];
                                              return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 60,
                                                              right: 40,
                                                              bottom: 10),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              snapshot.data[
                                                                          'dict']
                                                                      [
                                                                      connectionCount]
                                                                  [sKeys[sIdx]
                                                                      ['code']],
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xff666666),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'EchoDream',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                            Text(
                                                              "${sKeys[sIdx]['count']}명",
                                                              style:
                                                                  const TextStyle(
                                                                color: Color(
                                                                    0xff666666),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'EchoDream',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ]),
                                                    ),
                                                  ]);
                                            })
                                      ]));
                            },
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ]);
                      } else {
                        return Container(
                          padding: EdgeInsets.only(left: 35, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                userText[connectionCount ~/ 3],
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 17,
                                  fontFamily: 'EchoDream',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 18, height: 0),
                              Text(
                                "0명",
                                style: TextStyle(
                                  color: Color(0xff5f66f2),
                                  fontSize: 17,
                                  fontFamily: 'EchoDream',
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    })
              ])),
        ]),
      ),
      bottomNavigationBar: CommonBottomNavigationBar(),
    );
  }

  Future getMemberInfo() async {
    Logger logger = Logger();

    final url =
    Uri.parse('https://foggy-boundless-avenue.glitch.me/member/info');
    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'uid': FirebaseAuth.instance.currentUser!.uid.toString(),
        },
      );
    }catch (e){
       logger.w(e);
    }
    return null;
  }


}
