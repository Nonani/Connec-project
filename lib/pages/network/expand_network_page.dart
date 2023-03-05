import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/add_member_page.dart';
import 'package:connec/style/buttonstyle.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../components/custom_dialog.dart';
import '../../components/custom_edit_textform.dart';
import 'package:http/http.dart' as http;
import '../../services/service_class.dart';

class ExpandNetworkPage extends StatefulWidget {
  const ExpandNetworkPage({Key? key}) : super(key: key);

  @override
  State<ExpandNetworkPage> createState() => _ExpandNetworkPageState();
}

class _ExpandNetworkPageState extends State<ExpandNetworkPage> {
  String? _userCode;
  final _formKey = GlobalKey<FormState>();
  final logger = Logger();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    //var provider = Provider.of<ServiceClass>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
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
          "지인 등록",
          style: featureTitle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: const Icon(Icons.link_sharp),
              color: const Color(0xff5f66f2),
              onPressed: () async {
                final db = FirebaseFirestore.instance;
                final result = await db
                    .collection("users")
                    .doc("${FirebaseAuth.instance.currentUser!.uid}")
                    .get();
                logger.w(FirebaseAuth.instance.currentUser!.uid);
                Clipboard.setData(ClipboardData(text: result["uuid"]));
              }),
        ],
      ),
      body: Consumer<ServiceClass>(
        builder: (context, data, child) {
          return data.loading
              ? const Text("네트워크 확장")
              : SafeArea(
                  child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 47.1),
                        child: LoginEditTextForm(
                          label: "등록할 지인 코드",
                          hint: "지인의 코드를 입력해 주세요",
                          validate: (value) {
                            if(value == ""){
                              return "빈칸입니다";
                            }else if(value == FirebaseAuth.instance.currentUser!.uid.toString()){
                              return "잘못된 입력입니다.";
                            }else{
                              return null;
                            }
                          },
                          isSecret: false,
                          onSaved: (newValue) => _userCode = newValue,
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(left: 22.5, top: 8.1),
                          child: Text(
                            "서로가 모두 네트워크 확장을 신청하면 2~3일 이내\n네트워크가 업데이트 됩니다.",
                            style: TextStyle(
                              color: Color(0xffafafaf),
                              fontSize: 11.5,
                              fontFamily: 'EchoDream',
                            ),
                          )),
                    ],
                  ),
                ));
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {

          QuerySnapshot<Map<String, dynamic>> memberData = await db
              .collection('member')
              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .get();
          if (memberData.docs.length > 1) {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if(await isAlreadyNetwork()){
                // 이미 네트워크 추가가 된 경우
                print("이미 네트워크 추가가 된 유저입니다.");
                return;
              }
              var info = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get();
              var data = info.data();
              final url =
                  Uri.parse('https://foggy-boundless-avenue.glitch.me/sendReq');
              try {
                http.Response response = await http.post(
                  url,
                  headers: <String, String>{
                    'Content-Type': 'application/x-www-form-urlencoded',
                  },
                  body: <String, String>{
                    'case': 'network',
                    'to': '$_userCode',
                    'from': "${data!['uuid']}",
                  },
                );
                Navigator.pop(context);
                logger.w(response.body);
              } catch (e) {
                logger.w(info.data());
              }
            }
          }
          else {
            Navigator.push(
                context, MaterialPageRoute(
              builder: (context) =>
                  AddMemberPage(),
            ));
          }
        },
        style: featureButton,
        child: Text('확장하기',
          style: buttonText,
        ),
      ),
    );
  }

  Future<bool> isAlreadyNetwork() async {
    final to_user = await db.collection("users").where("uuid", isEqualTo: _userCode).get();
    if(to_user.docs.length == 0) {
      return true;
    }else{
      final to_uid = to_user.docs[0].data()['uid'];
      final cur_user = (await db.collection("networks").doc(FirebaseAuth.instance.currentUser!.uid).get()).data();
      if(cur_user!["list"].contains(_userCode)) {
        return true;
      } else {
        final my_data = (await db.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get()).data();
        if(my_data!["uuid"].toString() == _userCode){
          return true;
        }
        return false;
      }
    }
  }
}
