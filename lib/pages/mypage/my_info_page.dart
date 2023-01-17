import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/mypage/account_setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
          return SafeArea(
              child: Center(
            child: CircularProgressIndicator(),
          ));
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
              title: const Text(
                '마이페이지',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 20,
                  fontFamily: 'S-CoreDream-5Medium',
                  fontWeight: FontWeight.w500,
                ),
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
                            height: 48,
                            width: 48,
                            margin: EdgeInsets.only(
                              left: 18,
                              right: 18,
                            ),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffafafaf),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data['name']} 님',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 17,
                                    fontFamily: 'S-CoreDream-6Bold',
                                    fontWeight: FontWeight.w200,
                                  ),
                                ),
                                Text(
                                  snapshot.data['email'] != null
                                      ? '${snapshot.data['email']}'
                                      : 'email이 등록되지 않았습니다.',
                                  style: TextStyle(
                                    color: Color(0xffbdbdbd),
                                    fontSize: 16,
                                    fontFamily: 'S-CoreDream-4Regular',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
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
                              ));
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
                  Expanded(
                    child: ListView(
                      children: [],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future _future() async {
    Logger logger = Logger();
    FirebaseFirestore db = FirebaseFirestore.instance;
    final result = await db
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    logger.w(result.data());
    return result;
  }
}
