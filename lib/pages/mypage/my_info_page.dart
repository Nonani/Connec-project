import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/pages/mypage/account_setting_page.dart';
import 'package:connec/pages/mypage/notification_list_page.dart';
import 'package:connec/pages/mypage/purchase_history.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                '마이페이지',
                style: featureTitle,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                              height: 55,
                              width: 55,
                              margin: EdgeInsets.only(
                                left: 18,
                                right: 18,
                              ),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffafafaf),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(
                                    snapshot.data['user']['profile_image_url'],
                                    fit: BoxFit.cover,
                                  ))),
                          Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data['user']['name']} 님',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 17,
                                    fontFamily: 'S-CoreDream-6Bold',
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Text(
                                  '사용자 평점: ${snapshot.data['user']['rate']} / 5.0',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 12,
                                    fontFamily: 'S-CoreDream-6Bold',
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Text(
                                  '지인 평점:  ${snapshot.data['user']['networkRate']} / 5.0',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 12,
                                    fontFamily: 'S-CoreDream-6Bold',
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                // Text(
                                //   snapshot.data['email'] != null
                                //       ? '${snapshot.data['email']}'
                                //       : 'email이 등록되지 않았습니다.',
                                //   style: TextStyle(
                                //     color: Color(0xffbdbdbd),
                                //     fontSize: 16,
                                //     fontFamily: 'S-CoreDream-4Regular',
                                //     fontWeight: FontWeight.w700,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccountSettingPaqe(),
                              )).then((value) => setState(() {}));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                          margin: EdgeInsets.only(right: 10),
                          height: 26,
                          decoration: BoxDecoration(
                            color: Color(0xff5f66f2),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Text(
                            '계정설정',
                            style: TextStyle(
                              color: Color(0xfffafafa),
                              fontSize: 12,
                              fontFamily: 'S-CoreDream-5',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => IAPHistory()))
                              .then((value) => setState(
                                    () {},
                                  ));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffeeeeee),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.card_travel_rounded,
                                    size: 30.0,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '쿠폰함',
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '보유 쿠폰',
                                    style: TextStyle(
                                      color: Color(0xffafafaf),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    snapshot.data['couponCnt'].toString(),
                                    style: TextStyle(
                                      color: Color(0xff5f66f2),
                                      fontSize: 13,
                                      fontFamily: 'S-CoreDream-5',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IAPConnec(),
                              )).then((value) => setState(
                                () {},
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffeeeeee),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.payment_outlined,
                                size: 30.0,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '결제',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NoticeListPage(),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffeeeeee),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.message_outlined,
                                size: 30.0,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '연락 현황',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("test");
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffeeeeee),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications_none_outlined,
                                size: 30.0,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '알림 설정',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("test");
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffeeeeee),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 30.0,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '공지사항',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print("test");
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffeeeeee),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.summarize_outlined,
                                size: 30.0,
                                color: Colors.blue,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '컨넥 안내',
                                style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffeeeeee),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outlined,
                                    size: 30.0,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    '앱 버전',
                                    style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '1.0.0',
                                style: TextStyle(
                                  color: Color(0xffafafaf),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ))
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
