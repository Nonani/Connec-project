import 'dart:ffi';

import '../models/SignUpBody.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/customEditTextForm.dart';
import '../services/service_class.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // String? _uid;
  // String? _serviceName;
  String? _email;
  String? _password;
  String? _name;
  String? _work;
  String? _career;
  String? _location;
  String? _gender;
  String? _age;
  String? _capability;
  String? _introduction;
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ServiceClass>(context, listen: false);
    return Scaffold(
      body: Consumer<ServiceClass>(
        builder: (context, data, child) {
          return data.loading
              ? Text("회원가입")
              : SafeArea(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SignUpEditTextForm(
                            label: "이메일",
                            hint: "example@connec.co.kr",
                            isSecret: false,
                            onSaved: (newValue) => _email = newValue,
                          ),
                          SignUpEditTextForm(
                            label: "비밀번호",
                            hint: "기호/영문/숫자 포함 8자 이상",
                            isSecret: true,
                            onSaved: (newValue) => _password = newValue,
                          ),
                          SignUpEditTextForm(
                            label: "비밀번호 확인",
                            hint: "비밀번호를 입력해주세요",
                            isSecret: true,
                            onSaved: (newValue) => _password = newValue,
                          ),
                          SignUpEditTextForm(
                            label: "이름",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _name = newValue,
                          ),
                          SignUpEditTextForm(
                            label: "직군/직무",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _work = newValue,
                          ),
                          SignUpEditTextForm(
                            label: "경력",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _career = newValue,
                          ),
                          SignUpEditTextForm(
                            label: "활동지",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _location = newValue,
                          ),
                          SignUpEditTextForm(
                            label: "성별",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _gender = newValue,
                          ),
                          SignUpEditTextForm(
                            label: "나이",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _age = newValue,
                          ),
                          SignUpEditTextForm(
                            label: "능력",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _capability = newValue,
                          ),
                          SignUpEditTextForm(
                            label: "소개",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _introduction = newValue,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(13, 4, 13, 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                    value: checkboxValue1,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue1 = value!;
                                      });
                                    }),
                                Text('(필수) 이용약관, 개인정보 수집 및 이용 동의',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontFamily: 'EchoDream',
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(13, 4, 13, 4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                    value: checkboxValue2,
                                    onChanged: (value) {
                                      setState(() {
                                        checkboxValue2 = value!;
                                      });
                                    }),
                                Text('(필수) 만 14세 이상',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontFamily: 'EchoDream',
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
      bottomNavigationBar: Container(
        height: 56,
        child: ElevatedButton(
          child: Text('회원가입',
            style: TextStyle(
              color: Color(0xfffafafa),
              fontSize: 20,
              fontFamily: 'EchoDream',
              fontWeight: FontWeight.w400
            ),
          ),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              await provider.postData(SignUpBody(
                name: _name,
                age: _age,
                capability: _capability,
                career: _career,
                email: _email,
                gender: _gender,
                introduction: _introduction,
                location: _location,
                password: _password,
                work: _work,
                serviceName: "None",
              ));
              if (provider.isComplete) {
                Navigator.pop(context);
              }
            }
          },
        ),
      )
    );
  }
}
