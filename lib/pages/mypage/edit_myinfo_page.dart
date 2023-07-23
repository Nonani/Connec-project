import 'dart:convert';

import 'package:connec/components/custom_edit_textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../style/buttonstyle.dart';
import '../../style/titlestyle.dart';
import 'package:http/http.dart' as http;
class EditMyInfoPage extends StatefulWidget {
  final before_location;
  final before_work;

  const EditMyInfoPage(this.before_location, this.before_work, {Key? key}) : super(key: key);


  @override
  State<EditMyInfoPage> createState() => _EditMyInfoPageState();
}

class _EditMyInfoPageState extends State<EditMyInfoPage> {
  String _location= '';
  String _work = '';
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
          '마이페이지',
          style: featureTitle,
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            SignUpEditTextForm(label: "직업", hint: widget.before_work, onSaved: (newValue) => _work = newValue,),
            SignUpEditTextForm(label: "활동지역", hint: widget.before_location, onSaved: (newValue) => _location = newValue,)
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        child: ElevatedButton(
          style: featureButton,
          child: Text("완료", style: buttonText),
          onPressed: () async {
            Logger logger = Logger();

            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final url =
              Uri.parse('https://foggy-boundless-avenue.glitch.me/mypage/update');
              try {
                http.Response response = await http.post(
                  url,
                  headers: <String, String>{
                    'Content-Type': 'application/x-www-form-urlencoded',
                  },
                  body: <String, String>{
                    'uid': FirebaseAuth.instance.currentUser!.uid.toString(),
                    'work': _work,
                    'location' : _location
                  },
                );
                logger.w(response.body);
                return jsonDecode(response.body);
              } catch (e) {
                logger.w(e);
              }

            }

          },
        ),
      ),
    );
  }
}
