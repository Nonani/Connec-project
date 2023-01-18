import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/mypage/change_email_page.dart';
import 'package:connec/pages/mypage/change_name_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AccountSettingPaqe extends StatefulWidget {
  const AccountSettingPaqe({Key? key}) : super(key: key);

  @override
  State<AccountSettingPaqe> createState() => _AccountSettingPaqeState();
}

class _AccountSettingPaqeState extends State<AccountSettingPaqe> {
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
                '계정 설정',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  height: 200,
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 110, right: 110, top: 35, bottom: 45),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffafafaf),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 29, right: 24),
                  child: Column(
                    children: [
                      buildContainer(
                          label: "이름",
                          text: "${snapshot.data["name"]}",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeNamePage(),)).then((value) => setState((){}),);
                          }),
                      buildContainer(
                          label: "이메일",
                          text: "${snapshot.data["email"]}",
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeEmailPage(),)).then((value) => setState((){}),);
                          }),
                      (snapshot.data["serviceName"] == "None")
                          ? buildContainer(
                              label: "비밀번호",
                              text: "***********",
                              onPressed: () {})
                          : Container(),
                      buildContainer(
                          label: "전화번호",
                          text: "010-1234-5678",
                          onPressed: () {}),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '계정 탈퇴',
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_right,
                              color: Color(0xffafafaf),
                            ),
                            onPressed: () async{
                              Logger logger = Logger();
                              final db = FirebaseFirestore.instance;
                              final uid = FirebaseAuth.instance.currentUser!.uid;
                              await db.collection("deviceToken").doc(FirebaseAuth.instance.currentUser!.uid).delete().then(
                                    (doc) => print("Document deleted"),
                                onError: (e) => print("Error updating document $e"),
                              );
                              QuerySnapshot members = await db.collection("member").where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
                              members.docs.forEach((doc) => doc.reference.delete());
                              await db.collection("networks").doc(FirebaseAuth.instance.currentUser!.uid).delete().then(
                                    (doc) => print("Document deleted"),
                                onError: (e) => print("Error updating document $e"),
                              );
                              await db.collection("notification").doc(FirebaseAuth.instance.currentUser!.uid).delete().then(
                                    (doc) => print("Document deleted"),
                                onError: (e) => print("Error updating document $e"),
                              );
                              await db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).delete().then(
                                    (doc) => print("Document deleted"),
                                onError: (e) => print("Error updating document $e"),
                              );
                              await FirebaseAuth.instance.currentUser!.delete();
                              await FirebaseAuth.instance.signOut();
                              Navigator.popUntil(context, (route) => route.isFirst);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Container buildContainer(
      {required String label,
      required String text,
      required VoidCallback onPressed}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '${label}',
            style: TextStyle(
              color: Color(0xff5f66f2),
              fontFamily: 'S-CoreDream-4Regular',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text != "null" ? '${text}' : '없음',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Color(0xffafafaf),
                ),
                onPressed: onPressed,
              ),
            ],
          ),
          Divider(
            thickness: 1,
          ),
        ],
      ),
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
