import 'dart:ffi';

import 'package:logger/logger.dart';
import '../components/custom_dialog.dart';
import '../const/data.dart';
import '../models/SignUpBody.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_edit_textform.dart';
import '../services/service_class.dart';
import 'package:uuid/uuid.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // String? _uid;
  // String? _serviceName;

  static const List<String> genderList = <String>['선택', "남성", "여성"];
  var uuid = Uuid();
  String? _email;
  String? _password;
  String? _name;
  String? _work;
  String _career = careerList.first;
  String? _location;
  String _gender = genderList.first;
  String _age = ageList.first;
  String? _capability;
  String? _introduction;
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  final _formKey = GlobalKey<FormState>();

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
        body: Consumer<ServiceClass>(
          builder: (context, data, child) {
            return SafeArea(
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
                        hint: "직군/직무을 입력해주세요",
                        isSecret: false,
                        onSaved: (newValue) => _work = newValue,
                      ),
                      CustomDropdownButton(
                        label: "경력",
                        itemList: careerList,
                        selectedItem: _career,
                        onChanged: (value) {
                          setState(
                                () {
                              _career = value;
                            },
                          );
                        },
                      ),
                      // CustomDropdownButton(
                      //   label: "활동지",
                      //   itemList: ageList,
                      //   selectedItem: _location,
                      //   onChanged: (value) {
                      //     setState(
                      //           () {
                      //         _career = value;
                      //       },
                      //     );
                      //   },
                      // ),
                      CustomDropdownButton(
                        label: "성별",
                        itemList: genderList,
                        selectedItem: _gender,
                        onChanged: (value) {
                          setState(
                            () {
                              _gender = value;
                            },
                          );
                        },
                      ),
                      CustomDropdownButton(
                        label: "나이",
                        itemList: ageList,
                        selectedItem: _age,
                        onChanged: (value) {
                          setState(
                                () {
                              _age = value;
                            },
                          );
                        },
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
                            Text(
                              '(필수) 이용약관, 개인정보 수집 및 이용 동의',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontFamily: 'EchoDream',
                                  fontWeight: FontWeight.w400),
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
                            Text(
                              '(필수) 만 14세 이상',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontFamily: 'EchoDream',
                                  fontWeight: FontWeight.w400),
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
            child: Text(
              '회원가입',
              style: TextStyle(
                  color: Color(0xfffafafa),
                  fontSize: 20,
                  fontFamily: 'EchoDream',
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                showCustomDialog(context);
                await provider.postSignUpBody(SignUpBody(
                  uuid: uuid.v4(),
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
                  Navigator.pop(context);
                }
              }
            },
          ),
        ));
  }

  Widget CustomDropdownButton(
      {required List<String> itemList,
      required String label,
      required ValueChanged onChanged,
      required String selectedItem}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff5f66f2),
            width: 1.0,
          ),
        ),
      ),
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),

      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${label}",
              style: TextStyle(
                fontFamily: "EchoDream",
                fontWeight: FontWeight.w600,
                fontSize: 17,
              )),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
            ),
            child: DropdownButton<String>(
              value: selectedItem,
              elevation: 16,
              icon: const Visibility(
                  visible: false, child: Icon(Icons.arrow_downward)),
              style: selectedItem == "선택"
                  ? const TextStyle(
                      color: Color(0xffbdbdbd),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    )
                  : const TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontFamily: 'S-CoreDream-4',
                    ),
              underline: Visibility(
                visible: false,
                child: Container(
                ),
              ),
              onChanged: onChanged,
              items:itemList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
