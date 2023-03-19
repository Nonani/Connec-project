import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/pages/searchpage/search_network_detail_page.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../components/member_item_widget.dart';

class SearchNetworkPage extends StatelessWidget {
  SearchNetworkPage(this.code, {Key? key}) : super(key: key);
  final String code;
  final logger = Logger();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextStyle _nameStyle = const TextStyle(
    color: Color(0xff333333),
    fontSize: 15,
    fontFamily: 'S-CoreDream-6Bold',
    fontWeight: FontWeight.w500,
  );
  final TextStyle _classStyle = const TextStyle(
    color: Color(0xff999999),
    fontSize: 9,
    fontFamily: 'EchoDream',
    fontWeight: FontWeight.w200,
  );
  final TextStyle _contextStyle = const TextStyle(
    color: Color(0xffafafaf),
    fontSize: 11,
    fontFamily: 'EchoDream',
    fontWeight: FontWeight.w200,
  );
  final TextStyle _itemStyle = const TextStyle(
    color: Color(0xff333333),
    fontSize: 11,
    fontFamily: 'EchoDream',
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CustomLoadingDialog();
        } else {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff5f66f2),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              shape: const Border(
                  bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
              backgroundColor: Color(0xfffafafa),
              elevation: 0,
              title: Text(
                'CONNEC',
                style: connecTitle,
              ),
              centerTitle: true,
            ),
            body: (snapshot.data["length"] == 0)
                ? Center(
                    child: Text("등록된 정보가 없습니다."),
                  )
                : Column(children: [
                    Container(
                        height: 540,
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 18, bottom: 9),
                        child: SingleChildScrollView(
                            child: Column(children: [
                          ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            itemCount: snapshot.data['length'],
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SearchNetworkDetailPage(
                                        snapshot.data!['list'][index]);
                                  }));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 7),
                                  child: SizedBox(
                                    width: 360,
                                    height: 130,
                                    child: MemberItemWidget(
                                        nameStyle: _nameStyle,
                                        classStyle: _classStyle,
                                        contextStyle: _contextStyle,
                                        itemStyle: _itemStyle,
                                        mainField: snapshot.data['list'][index]
                                            ['bTitle'],
                                        subField: snapshot.data['list'][index]
                                            ['lTitle'],
                                        // field: snapshot.data['list'][index]['work'],
                                        rate: '0',
                                        relationship: '한 다리',
                                        pCapability: snapshot.data['list']
                                            [index]['personality'][0],
                                        sCapability: snapshot.data['list']
                                            [index]['personality'][1]),
                                  ),
                                ),
                              );
                            },
                          ),
                        ]))),
                  ]),
          );
        }
      },
    );
  }

  Future _future() async {
    final logger = Logger();
    Map<String, dynamic> data = {};

    data['list'] = [];
    data['length'] = 0;
    List<dynamic> firstUser = [];
    List<dynamic> secondUser = [];
    List<dynamic> thirdUser = [];

    //한다리
    try {
      firstUser = (await db
              .collection('networks')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get())
          .data()!['list'];

      for (String user in firstUser) {
        if (user != FirebaseAuth.instance.currentUser!.uid) {
          Map<String, dynamic>? tmp =
              (await db.collection('users').doc(user).get()).data();
          if (tmp!['workArea'].contains(code)) {
            tmp = await getTitle(tmp);
            data['list'].add(tmp);
          }
        }
      }
    } catch (e) {
      logger.w(e);
    }

    //두다리
    try {
      for (var users in (await db
              .collection('networks')
              .where(FieldPath.documentId, whereIn: firstUser)
              .get())
          .docs) {
        for (var user in users.data()['list']) {
          if (user != FirebaseAuth.instance.currentUser!.uid &&
              !firstUser.contains(user)) {
            secondUser.add(user);
          }
        }
      }
      for (String user in secondUser) {
        Map<String, dynamic>? tmp =
            (await db.collection('users').doc(user).get()).data();
        if (tmp!['workArea'].contains(code)) {
          tmp = await getTitle(tmp);
          data['list'].add(tmp);
        }
      }
    } catch (e) {
      logger.w(e);
    }

    //세다리
    try {
      for (var users in (await db
              .collection('networks')
              .where(FieldPath.documentId, whereIn: secondUser)
              .get())
          .docs) {
        for (var user in users.data()['list']) {
          if (user != FirebaseAuth.instance.currentUser!.uid &&
              !firstUser.contains(user) &&
              !secondUser.contains(user)) {
            thirdUser.add(user);
          }
        }
      }
      for (String user in thirdUser) {
        Map<String, dynamic>? tmp =
            (await db.collection('users').doc(user).get()).data();
        if (tmp!['workArea'].contains(code)) {
          tmp = await getTitle(tmp);
          data['list'].add(tmp);
        }
      }
    } catch (e) {
      logger.w(e);
    }

    data['length'] = data['list'].length;
    return data;
  }

  Future<Map<String, dynamic>> getTitle(Map<String, dynamic> data) async {
    List<QueryDocumentSnapshot<Map<String, dynamic>>> work = (await db
            .collection('workData')
            .where(FieldPath.documentId, whereIn: [code, "${code[0]}00"]).get())
        .docs;
    for (QueryDocumentSnapshot<Map<String, dynamic>> element in work) {
      if (element['code'] == "${code[0]}00") {
        data['bTitle'] = element.data()['title'];
      } else {
        data['lTitle'] = element.data()['title'];
      }
    }
    String location = (await db
            .collection('localData')
            .where('code', isEqualTo: data['location'])
            .get())
        .docs[0]
        .data()['title'];
    logger.w(location);
    data['location'] = location;
    return data;
  }
}
