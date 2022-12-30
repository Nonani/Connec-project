import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/expand_network_page.dart';
import 'package:connec/pages/test_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'main_page.dart';

class AddMemberPage extends StatefulWidget {
  const AddMemberPage({Key? key}) : super(key: key);

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          if (snapshot.data.size < 5) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  toolbarHeight: 55,
                  leadingWidth: 20,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xff5f66f2),
                    ),
                    onPressed: () async =>
                        await FirebaseAuth.instance.signOut(),
                  ),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '지인 등록 후 이용해주세요',
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        '컨넥 서비스를 이용하기 위해\n로그인이 필요합니다',
                        style: TextStyle(
                          color: Color(0xff999999),
                        ),
                      ),
                      SizedBox(height: 85),
                      Container(
                        width: 180,
                        height: 40,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor:
                                MaterialStateProperty.all(Color(0xff5f66f2)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                DialogRoute(
                                  context: context,
                                  builder: (context) => TestPage(),
                                )).then((_) => setState(() {}));
                            ;
                          },
                          child: Text(
                            '지인 등록',
                            style: TextStyle(
                              color: Color(0xfffafafa),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return MainPage();
          }
        });
  }

  Future _future() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    print(FirebaseAuth.instance.currentUser!.uid.toString());
    final result = await db
        .collection("member")
        .where("uid",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    logger.w(result.size);
    return result;
  }
}
