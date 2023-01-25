import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/acquitance_list_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import '../components/custom_expansion_tile.dart';
import 'expand_network_page.dart';
import 'network_list_page.dart';

class NetworkManagementPage extends StatefulWidget {
  const NetworkManagementPage({Key? key}) : super(key: key);

  @override
  State<NetworkManagementPage> createState() => _NetworkManagementPageState();
}

class _NetworkManagementPageState extends State<NetworkManagementPage> {
  final logger = Logger();

  int connectionCount = 0;
  List<String> connectionText = ['한 다리', '두 다리', '세 다리'];
  List<String> connectionList = [
    'https://firebasestorage.googleapis.com/v0/b/connec-project.appspot.com/o/connec%20~%EB%8B%A4%EB%A6%AC-03.png?alt=media&token=c5bd0d56-f0be-47b4-9253-764712720c9a',
    'https://firebasestorage.googleapis.com/v0/b/connec-project.appspot.com/o/connec%20~%EB%8B%A4%EB%A6%AC-04.png?alt=media&token=6e0f685e-1c75-4209-a027-caf2b61a21ba',
    'https://firebasestorage.googleapis.com/v0/b/connec-project.appspot.com/o/connec%20~%EB%8B%A4%EB%A6%AC-05.png?alt=media&token=6c4f0fa5-601a-4c81-b4ec-0fde0afe929b'
  ];
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
          title: const Text(
            'CONNEC',
            style: TextStyle(
              color: Color(0xff5f66f2),
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
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
                  logger.w(FirebaseAuth.instance.currentUser!.uid);
                  Clipboard.setData(ClipboardData(text: result["uuid"]));
                }),
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
                      child: Image.network(connectionList[connectionCount]),
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
                                connectionCount = (connectionCount + 1) % 3);
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
                                style: TextStyle(
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
                                      builder: (context) => NetworkListPage(),
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
                    ]),
                    FutureBuilder(
                        future: data(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          logger.w(snapshot.data);
                          if (snapshot.hasData && snapshot.data['count'][connectionCount] != 0) {
                            return Column(children: [
                              Container(
                                padding: EdgeInsets.only(left: 35, top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "총 지인",
                                      style: TextStyle(
                                        color: Color(0xff333333),
                                        fontSize: 17,
                                        fontFamily: 'EchoDream',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 18, height: 0),
                                    Text(
                                      "${snapshot.data['count'][connectionCount]
                                          .toString()}명",
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
                                    left: 35, top: 10, bottom: 26.5),
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
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 35, bottom: 10),
                                              child: Text(
                                                snapshot
                                                    .data['dict'][connectionCount][fKeys[fIdx]],
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
                                                  left: 35,
                                                  right: 30,
                                                  bottom: 16),
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                      color: Color(0xff5f66f2),
                                                      width: 2,
                                                    )),
                                              ),
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: snapshot
                                                    .data['data'][connectionCount][
                                                snapshot
                                                    .data['data'][connectionCount]
                                                    .keys
                                                    .toList()[fIdx]]
                                                    .keys
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                    int sIdx) {
                                                  var sKeys = snapshot
                                                      .data['data'][connectionCount][
                                                  snapshot
                                                      .data['data']
                                                  [connectionCount]
                                                      .keys
                                                      .toList()[fIdx]]
                                                      .keys
                                                      .toList();
                                                  return Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          margin: const EdgeInsets
                                                              .only(left: 35,
                                                              bottom: 10),
                                                          child: Row(children: [
                                                            const Icon(Icons
                                                                .arrow_forward_ios_outlined,
                                                                color: Color(
                                                                    0xff5f66f2),
                                                                size: 18),
                                                            Text(snapshot
                                                                .data['dict']
                                                            [connectionCount][sKeys[sIdx]],
                                                              style: const TextStyle(
                                                                color: Color(
                                                                    0xff333333),
                                                                fontSize: 16,
                                                                fontFamily: 'EchoDream',
                                                                fontWeight: FontWeight
                                                                    .w700,
                                                              ),),
                                                          ]),
                                                        ),
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount: snapshot
                                                                .data['data'][connectionCount]
                                                            [snapshot
                                                                .data['data'][connectionCount]
                                                                .keys
                                                                .toList()[fIdx]][snapshot
                                                                .data['data'][connectionCount]
                                                            [snapshot
                                                                .data['data'][connectionCount]
                                                                .keys
                                                                .toList()[fIdx]]
                                                                .keys
                                                                .toList()[sIdx]]
                                                                .length,
                                                            itemBuilder: (
                                                                BuildContext context,
                                                                int tIdx) {
                                                              var tKeys = snapshot
                                                                  .data['data']
                                                              [connectionCount][snapshot
                                                                  .data['data']
                                                              [connectionCount]
                                                                  .keys
                                                                  .toList()[fIdx]][snapshot
                                                                  .data['data']
                                                              [connectionCount][snapshot
                                                                  .data['data'][connectionCount]
                                                                  .keys
                                                                  .toList()[fIdx]]
                                                                  .keys
                                                                  .toList()[sIdx]];
                                                              return Container(
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      left: 55,
                                                                      right: 43),
                                                                  child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment
                                                                          .spaceBetween,
                                                                      children: [
                                                                        Text(
                                                                          snapshot
                                                                              .data['dict'][connectionCount]
                                                                          [tKeys[tIdx]['code']],
                                                                          style: const TextStyle(
                                                                            color: Color(
                                                                                0xff666666),
                                                                            fontSize: 15,
                                                                            fontFamily: 'EchoDream',
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "${tKeys[tIdx]['count']
                                                                              .toString()}명",
                                                                          style: const TextStyle(
                                                                            color: Color(
                                                                                0xff666666),
                                                                            fontSize: 15,
                                                                            fontFamily: 'EchoDream',
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                          ),)
                                                                      ]));
                                                            }),
                                                        Container(
                                                          margin: const EdgeInsets
                                                              .only(left: 55,
                                                              right: 43,
                                                              bottom: 16.5,
                                                              top: 10),
                                                          decoration: BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color(
                                                                  0xffe2e2e2),
                                                              width: 1.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ]);
                                                })
                                          ]));
                                },
                              )
                            ]);
                          }
                          else {
                            return Container();
                          }
                        })
                  ]))),
        ]),
        bottomNavigationBar: SizedBox(
          height: 65,
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              print('index test : ${index}');
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

  Future data() async {
    Logger logger = Logger();
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> result = {};
    result['count'] = [0, 0, 0];
    result['data'] = [];
    result['dict'] = [];
    // 한 다리
    DocumentSnapshot<Map<String, dynamic>> firstNetwork = await db
        .collection('networks')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Map<String, dynamic>? networkData = firstNetwork.data();
    QuerySnapshot<Map<String, dynamic>> networkUsers = await db
        .collection('users')
        .where(FieldPath.documentId, whereIn: networkData!['list'])
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? networkUserData =
        networkUsers.docs;
    QuerySnapshot<Map<String, dynamic>> relation = await db
        .collection('member')
        .where('uid', whereIn: networkData['list'])
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? relationData =
        relation.docs;

    result['count'][0] += networkUserData.length;
    result['count'][0] += relationData.length;

    //parsing workData
    List<dynamic> parsedData = await parseWork(relationData, networkUserData);
    result['data'].add(parsedData[0]);
    result['dict'].add(parsedData[1]);
    //두 다리
    List<dynamic> networkQuery = [];
    try {
      logger.w(result);
      QuerySnapshot<Map<String, dynamic>> secondNetwork = await db
          .collection('networks')
          .where(FieldPath.documentId, whereIn: networkData['list'])
          .get();
      List<QueryDocumentSnapshot<
          Map<String, dynamic>>> secondNetworkData = secondNetwork.docs;


      for (QueryDocumentSnapshot<
          Map<String, dynamic>> element in secondNetworkData) {
        Map<String, dynamic> networkList = element.data();
        networkList['list'].remove(FirebaseAuth.instance.currentUser!.uid);
        networkQuery = networkQuery + networkList['list'];
      }
      networkUsers = await db
          .collection('users')
          .where(FieldPath.documentId, whereIn: networkQuery)
          .get();
      networkUserData = networkUsers.docs;
      relation = await db
          .collection('member')
          .where('uid', whereIn: networkQuery)
          .get();
      relationData = relation.docs;

      result['count'][1] += networkUserData.length;
      result['count'][1] += relationData.length;

      parsedData = await parseWork(relationData, networkUserData);
      result['data'].add(parsedData[0]);
      result['dict'].add(parsedData[1]);
    }catch(e){
      logger.w(e);
    }
    try{
      QuerySnapshot<Map<String, dynamic>> thirdNetwork = await db
          .collection('networks')
          .where(FieldPath.documentId, whereIn: networkQuery)
          .get();
      List<QueryDocumentSnapshot<
          Map<String, dynamic>>> thirdNetworkData = thirdNetwork.docs;

      List<dynamic> lastNetworkQuery = [];
      for (QueryDocumentSnapshot<
          Map<String, dynamic>> element in thirdNetworkData) {
        Map<String, dynamic> networkList = element.data();
        for (String user in networkQuery) {
          networkList['list'].remove(user);
        }
        for (String user in networkData['list']) {
          networkList['list'].remove(user);
        }
        lastNetworkQuery = lastNetworkQuery + networkList['list'];
      }
      networkUsers = await db
          .collection('users')
          .where(FieldPath.documentId, whereIn: lastNetworkQuery)
          .get();
      networkUserData = networkUsers.docs;

      relation = await db
          .collection('member')
          .where('uid', whereIn: lastNetworkQuery)
          .get();
      relationData = relation.docs;

      result['count'][2] += networkUserData.length;
      result['count'][2] += relationData.length;

      parsedData = await parseWork(relationData, networkUserData);
      result['data'].add(parsedData[0]);
      result['dict'].add(parsedData[1]);
    } catch (e) {
      logger.w(e);
    }
    //hl
    logger.w(result);
    return result;
  }

  int boolToInt(bool expr) {
    if (expr == true) {
      return 1;
    } else {
      return 0;
    }
  }

  dynamic parseWork(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? relationData,
      List<
          QueryDocumentSnapshot<Map<String, dynamic>>>? networkUserData) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<dynamic> result = [];

    List<String> workData = [];
    List<String> workQuery = [];
    List<int> workDataCnt = [];
    Map<String, dynamic> workDict = {};
    Map<String, dynamic> leveledData = {};
    for (QueryDocumentSnapshot<Map<String, dynamic>> element
    in relationData! + networkUserData!) {
      Map<String, dynamic> member = element.data();

      if (!workData.contains(member['work'][0])) {
        workData.add(member['work'][0]);
        workDataCnt.add(1);
      } else {
        int idx = workData.indexOf(member['work'][0]);
        workDataCnt[idx]++;
      }
    }

    for (int idx = 0; idx < workData.length; idx++) {
      String first = "${workData[idx][0]}00000";
      String second = "${workData[idx].substring(0, 3)}000";

      if (!workQuery.contains(first)) {
        workQuery.add(first);
      }
      if (!workQuery.contains(second)) {
        workQuery.add(second);
      }
      if (!workQuery.contains(workData[idx])) {
        workQuery.add(workData[idx]);
      }

      if (!leveledData.containsKey(first)) {
        leveledData[first] = {};
        leveledData[first][second] = [];
      } else if (!leveledData[first].containsKey(second)) {
        leveledData[first][second] = [];
      }
      Map<String, dynamic> tmp = {};
      tmp['code'] = workData[idx];
      tmp['count'] = workDataCnt[idx];
      leveledData[first][second].add(tmp);
    }

    List<QueryDocumentSnapshot<Map<String, dynamic>>> workString = [];
    for (int index = 0; index <
        (workQuery.length / 10 + boolToInt((workQuery.length % 10) > 0))
            .toInt(); index++) {
      int start = 10 * index;
      int end = 10 * (index + 1);
      if (end > workQuery.length) {
        end = workQuery.length;
      }
      QuerySnapshot<Map<String, dynamic>> workDocument =
      await db.collection('workData').where(
          'code', whereIn: workQuery.sublist(start, end)).get();
      workString.addAll(workDocument.docs);
    }

    for (int idx = 0; idx < workString.length; idx++) {
      Map<String, dynamic> work = workString[idx].data();
      workDict[work['code']] = work['title'];
    }
    leveledData.keys;
    result.add(leveledData);
    result.add(workDict);
    return result;
  }
}
