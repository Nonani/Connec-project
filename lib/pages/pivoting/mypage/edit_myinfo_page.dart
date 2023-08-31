import 'dart:convert';

import 'package:connec/components/custom_dialog.dart';
import 'package:connec/components/custom_edit_textform.dart';
import 'package:connec/style/padding_style.dart';
import 'package:connec/style/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';


import 'package:http/http.dart' as http;

import '../../../components/custom_dropdown_button.dart';
import '../../../const/data.dart';
import '../../../services/LocalService.dart';
import '../../../style/button_style.dart';
import '../../../style/title_style.dart';
import '../../legacy/login/local_dialog.dart';


class EditMyInfoPage extends StatefulWidget {
  final String beforeLocation;
  final String beforeWork;

  const EditMyInfoPage(this.beforeLocation, this.beforeWork, {Key? key}) : super(key: key);


  @override
  State<EditMyInfoPage> createState() => _EditMyInfoPageState();
}

class _EditMyInfoPageState extends State<EditMyInfoPage> {

  String _name = "";
  String _work = "";
  String _gender = "";
  String _phoneNum = "";
  DateTime _birthDate = DateTime.now();
  String _location = "";
  String _localCode = "";

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();

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
      body: FutureBuilder(
        future: _future(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(_name == '') {
              _name = snapshot.data['originalData']['name'];
              _gender = snapshot.data['originalData']['gender'];
              _phoneNum = snapshot.data['originalData']['phone_number'];
              _birthDate = DateTime.parse(snapshot.data['originalData']['age']);
              _work = snapshot.data['originalData']['work'];
              _location = snapshot.data['originalData']['location'];
              _localCode = snapshot.data['originalData']['local_code'];

              nameController.text = _name;
              phoneNumController.text = _phoneNum;
            }
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  inputEditTextForm(
                    label: "이름",
                    hint: _name,
                    controller: nameController,
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
                          Text("생년월일",
                              style: labelStyle),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "${_birthDate.year} - ${_birthDate.month} - ${_birthDate.day}"),
                              IconButton(
                                  onPressed: () async {
                                    final selectedDate = await showDatePicker(
                                      context: context,
                                      initialDate: _birthDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                    );
                                    if (selectedDate != null) {
                                      setState(() {
                                        _birthDate = selectedDate;
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
                    controller: phoneNumController,
                    type: TextInputType.phone,
                    onSaved: (newValue) => _phoneNum = newValue,
                    hint: _phoneNum,
                  ),
                  buildLocalContainer(snapshot),
                ],
              ),
            );
          }
          else{
            return customLoadingDialog();
          }
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 56,
        child: ElevatedButton(
          style: featureButton,
          child: Text("완료", style: buttonText),
          onPressed: () async {
            Logger logger = Logger();
            final localProvider =
            Provider.of<LocalProvider>(context, listen: false);
            if (_formKey.currentState!.validate() && localProvider.local.subLocalCode != null) {
              _formKey.currentState!.save();
              final url =
              Uri.parse('https://foggy-boundless-avenue.glitch.me/mypage/update');
              http.post(
                  url,
                  headers: <String, String>{
                    'Content-Type': 'application/x-www-form-urlencoded',
                  },
                  body: <String, String>{
                    'uid': FirebaseAuth.instance.currentUser!.uid.toString(),
                    'name': _name,
                    'work': _work,
                    'gender': _gender,
                    'birthDate': _birthDate.toString(),
                    'phoneNum': _phoneNum,
                    'location' : localProvider.local.subLocalCode!,
                  },
                ).then((response) {
                  logger.w(response.body);
                   Navigator.pop(context);
                });


            }

          },
        ),
      ),
    );
  }
  Future _future() async {
    Logger logger = Logger();
    Map<String, dynamic> result = {};
    final url =
    Uri.parse('https://foggy-boundless-avenue.glitch.me/mypage/info');
    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'uid': FirebaseAuth.instance.currentUser!.uid.toString(),
        },
      );
      result["originalData"] = JsonDecoder().convert(response.body);
    }catch(e){
      logger.w(e);
    }
    logger.w(result);
    return result;
  }
  Container buildLocalContainer(AsyncSnapshot snapshot) {
    final localProvider = Provider.of<LocalProvider>(context, listen: false);
    localProvider.setSubLocalCode(_localCode);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("지역", style: labelStyle),
        const SizedBox(height:10),
        GestureDetector(
          onTap: () {
            Navigator.push(context, DialogRoute(context: context, builder: (context) => LocalDataScreen( onClose: (){setState((){});}),));
          },
          child: Container(
            width: double.infinity,
            height: 40,
            padding: leftPadding10,
            decoration: BoxDecoration(
                color: Color(0xffeeeeee),
                border: Border(
                    bottom: BorderSide(color: Color(0xff5f66f2), width: 1))),
            alignment: Alignment.centerLeft,
            child: localProvider.local.local == null
                ? Text(
              _location,
              style: inputHintStyle
            )
                : Text(
              '${localProvider.local.local} > ${localProvider.local.subLocal}',
              style: inputHintStyle
            ),
          ),
        ),
      ]),
    );
  }

}
