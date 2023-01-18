import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../const/data.dart';
import '../models/SignUpBody.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/custom_dropdown_button.dart';
import '../components/custom_edit_textform.dart';
import '../services/service_class.dart';

class SocialSignUpPage extends StatefulWidget {
  const SocialSignUpPage({Key? key, this.uid, this.serviceName})
      : super(key: key);
  final uid;
  final serviceName;

  @override
  State<SocialSignUpPage> createState() => _SocialSignUpPageState();
}

class _SocialSignUpPageState extends State<SocialSignUpPage> {
  var uuid = Uuid();
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
  int curWorkTier = 1;
  String curWorkParent = "";
  final _formKey = GlobalKey<FormState>();
  List<String> workItems = [];
  List<String> workCodes = [];

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
        }else{
          return Scaffold(
            appBar: AppBar(
                shape:
                Border(bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
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
                      buildWorkContainer(snapshot),
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
                      SignUpEditTextForm(
                        label: "활동지",
                        hint: "활동지를 입력해주세요",
                        isSecret: false,
                        onSaved: (newValue) => _location = newValue,
                      ),
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
            ),
            bottomNavigationBar: Container(
              height: 56,
              child: ElevatedButton(
                child: Text("회원가입"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    showCustomDialog(context);
                    await provider.postSignUpBody(SignUpBody(
                      uid: widget.uid.toString(),
                      uuid: uuid.v4(),
                      name: _name,
                      age: _age,
                      capability: _capability,
                      career: _career,
                      gender: _gender,
                      introduction: _introduction,
                      location: _location,
                      work: workCodes,
                      serviceName: widget.serviceName.toString(),
                    ));
                    if(provider.isComplete){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }
  Container buildWorkContainer(AsyncSnapshot snapshot) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text("직군/직무",
                style: TextStyle(
                  fontFamily: "EchoDream",
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                )),
            SizedBox(
              width: 15,
            ),
            Text(
              '최대 5개까지 등록 가능',
              style: TextStyle(
                  color: Color(0xffbdbdbd),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            if (workItems.length < 5) showWorkListDialog(snapshot, "직군/직무");
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
            child: Text(
              '선택',
              style: TextStyle(
                color: Color(0xffbdbdbd),
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        ListView.separated(
          shrinkWrap: true,
          itemCount: workItems.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(workItems[index], overflow: TextOverflow.ellipsis,)),
                  IconButton(
                      onPressed: () {
                        workItems.removeAt(index);
                        workCodes.removeAt(index);
                        setState(() {});
                      },
                      icon: Icon(Icons.cancel_outlined))
                ],
              ),
            );
          },
        ),
      ]),
    );
  }

  Future _future() async {
    Logger logger = Logger();
    FirebaseFirestore db = FirebaseFirestore.instance;
    final result = await db.collection("workData").get();
    // print(result.size);
    //
    // result.docs.forEach((element) {
    //   print(element.data);
    // });

    return result.docs;
  }

  void showWorkListDialog(AsyncSnapshot snapshot, String title) {
    List dialogList = [];
    List<Widget> dialogWidgetList = [];

    snapshot.data.forEach((element) {
      if (element.data()["tier"] == curWorkTier &&
          element.data()["parent"] == curWorkParent) {
        dialogList.add(element.data());
        dialogWidgetList.add(SimpleDialogOption(
          child: Text(element.data()["title"]),
          onPressed: () {
            switch (curWorkTier) {
              case 1:
                title = element.data()["title"];
                break;
              case 2:
                title = title + ' > ${element.data()["title"]}';
                break;
              case 3:
                title = title + ' > ${element.data()["title"]}';
                workItems.remove(title);
                workCodes.remove(element.data()["code"]);

                workItems.add(title);
                workCodes.add(element.data()["code"]);
                Navigator.pop(context);
                setState() {
                  curWorkTier = 1;
                  curWorkParent = "";
                }
                return;
            }
            curWorkTier += 1;
            curWorkParent = element.data()["code"];
            showWorkListDialog(snapshot, title);
          },
        ));
      }
    });
    switch (curWorkTier) {
      case 1:
        SimpleDialog dialog =
        SimpleDialog(title: Text('${title}'), children: dialogWidgetList);
        showDialog(
            context: context,
            builder: (context) {
              return dialog;
            }).then((value) => setState(() {
          curWorkTier = 1;
          curWorkParent = "";
        }));
        break;
      case 2:
        SimpleDialog dialog =
        SimpleDialog(title: Text('${title}'), children: dialogWidgetList);
        showDialog(
            context: context,
            builder: (context) {
              return dialog;
            }).then((value) => Navigator.pop(context));
        break;
      case 3:
        SimpleDialog dialog =
        SimpleDialog(title: Text('${title}'), children: dialogWidgetList);
        showDialog(
            context: context,
            builder: (context) {
              return dialog;
            }).then((value) {
          Navigator.pop(context);
          setState(() {});
        });
        break;
    }
  }
}
