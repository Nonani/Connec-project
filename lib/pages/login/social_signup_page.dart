import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/services/LocalService.dart';
import 'package:connec/style/buttonstyle.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../../const/data.dart';
import '../../models/SignUpBody.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/custom_dropdown_button.dart';
import '../../components/custom_edit_textform.dart';
import '../../models/JobModel.dart';
import '../../services/service_class.dart';
import 'job_dialog.dart';
import 'local_dialog.dart';

class SocialSignUpPage extends StatefulWidget {
  const SocialSignUpPage(
      {Key? key, this.uid, this.serviceName, this.profileImageUrl})
      : super(key: key);
  final uid;
  final serviceName;
  final profileImageUrl;

  @override
  State<SocialSignUpPage> createState() => _SocialSignUpPageState();
}

class _SocialSignUpPageState extends State<SocialSignUpPage> {
  var uuid = Uuid();
  String? _name;
  String _work = workList.first;
  String _gender = genderList.first;
  String _age = ageList.first;
  String? _phoneNum;
  String? _introduction;
  bool _checkboxValue1 = false;
  bool _checkboxValue2 = false;
  String _personality = personalityList.first;
  List<String> _personalityItems = [];
  final _formKey = GlobalKey<FormState>();
  bool _needUpdate = false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ServiceClass>(context, listen: false);
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
                shape: Border(
                    bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
                backgroundColor: Color(0xfffafafa),
                elevation: 0,
                leading: BackButton(color: Color(0xff5f66f2))),
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SignUpEditTextForm(
                        label: "이름",
                        hint: "이름(실명)을 입력해주세요",
                        isSecret: false,
                        onSaved: (newValue) => _name = newValue,
                      ),
                      CustomDropdownButton(
                          itemList: workList,
                          label: "직업",
                          onChanged: (value) {
                            setState(
                              () {
                                _work = value;
                              },
                            );
                          },
                          selectedItem: _work),

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
                        label: "전화번호",
                        onSaved: (newValue) => _phoneNum = newValue,
                        hint: "전화번호를 입력해주세요",

                      ),
                      buildLocalContainer(snapshot),
                      // SignUpEditTextForm(
                      //   label: "소개",
                      //   hint: "소개를 입력해주세요",
                      //   isSecret: false,
                      //   onSaved: (newValue) => _introduction = newValue,
                      // ),
                      Container(
                        margin: EdgeInsets.fromLTRB(13, 4, 13, 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                value: _checkboxValue1,
                                onChanged: (value) {
                                  setState(() {
                                    _checkboxValue1 = value!;
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
                                value: _checkboxValue2,
                                onChanged: (value) {
                                  setState(() {
                                    _checkboxValue2 = value!;
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
            ),
            bottomNavigationBar: Container(
              height: 56,
              child: ElevatedButton(
                style: featureButton,
                child: Text("회원가입", style: buttonText),
                onPressed: () async {
                  Logger logger = Logger();
                  final localProvider =
                  Provider.of<LocalProvider>(context, listen: false);
                  if (_formKey.currentState!.validate() &&
                      _checkboxValue1 &&
                      _checkboxValue2 &&
                      localProvider.local.sub_local != null) {
                    _formKey.currentState!.save();
                    showCustomDialog(context);
                    logger.w(widget.profileImageUrl);
                    await provider.postSignUpBody(SignUpBody(
                      uid: widget.uid.toString(),
                      profile_image_url: widget.profileImageUrl,
                      uuid: uuid.v4(),
                      name: _name,
                      age: _age,
                      work: _work,
                      rate: 0,
                      phoneNum: _phoneNum,
                      gender: _gender,
                      location: localProvider.local.sub_local_code,
                      serviceName: widget.serviceName.toString(),
                    ));
                    if (provider.isComplete) {
                      Navigator.pop(context);
                      // Navigator.pop(context);
                    }
                  } else if (localProvider.local.sub_local == null) {
                    showDialog(
                        context: context,
                        builder: (context) => areaValidationDialog());
                  } else {
                    print(_formKey.currentState!.validate());
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }

  Future _future() async {
    Logger logger = Logger();
    FirebaseFirestore db = FirebaseFirestore.instance;
    final workResult = await db.collection("workData").get();
    final localResult = await db.collection("localData").get();
    // print(result.size);
    //
    // result.docs.forEach((element) {
    //   print(element.data);
    // });

    return {"workData": workResult.docs, "localData": localResult.docs};
  }


  Container buildLocalContainer(AsyncSnapshot snapshot) {
    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("지역",
            style: TextStyle(
              fontFamily: "EchoDream",
              fontWeight: FontWeight.w600,
              fontSize: 17,
            )),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context, DialogRoute(context: context, builder: (context) => LocalDataScreen( onClose: (){setState((){});}),));
          },
          child: Container(
            width: double.infinity,
            height: 40,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
                color: Color(0xffeeeeee),
                border: Border(
                    bottom: BorderSide(color: Color(0xff5f66f2), width: 1))),
            alignment: Alignment.centerLeft,
            child: localProvider.local.local == null
                ? Text(
                    '선택',
                    style: TextStyle(
                      color: Color(0xffbdbdbd),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  )
                : Text(
                    '${localProvider.local.local} > ${localProvider.local.sub_local}',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 16,
                      fontFamily: 'S-CoreDream-4',
                    ),
                  ),
          ),
        ),
      ]),
    );
  }

}
