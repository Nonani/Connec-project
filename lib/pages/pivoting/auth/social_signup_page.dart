import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_checkbox.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/services/LocalService.dart';
import 'package:connec/style/button_style.dart';
import 'package:connec/style/text_style.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../../../components/custom_dropdown_button.dart';
import '../../../components/custom_edit_textform.dart';
import '../../../const/data.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/SignUpBody.dart';
import '../../../services/service_class.dart';
import '../../legacy/login/local_dialog.dart';

class SocialSignUpPage extends StatefulWidget {
  SocialSignUpPage({Key? key, required this.uid, required this.profileImageUrl})
      : super(key: key);
  final String uid;
  final String? profileImageUrl;
  DateTime birthDate = DateTime.now();

  @override
  State<SocialSignUpPage> createState() => _SocialSignUpPageState();
}

class _SocialSignUpPageState extends State<SocialSignUpPage> {
  var uuid = const Uuid();
  String? _name;
  String _work = workList.first;
  String _gender = genderList.first;
  String? _phoneNum;
  bool _checkboxValue1 = false;
  bool _checkboxValue2 = false;
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
          leading: const BackButton(color: Color(0xff5f66f2))),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                inputEditTextForm(
                  label: "이름",
                  hint: "이름(실명)을 입력해주세요",
                  isSecret: false,
                  type: TextInputType.text,
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
                Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("생년월일", style: labelStyle),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "${widget.birthDate.year} - ${widget.birthDate.month} - ${widget.birthDate.day}"),
                            IconButton(
                                onPressed: () async {
                                  final selectedDate = await showDatePicker(
                                    context: context,
                                    initialDate: widget.birthDate,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );
                                  if (selectedDate != null) {
                                    setState(() {
                                      widget.birthDate = selectedDate;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.calendar_month))
                          ],
                        ),
                      ]),
                ),
                inputEditTextForm(
                  label: "전화번호",
                  type: TextInputType.phone,
                  onSaved: (newValue) => _phoneNum = newValue,
                  hint: "전화번호를 입력해주세요",
                ),
                FutureBuilder(
                    future: _future(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return buildLocalContainer(snapshot);
                      } else {
                        return const SafeArea(
                            child: Center(
                          child: CircularProgressIndicator(),
                        ));
                      }
                    }),
                inputCheckBox('(필수) 이용약관, 개인정보 수집 및 이용 동의', _checkboxValue1,
                    (value) {
                  setState(() {
                    _checkboxValue1 = value!;
                  });
                }),
                inputCheckBox('(필수) 만 14세 이상', _checkboxValue2, (value) {
                  setState(() {
                    _checkboxValue2 = value!;
                  });
                }),
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
                localProvider.local.subLocal != null) {
              _formKey.currentState!.save();
              showCustomDialog(context);
              logger.w(widget.profileImageUrl);
              await provider.postSignUpBody(SignUpBody(
                uid: widget.uid.toString(),
                profileImageUrl: widget.profileImageUrl,
                name: _name,
                birth: widget.birthDate.toString(),
                work: _work,
                rate: 0,
                phoneNum: _phoneNum,
                gender: _gender,
                location: localProvider.local.subLocalCode,
              ));
              if (provider.isComplete) {
                Navigator.pop(context);
                // Navigator.pop(context);
              }
            } else if (localProvider.local.subLocal == null) {
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

  Future _future() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final localResult = await db.collection("localData").get();

    return {"localData": localResult.docs};
  }

  Container buildLocalContainer(AsyncSnapshot snapshot) {
    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("지역", style: labelStyle),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                DialogRoute(
                  context: context,
                  builder: (context) => LocalDataScreen(onClose: () {
                    setState(() {});
                  }),
                ));
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
                ? Text('선택', style: checkTextStyle)
                : Text(
                    '${localProvider.local.local} > ${localProvider.local.subLocal}',
                    style: checkTextStyle),
          ),
        ),
      ]),
    );
  }
}
