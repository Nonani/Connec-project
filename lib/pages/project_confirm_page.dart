import 'dart:convert';

import 'package:connec/components/custom_edit_textform.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import '../components/custom_dialog.dart';
import '../style/buttonstyle.dart';
import '../style/titlestyle.dart';

class ProjectConfirmPage extends StatefulWidget {
  const ProjectConfirmPage(this.docID, this.res, {Key? key}) : super(key: key);
  final String res;
  final String docID;

  @override
  State<ProjectConfirmPage> createState() => _ProjectConfirmPageState();
}

class _ProjectConfirmPageState extends State<ProjectConfirmPage> {
  String _phoneNum = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.blue),
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
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            '프로젝트 참여 확인',
            style: featureTitle,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                signUpEditTextForm(
                  label: "전화번호",
                  hint: "010-1234-1234",
                  type: TextInputType.phone,
                  onSaved: (newValue) => _phoneNum = newValue,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            height: 56,
            child: ElevatedButton(
                style: featureButton,
                child: Text(
                  '완료',
                  style: buttonText,
                ),
                onPressed: () async {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    var data = jsonDecode(widget.res);
                    Logger logger = Logger();
                    showCustomDialog(context);
                    final url = Uri.parse(
                        'https://foggy-boundless-avenue.glitch.me/project/confirm');
                    try {
                      http.Response response = await http.post(
                        url,
                        headers: <String, String>{
                          'Content-Type': 'application/x-www-form-urlencoded',
                        },
                        body: <String, String>{
                          'docId': widget.docID,
                          'name': data["receiver"],
                          'phoneNum': _phoneNum
                        },
                      );
                      logger.w(response.body);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } catch (e) {
                      logger.w(e);
                    }

                    return null;
                  }
                })));
  }
}
