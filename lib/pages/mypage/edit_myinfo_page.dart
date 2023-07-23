import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/components/custom_edit_textform.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../components/custom_dropdown_button.dart';
import '../../const/data.dart';
import '../../services/LocalService.dart';
import '../../style/buttonstyle.dart';
import '../../style/titlestyle.dart';
import 'package:http/http.dart' as http;

import '../login/local_dialog.dart';
class EditMyInfoPage extends StatefulWidget {
  final before_location;
  final before_work;

  const EditMyInfoPage(this.before_location, this.before_work, {Key? key}) : super(key: key);


  @override
  State<EditMyInfoPage> createState() => _EditMyInfoPageState();
}

class _EditMyInfoPageState extends State<EditMyInfoPage> {
  String _location= '';
  String _work = workList.first;
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
            return Form(
              key: _formKey,
              child: Column(
                children: [
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

                  buildLocalContainer(snapshot),
                ],
              ),
            );
          }
          else{
            return CustomLoadingDialog();
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 56,
        child: ElevatedButton(
          style: featureButton,
          child: Text("완료", style: buttonText),
          onPressed: () async {
            Logger logger = Logger();
            final localProvider =
            Provider.of<LocalProvider>(context, listen: false);
            if (_formKey.currentState!.validate() && localProvider.local.sub_local != null) {
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
                    'location' : localProvider.local.sub_local_code!,
                  },
                );
                logger.w(response.body);
                Navigator.pop(context);
              } catch (e) {
                logger.w(e);
              }
            }

          },
        ),
      ),
    );
  }
  Future _future() async {
    Logger logger = Logger();
    FirebaseFirestore db = FirebaseFirestore.instance;
    // final workResult = await db.collection("workData").get();
    final localResult = await db.collection("localData").get();
    // print(result.size);
    //
    // result.docs.forEach((element) {
    //   print(element.data);
    // });

    // return {"workData": workResult.docs, "localData": localResult.docs};
    return {"localData": localResult.docs};

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
