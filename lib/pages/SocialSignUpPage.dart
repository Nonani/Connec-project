import '../models/SignUpBody.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/customEditTextForm.dart';
import '../services/service_class.dart';

class SocialSignUpPage extends StatefulWidget {
  const SocialSignUpPage({Key? key, this.uid, this.serviceName}) : super(key: key);
  final uid;
  final serviceName;
  @override
  State<SocialSignUpPage> createState() => _SocialSignUpPageState();
}

class _SocialSignUpPageState extends State<SocialSignUpPage> {

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
              ? Container(
                  child: Text("회원가입"),
                )
              : SafeArea(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SignUpTextFormField(
                            label: "이름",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _name = newValue,
                          ),
                          SignUpTextFormField(
                            label: "직군/직무",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _work = newValue,
                          ),
                          SignUpTextFormField(
                            label: "경력",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _career = newValue,
                          ),
                          SignUpTextFormField(
                            label: "활동지",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _location = newValue,
                          ),
                          SignUpTextFormField(
                            label: "성별",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _gender = newValue,
                          ),
                          SignUpTextFormField(
                            label: "나이",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _age = newValue,
                          ),
                          SignUpTextFormField(
                            label: "능력",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _capability = newValue,
                          ),
                          SignUpTextFormField(
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
          child: Text("회원가입"),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              await provider.postData(SignUpBody(
                uid: widget.uid.toString(),
                name: _name,
                age: _age,
                capability: _capability,
                career: _career,
                gender: _gender,
                introduction: _introduction,
                location: _location,
                work: _work,
                serviceName: "kakao",
              ));
              // if(provider.isComplete){
              //   Navigator.pop(context);
              // }
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }
}
