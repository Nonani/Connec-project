import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/pages/searchpage/search_network_detail_page.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/member_item_widget.dart';

class SearchNetworkPage extends StatelessWidget {
  const SearchNetworkPage(this.code, {Key? key}) : super(key: key);
  final String code;
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
    final db = FirebaseFirestore.instance;

    var user = await db
        .collection("users")
        .where("workArea", arrayContains: code)
        .get();
    var member = await db
        .collection("member")
        .where("workArea", arrayContains: code)
        .get();
    Map<String, dynamic> data = {};
    data['list'] = List.empty(growable: true);

    int user_cnt = 0, member_cnt = 0;
    for (var element in user.docs) {
      var elementData = element.data();
      QuerySnapshot<Map<String, dynamic>> tmp = await db
          .collection('workData')
          .where('code', isEqualTo: elementData['workArea'][0])
          .get();
      elementData['lTitle'] = tmp.docs[0]['title'];
      tmp = await db
          .collection('workData')
          .where('code', isEqualTo: '${elementData['workArea'][0][0]}00')
          .get();
      elementData['bTitle'] = tmp.docs[0]['title'];
      tmp = await db
          .collection('localData')
          .where('code', isEqualTo: elementData['location'])
          .get();
      elementData['location'] = tmp.docs[0]['title'];

      if (element["uid"] != FirebaseAuth.instance.currentUser!.uid) {
        data['list'].add(elementData);
        user_cnt++;
      }
    }

    for (var element in member.docs) {
      var elementData = element.data();
      QuerySnapshot<Map<String, dynamic>> tmp = await db
          .collection('workData')
          .where('code', isEqualTo: elementData['workArea'][0])
          .get();
      elementData['lTitle'] = tmp.docs[0]['title'];
      tmp = await db
          .collection('workData')
          .where('code', isEqualTo: '${elementData['workArea'][0][0]}00')
          .get();
      elementData['bTitle'] = tmp.docs[0]['title'];
      tmp = await db
          .collection('localData')
          .where('code', isEqualTo: elementData['location'])
          .get();
      elementData['location'] = tmp.docs[0]['title'];

      if (element["uid"] != FirebaseAuth.instance.currentUser!.uid) {
        data['list'].add(elementData);
        member_cnt++;
      }
    }
    data['length'] = user_cnt + member_cnt;

    return data;
  }
}
