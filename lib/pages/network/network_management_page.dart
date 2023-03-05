import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/common_bottom_navigation_bar.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
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
    "assets/images/first_deg.png",
    "assets/images/second_deg.png",
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
          child:Text(
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
                  builder: (context) => Dialog(
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
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("확인"))
                        ],
                      ),
                    ),
                  ),
                );
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
                    future: data(),
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
                            children: const [
                              Text(
                                "총 지인",
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

  Future data() async {
    Logger logger = Logger();

    Map<String, dynamic> result = {};
    result['count'] = [0, 0, 0];
    result['data'] = [];
    result['dict'] = [];

    Map<String, dynamic> firstData = {};
    Map<String, dynamic> secondData = {};
    Map<String, dynamic> thirdData = {};

    // 한 다리

    firstData = await firstQueryData(FirebaseAuth.instance.currentUser!.uid);

    //parsing workData
    List<dynamic> parsedData = await parseWork(firstData['networkUserData']);

    result['count'][0] = firstData['count'];
    result['data'].add(parsedData[0]);
    result['dict'].add(parsedData[1]);
    //두 다리
    try {
      secondData = await secondQueryData(firstData['networkData']);
      parsedData = await parseWork(secondData['networkUserData']);
      result['count'][1] = secondData['count'];
      result['data'].add(parsedData[0]);
      result['dict'].add(parsedData[1]);
    } catch (e) {
      logger.w(e);
    }
    try {
      thirdData = await thirdQueryData(
          firstData['networkData'], secondData['networkData']);
      logger.w(thirdData);
      parsedData = await parseWork(thirdData['networkUserData']);
      result['count'][2] = thirdData['count'];
      logger.w(thirdData['count']);
      result['data'].add(parsedData[0]);
      result['dict'].add(parsedData[1]);
    } catch (e) {
      logger.w(e);
    }
    return result;
  }

  int boolToInt(bool expr) {
    if (expr == true) {
      return 1;
    } else {
      return 0;
    }
  }

  dynamic firstQueryData(dynamic query) async {
    Map<String, dynamic> result = {};
    FirebaseFirestore db = FirebaseFirestore.instance;

    result['count'] = 0;

    DocumentSnapshot<Map<String, dynamic>> firstNetwork =
        await db.collection('networks').doc(query).get();
    Map<String, dynamic>? networkData = firstNetwork.data();
    QuerySnapshot<Map<String, dynamic>> networkUsers = await db
        .collection('users')
        .where(FieldPath.documentId, whereIn: networkData!['list'])
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? networkUserData =
        networkUsers.docs;
    // QuerySnapshot<Map<String, dynamic>> relation = await db
    //     .collection('member')
    //     .where('uid', whereIn: networkData['list'])
    //     .get();
    // List<QueryDocumentSnapshot<Map<String, dynamic>>>? relationData =
    //     relation.docs;

    result['networkData'] = networkData['list'];
    result['networkUserData'] = networkUserData;
    // result['relationData'] = relationData;

    result['count'] += networkUserData.length;
    // result['count'] += relationData.length;

    return result;
  }

  dynamic secondQueryData(List<dynamic> networkData) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    List<dynamic> networkQuery = [];
    Map<String, dynamic> result = {};

    result['count'] = 0;
    QuerySnapshot<Map<String, dynamic>> secondNetwork = await db
        .collection('networks')
        .where(FieldPath.documentId, whereIn: networkData)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> secondNetworkData =
        secondNetwork.docs;

    for (QueryDocumentSnapshot<Map<String, dynamic>> element
        in secondNetworkData) {
      Map<String, dynamic> networkList = element.data();
      networkList['list'].remove(FirebaseAuth.instance.currentUser!.uid);
      networkQuery = networkQuery + networkList['list'];
    }

    List<QueryDocumentSnapshot<Map<String, dynamic>>> networkUserData = [];
    for (int index = 0;
        index <
            (networkQuery.length / 10 +
                    boolToInt((networkQuery.length % 10) > 0))
                .toInt();
        index++) {
      int start = 10 * index;
      int end = 10 * (index + 1);
      if (end > networkQuery.length) {
        end = networkQuery.length;
      }
      QuerySnapshot<Map<String, dynamic>> networkUsers = await db
          .collection('users')
          .where(FieldPath.documentId,
              whereIn: networkQuery.sublist(start, end))
          .get();
      networkUserData.addAll(networkUsers.docs);
    }

    // List<QueryDocumentSnapshot<Map<String, dynamic>>>? relationData = [];
    // for (int index = 0; index < (networkQuery.length / 10 + boolToInt((networkQuery.length % 10) > 0)).toInt(); index++) {
    //   int start = 10 * index;
    //   int end = 10 * (index + 1);
    //   if (end > networkQuery.length) {
    //     end = networkQuery.length;
    //   }
    //   QuerySnapshot<Map<String, dynamic>> relation = await db
    //       .collection('member')
    //       .where('uid', whereIn: networkQuery.sublist(start, end))
    //       .get();
    //   relationData.addAll(relation.docs);
    // }

    result['networkData'] = networkQuery;
    result['networkUserData'] = networkUserData;
    // result['relationData'] = relationData;

    result['count'] += networkUserData.length;
    // result['count'] += relationData.length;

    return result;
  }

  dynamic thirdQueryData(
      dynamic firstNetworkData, dynamic secondNetworkData) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> result = {};
    List<dynamic> lastNetworkQuery = [];

    result['count'] = 0;

    List<QueryDocumentSnapshot<Map<String, dynamic>>> thirdNetworkData = [];
    for (int index = 0;
        index <
            (secondNetworkData.length / 10 +
                    boolToInt((secondNetworkData.length % 10) > 0))
                .toInt();
        index++) {
      int start = 10 * index;
      int end = 10 * (index + 1);
      if (end > secondNetworkData.length) {
        end = secondNetworkData.length;
      }
      QuerySnapshot<Map<String, dynamic>> thirdNetwork = await db
          .collection('networks')
          .where(FieldPath.documentId,
              whereIn: secondNetworkData.sublist(start, end))
          .get();
      thirdNetworkData.addAll(thirdNetwork.docs);
    }

    for (QueryDocumentSnapshot<Map<String, dynamic>> element
        in thirdNetworkData) {
      Map<String, dynamic> networkList = element.data();
      for (String user in firstNetworkData) {
        networkList['list'].remove(user);
      }
      for (String user in secondNetworkData) {
        networkList['list'].remove(user);
      }
      lastNetworkQuery = lastNetworkQuery + networkList['list'];
    }

    List<QueryDocumentSnapshot<Map<String, dynamic>>>? networkUserData = [];
    for (int index = 0;
        index <
            (lastNetworkQuery.length / 10 +
                    boolToInt((lastNetworkQuery.length % 10) > 0))
                .toInt();
        index++) {
      int start = 10 * index;
      int end = 10 * (index + 1);
      if (end > lastNetworkQuery.length) {
        end = lastNetworkQuery.length;
      }
      QuerySnapshot<Map<String, dynamic>> networkUsers = await db
          .collection('users')
          .where(FieldPath.documentId,
              whereIn: lastNetworkQuery.sublist(start, end))
          .get();
      networkUserData.addAll(networkUsers.docs);
    }

    // List<QueryDocumentSnapshot<Map<String, dynamic>>>? relationData = [];
    // for (int index = 0; index < (lastNetworkQuery.length / 10 + boolToInt((lastNetworkQuery.length % 10) > 0)).toInt(); index++) {
    //   int start = 10 * index;
    //   int end = 10 * (index + 1);
    //   if (end > lastNetworkQuery.length) {
    //     end = lastNetworkQuery.length;
    //   }
    //   QuerySnapshot<Map<String, dynamic>> relation = await db
    //       .collection('member')
    //       .where('uid', whereIn: lastNetworkQuery.sublist(start, end))
    //       .get();
    //   relationData.addAll(relation.docs);
    // }

    logger.w(result);
    result['networkUserData'] = networkUserData;
    result['count'] += networkUserData.length;
    // result['count'] += relationData.length;
    return result;
  }

  dynamic parseWork(
      List<QueryDocumentSnapshot<Map<String, dynamic>>>?
          networkUserData) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<dynamic> result = [];

    List<String> workData = [];
    List<String> workQuery = [];
    List<int> workDataCnt = [];
    Map<String, dynamic> workDict = {};
    Map<String, dynamic> leveledData = {};

    logger.w(networkUserData);

    for (QueryDocumentSnapshot<Map<String, dynamic>> element
        in networkUserData!) {
      Map<String, dynamic> member = element.data();
      if (!workData.contains(member['workArea'][0])) {
        workData.add(member['workArea'][0]);
        workDataCnt.add(1);
      } else {
        int idx = workData.indexOf(member['workArea'][0]);
        workDataCnt[idx]++;
      }
    }

    for (int idx = 0; idx < workData.length; idx++) {
      String first = "${workData[idx][0]}00";

      // overlap check
      if (!workQuery.contains(first)) {
        workQuery.add(first);
      }
      if (!workQuery.contains(workData[idx])) {
        workQuery.add(workData[idx]);
      }

      if (!leveledData.containsKey(first)) {
        leveledData[first] = [];
      }
      Map<String, dynamic> tmp = {};
      tmp['code'] = workData[idx];
      tmp['count'] = workDataCnt[idx];
      leveledData[first].add(tmp);
    }
    // cut list with size below 10

    List<QueryDocumentSnapshot<Map<String, dynamic>>> workString = [];
    for (int index = 0;
        index <
            (workQuery.length / 10 + boolToInt((workQuery.length % 10) > 0))
                .toInt();
        index++) {
      int start = 10 * index;
      int end = 10 * (index + 1);

      if (end > workQuery.length) {
        end = workQuery.length;
      }
      QuerySnapshot<Map<String, dynamic>> workDocument = await db
          .collection('workData')
          .where('code', whereIn: workQuery.sublist(start, end))
          .get();
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
