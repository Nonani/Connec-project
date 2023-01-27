import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/pages/member_body_page.dart';
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
            return CustomLoadingDialog();
          }
          if (snapshot.data.size < 2) {
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
                      Container(
                        height: 112,
                        width: 112,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xff5f66f2),
                          shape: BoxShape.circle,
                          // image: DecorationImage(
                          //   image: AssetImage(
                          //       'assets/images/navigation_icon_2.png'),
                          // )
                        ),
                        child: ImageIcon(
                          AssetImage('assets/images/navigation_icon_2.png'),
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 17),
                      Text(
                        '지인 등록 후 이용해주세요',
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        '현재 ( ${snapshot.data.size} ) 명의 지인이 등록되었습니다.\n2명의 지인이 등록될 경우,\n해당 서비스를 이용할 수 있습니다.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff999999),
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 85),
                      Text(
                        '현재 등록 지인 ( ${snapshot.data.size} / 2 )',
                        style: TextStyle(
                          color: Color(0xff999999),
                        ),
                      ),
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
                                MaterialPageRoute(
                                  builder: (context) => MemberBodyPage( mode: '0'),
                                )).then((_) => setState(() {}));

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
    final result = await db
        .collection("member")
        .where("uid",
            isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
        .get();
    return result;
  }
}
