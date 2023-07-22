import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/pages/mypage/account_setting_page.dart';
import 'package:connec/pages/mypage/purchase_history.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../project_regist_page.dart';
import 'In_app_purchase_connec.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
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
              elevation: 0,
              toolbarHeight: 80,
              backgroundColor: const Color(0xfffafafa),
              shape: const Border(
                  bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xff5f66f2),
                ),
                onPressed: () => FirebaseAuth.instance.signOut(),
              ),
              title: Text(
                '마이페이지',
                style: featureTitle,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 110, right: 110, top: 35, bottom: 45),
                      child: Image.network(""),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffafafaf),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Center(
                        child: Text(
                          "이름",
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: Text("직업"),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10.0, right: 10, bottom: 10),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "프로젝트 키워드",
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 17,
                        fontFamily: 'EchoDream',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "#AI #머신러닝 #HR테크 #자연어처리\n#블록체인 #앱서비스 #백엔드",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontFamily: 'EchoDream',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10.0, right: 10, bottom: 10),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "개인정보",
                      style: TextStyle(
                        color: Color(0xff333333),
                        fontSize: 17,
                        fontFamily: 'EchoDream',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      "  나 이 :\n  성 별 : \n전화번호 :\n활동지역 :\n",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 17,
                        fontFamily: 'EchoDream',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10, left: 10.0, right: 10, bottom: 10),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "프로젝트\t",
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 17,
                                fontFamily: 'EchoDream',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text("※ 최대 10개",style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontFamily: 'EchoDream',
                              fontWeight: FontWeight.w600,
                            ),)
                          ],
                        ),
                        IconButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => ProjectRegistPage(),));}, icon: Icon(Icons.add_circle, color: Colors.blue,))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future _future() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, dynamic> result = {};
    DocumentSnapshot<Map<String, dynamic>> user = await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    DocumentSnapshot<Map<String, dynamic>> couponCnt = await db
        .collection('coupons')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    Map<String, dynamic>? tmp = user.data();
    List<dynamic> networks = (await db
            .collection('networks')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get())
        .data()!['list'];
    var logger = Logger();
    try {
      double networkRate = 0.0;
      List<QueryDocumentSnapshot<Map<String, dynamic>>> data = (await db
              .collection('users')
              .where(FieldPath.documentId, whereIn: networks)
              .get())
          .docs;
      for (QueryDocumentSnapshot<Map<String, dynamic>> user in data) {
        networkRate += user.data()['rate'];
      }
      networkRate /= networks.length;
      tmp!['networkRate'] = networkRate;
    } catch (e) {
      logger.w(e);
    }

    result['user'] = tmp;
    result['couponCnt'] = couponCnt['num'];
    return result;
  }
}
