import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/pages/project_confirm_page.dart';
import 'package:connec/style/buttonstyle.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../components/custom_edit_textform.dart';
import 'package:http/http.dart' as http;
import '../../services/service_class.dart';

class ExpandNetworkPage extends StatefulWidget {
  const ExpandNetworkPage({Key? key}) : super(key: key);

  @override
  State<ExpandNetworkPage> createState() => _ExpandNetworkPageState();
}

class _ExpandNetworkPageState extends State<ExpandNetworkPage> {
  String? _projectCode;
  final _formKey = GlobalKey<FormState>();
  final logger = Logger();

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
                            if (value == "") {
                              return "빈칸입니다";
                            } else if (value ==
                                FirebaseAuth.instance.currentUser!.uid
                                    .toString()) {
                              return "잘못된 입력입니다.";
                            } else {
                              return null;
                            }
                          },
                          isSecret: false,
                          onSaved: (newValue) => _projectCode = newValue,
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

          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();


            final url =
                Uri.parse('https://foggy-boundless-avenue.glitch.me/project/share');
            try {
              http.Response response = await http.post(
                url,
                headers: <String, String>{
                  'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: <String, String>{
                  'uid' : FirebaseAuth.instance.currentUser!.uid,
                  'docId': "${_projectCode}",
                },
              );
              logger.w(response.body);
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectConfirmPage(_projectCode!,response.body),));

            } catch (e) {
              logger.w(e);
            }
          }
        },
        style: featureButton,
        child: Text(
          '등록하기',
          style: buttonText,
        ),
      ),
    );
  }

}
