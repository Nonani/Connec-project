import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/models/MemberBody.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_dialog.dart';
import '../components/custom_edit_textform.dart';
import '../services/service_class.dart';

class MemberBodyPage extends StatefulWidget {
  const MemberBodyPage({Key? key}) : super(key: key);

  @override
  State<MemberBodyPage> createState() => _MemberBodyPageState();
}

class _MemberBodyPageState extends State<MemberBodyPage> {
  final _formKey = GlobalKey<FormState>();
  String? _work;
  String? _career;
  String? _location;
  String? _gender;
  String? _age;
  String? _capability;
  String? _introduction;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ServiceClass>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          shape:
              Border(bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
          backgroundColor: Color(0xfffafafa),
          elevation: 0,
          leading: BackButton(color: Color(0xff5f66f2)),
          title: Text("회원가입",
              style: TextStyle(
                  fontFamily: "EchoDream", fontSize: 20, color: Colors.black)),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SignUpEditTextForm(
                    label: "직군/직무",
                    hint: "직군/직무을 입력해주세요",
                    isSecret: false,
                    onSaved: (newValue) => _work = newValue,
                  ),
                  SignUpEditTextForm(
                    label: "경력",
                    hint: "경력을 입력해주세요",
                    isSecret: false,
                    onSaved: (newValue) => _career = newValue,
                  ),
                  SignUpEditTextForm(
                    label: "활동지",
                    hint: "활동지를 입력해주세요",
                    isSecret: false,
                    onSaved: (newValue) => _location = newValue,
                  ),
                  SignUpEditTextForm(
                    label: "성별",
                    hint: "성별을 입력해주세요",
                    isSecret: false,
                    onSaved: (newValue) => _gender = newValue,
                  ),
                  SignUpEditTextForm(
                    label: "나이",
                    hint: "나이를 입력해주세요",
                    isSecret: false,
                    onSaved: (newValue) => _age = newValue,
                  ),
                  SignUpEditTextForm(
                    label: "능력",
                    hint: "능력을 입력해주세요",
                    isSecret: false,
                    onSaved: (newValue) => _capability = newValue,
                  ),
                  SignUpEditTextForm(
                    label: "소개",
                    hint: "소개를 입력해주세요",
                    isSecret: false,
                    onSaved: (newValue) => _introduction = newValue,
                  ),
                ],
              ),

            ),
          ),
        ),
        bottomNavigationBar:Container(
          height: 56,
          child: ElevatedButton(
            onPressed: () async{
              if (_formKey.currentState!.validate()){
                _formKey.currentState!.save();
                showCustomDialog(context);
                await provider.postMemberBody(MemberBody(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  work: _work,
                  location: _location,
                  introduction: _introduction,
                  gender: _gender,
                  career: _career,
                  capability: _capability,
                  age: _age,
                ));
                if(provider.isComplete){
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              }

            }, child: Text('등록하기',
            style: TextStyle(
              color: Color(0xfffafafa),
              fontSize: 20,
            ),
          ),
          ),
        )
    );
  }
}
