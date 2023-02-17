import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_item_widget.dart';
import 'package:connec/pages/network/network_reduction_page.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'expand_network_page.dart';

class NetworkListPage extends StatefulWidget {
  const NetworkListPage({Key? key}) : super(key: key);

  @override
  State<NetworkListPage> createState() => _NetworkListPageState();
}

class _NetworkListPageState extends State<NetworkListPage> {
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


  @override
  Widget build(BuildContext context) {
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
                  title: Text(
                    'CONNEC',
                    style: connecTitle,
                  ),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        icon: Icon(Icons.link_sharp),
                        color: Color(0xff5f66f2),
                        onPressed: () async{
                          final db = FirebaseFirestore.instance;
                          final result = await db.collection("users").doc("${FirebaseAuth.instance.currentUser!.uid}").get();
                          logger.w(FirebaseAuth.instance.currentUser!.uid);
                          Clipboard.setData(ClipboardData(text: result["uuid"]));
                        }),
                  ],
                ),
                body: Column(children: [
                  Container(
                      height: 600,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 27, bottom: 9),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snapshot.data['length'],
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NetworkReductionPage(snapshot.data['users'][index]['uid'], snapshot.data['users'][index]['acquaintances']),
                                    ));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 14),
                                child: SizedBox(
                                  width: 360,
                                  height: 120,
                                  child: NetworkItemWidget(
                                    nameStyle: _nameStyle,
                                    contextStyle: _contextStyle,
                                    name: snapshot.data['users'][index]['name'],
                                    rate: snapshot.data['users'][index]['rate'].toString(),
                                    number: snapshot.data['users'][index]['acquaintances'].toString(),
                                    representative: snapshot.data['users'][index]['personality'][0],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ]))),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExpandNetworkPage(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(247.3, 55.9),
                      backgroundColor: Color(0xfffafafa),
                      side: const BorderSide(
                        color: Color(0xff5f66f2),
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      '네트워크를 확장 해주세요',
                      style: TextStyle(
                        color: Color(0xff5f66f2),
                        fontSize: 18,
                        fontFamily: 'EchoDream',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ]),

                );
          }
        });
  }

  Future _future() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    print(FirebaseAuth.instance.currentUser!.uid.toString());
    final list = await db
        .collection("networks")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    Map<String, dynamic> result = {};
    result['length'] = list.data()?['list'].length;
    result['users'] = [];
    for (String uid in list.data()?['list']) {
      var tmp = await db.collection('users').doc(uid).get();
      var data = tmp.data();
      var acquaintances =  await db.collection('members').where('uid', isEqualTo: tmp.data()?['uid']).get();
      logger.w(acquaintances.docs.length);
      data!['acquaintances'] = acquaintances.docs.length;
      result['users'].add(data);
    }
    logger.w(result);

    return result;
  }
}
