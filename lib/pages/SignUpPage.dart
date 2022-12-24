import 'package:connec/components/CustomEditTextForm.dart';
import 'package:connec/models/SignUpBody.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                          CustomEditTextForm(
                            label: "이메일",
                            hint: "example@connec.co.kr",
                            isSecret: false,
                            onSaved: (newValue) => _email = newValue,
                          ),
                          CustomEditTextForm(
                            label: "비밀번호",
                            hint: "기호/영문/숫자 포함 8자 이상",
                            isSecret: true,
                            onSaved: (newValue) => _password = newValue,
                          ),
                          CustomEditTextForm(
                            label: "비밀번호 확인",
                            hint: "비밀번호를 입력해주세요",
                            isSecret: true,
                            onSaved: (newValue) => _password = newValue,
                          ),
                          CustomEditTextForm(
                            label: "이름",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _name = newValue,
                          ),
                          CustomEditTextForm(
                            label: "직군/직무",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _work = newValue,
                          ),
                          CustomEditTextForm(
                            label: "경력",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _career = newValue,
                          ),
                          CustomEditTextForm(
                            label: "활동지",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _location = newValue,
                          ),
                          CustomEditTextForm(
                            label: "성별",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _gender = newValue,
                          ),
                          CustomEditTextForm(
                            label: "나이",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _age = newValue,
                          ),
                          CustomEditTextForm(
                            label: "능력",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _capability = newValue,
                          ),
                          CustomEditTextForm(
                            label: "소개",
                            hint: "이름(실명)을 입력해주세요",
                            isSecret: false,
                            onSaved: (newValue) => _introduction = newValue,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        child: Text("회원가입"),
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
            if(provider.isComplete){
              Navigator.pop(context);
            }
          }
        },
      ),
    );
  }
}
