import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../components/custom_dialog.dart';
import '../components/custom_dropdown_button.dart';
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
  final db = FirebaseFirestore.instance;
  var uuid = Uuid();
  String? _email;
  String? _password;
  String? _name;
  String _career = careerList.first;
  String? _locaion_label;
  String? _location;
  String _gender = genderList.first;
  String _age = ageList.first;
  String? _capability;
  String? _introduction;
  int curWorkTier = 1;
  int curLocalTier = 1;
  String curWorkParent = "";
  String curLocalParent = "";
  List<String> workItems = [];
  List<String> workCodes = [];
  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  final _formKey = GlobalKey<FormState>();

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
                leading: BackButton(color: Color(0xff5f66f2)),
                title: Text("회원가입",
                    style: TextStyle(
                        fontFamily: "EchoDream",
                        fontSize: 20,
                        color: Colors.black)),
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
                            buildLocalContainer(snapshot),
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
                        work: workCodes,
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
                  Expanded(
                      child: Text(
                        workItems[index],
                        overflow: TextOverflow.ellipsis,
                      )),
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
  void showWorkListDialog(AsyncSnapshot snapshot, String title) {
    List dialogList = [];
    List<Widget> dialogWidgetList = [];

    snapshot.data["workData"].forEach((element) {
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

  Container buildLocalContainer(AsyncSnapshot snapshot) {
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
            showLocalListDialog(snapshot, "지역");
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
            child: _location==null?Text(
              '선택',
              style: TextStyle(
                color: Color(0xffbdbdbd),
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ):Text('${_locaion_label}',
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
  void showLocalListDialog(AsyncSnapshot snapshot, String title) {
    List dialogList = [];
    List<Widget> dialogWidgetList = [];

    snapshot.data["localData"].forEach((element) {
      if (element.data()["tier"] == curLocalTier &&
          element.data()["parent"] == curLocalParent) {
        dialogList.add(element.data());
        dialogWidgetList.add(SimpleDialogOption(
          child: Text(element.data()["title"]),
          onPressed: () {
            switch (curLocalTier) {
              case 1:
                title = element.data()["title"];
                break;
              case 2:
                title = title + ' > ${element.data()["title"]}';
                _location = element.data()["code"];
                _locaion_label = title;
                Navigator.pop(context);
                setState() {
                  curWorkTier = 1;
                  curWorkParent = "";
                }
                return;
            }
            curLocalTier += 1;
            curLocalParent = element.data()["code"];
            showLocalListDialog(snapshot, title);
          },
        ));
      }
    });
    switch (curLocalTier) {
      case 1:
        SimpleDialog dialog =
            SimpleDialog(title: Text('${title}'), children: dialogWidgetList);
        showDialog(
            context: context,
            builder: (context) {
              return dialog;
            }).then((value) => setState(() {
              curLocalTier = 1;
              curLocalParent = "";
            }));
        break;
      case 2:
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
