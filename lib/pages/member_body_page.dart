import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/models/MemberBody.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../components/custom_dialog.dart';
import '../components/custom_dropdown_button.dart';
import '../components/custom_edit_textform.dart';
import '../const/data.dart';
import '../services/service_class.dart';

class MemberBodyPage extends StatefulWidget {
  MemberBodyPage({required this.mode, Key? key}) : super(key: key);
  String mode;

  @override
  State<MemberBodyPage> createState() => _MemberBodyPageState();
}

class _MemberBodyPageState extends State<MemberBodyPage> {
  final _formKey = GlobalKey<FormState>();
  String _work = workList.first;
  String _career = careerList.first;
  String? _location;
  String? _locaion_label;
  String _gender = genderList.first;
  String _age = ageList.first;
  String? _introduction;
  int _curWorkTier = 1;
  int _curLocalTier = 1;
  String _curWorkParent = "";
  String _curLocalParent = "";
  String _personality = personalityList.first;
  List<String> _personalityItems = [];
  List<String> _workAreaItems = [];
  List<String> _workAreaCodes = [];
  int _modeIdx = 0;
  List<String> _modeTitleString = ["지인 등록", "지인 수정"];
  List<String> _modeButtonString = ["등록하기", "수정하기"];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ServiceClass>(context, listen: false);
    if (widget.mode != '0') {
      setState(() {
        _modeIdx = 1;
      });
    }
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
                title: Text(_modeTitleString[_modeIdx],
                    style: TextStyle(
                        fontFamily: "EchoDream",
                        fontSize: 20,
                        color: Colors.black)),
                centerTitle: true,
              ),
              body: SafeArea(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                        buildPersonalityContainer(snapshot),
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
                          label: "소개",
                          hint: "소개를 입력해주세요",
                          isSecret: false,
                          onSaved: (newValue) => _introduction = newValue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                height: 56,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        _workAreaCodes.isNotEmpty &&
                        _personalityItems.length >= 2 &&
                        _location != null) {
                      var uuid = Uuid();
                      _formKey.currentState!.save();
                      showCustomDialog(context);
                      await provider.postMemberBody(MemberBody(
                        uid: FirebaseAuth.instance.currentUser!.uid,
                        workArea: _workAreaCodes,
                        location: _location,
                        personality: _personalityItems,
                        introduction: _introduction,
                        gender: _gender,
                        career: _career,
                        age: _age,
                        docId: (widget.mode == '0')
                            ? uuid.v4()
                            : widget.mode.toString(),
                      ));
                      if (provider.isComplete) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    _modeButtonString[_modeIdx],
                    style: TextStyle(
                      color: Color(0xfffafafa),
                      fontSize: 20,
                    ),
                  ),
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
            Text("전문분야",
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
            if (_workAreaItems.length < 5) showWorkListDialog(snapshot, "전문분야");
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
          itemCount: _workAreaItems.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    _workAreaItems[index],
                    overflow: TextOverflow.ellipsis,
                  )),
                  IconButton(
                      onPressed: () {
                        _workAreaItems.removeAt(index);
                        _workAreaCodes.removeAt(index);
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
      if (element.data()["tier"] == _curWorkTier &&
          element.data()["parent"] == _curWorkParent) {
        dialogList.add(element.data());
        dialogWidgetList.add(SimpleDialogOption(
          child: Text(element.data()["title"]),
          onPressed: () {
            switch (_curWorkTier) {
              case 1:
                title = element.data()["title"];
                break;
              case 2:
                title = title + ' > ${element.data()["title"]}';
                _workAreaItems.remove(title);
                _workAreaCodes.remove(element.data()["code"]);

                _workAreaItems.add(title);
                _workAreaCodes.add(element.data()["code"]);
                Navigator.pop(context);
                setState() {
                  _curWorkTier = 1;
                  _curWorkParent = "";
                }
                return;
            }
            _curWorkTier += 1;
            _curWorkParent = element.data()["code"];
            showWorkListDialog(snapshot, title);
          },
        ));
      }
    });
    switch (_curWorkTier) {
      case 1:
        SimpleDialog dialog =
            SimpleDialog(title: Text('${title}'), children: dialogWidgetList);
        showDialog(
            context: context,
            builder: (context) {
              return dialog;
            }).then((value) => setState(() {
              _curWorkTier = 1;
              _curWorkParent = "";
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
            child: _location == null
                ? Text(
                    '선택',
                    style: TextStyle(
                      color: Color(0xffbdbdbd),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  )
                : Text(
                    '${_locaion_label}',
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
      if (element.data()["tier"] == _curLocalTier &&
          element.data()["parent"] == _curLocalParent) {
        dialogList.add(element.data());
        dialogWidgetList.add(SimpleDialogOption(
          child: Text(element.data()["title"]),
          onPressed: () {
            switch (_curLocalTier) {
              case 1:
                title = element.data()["title"];
                break;
              case 2:
                title = title + ' > ${element.data()["title"]}';
                _location = element.data()["code"];
                _locaion_label = title;
                Navigator.pop(context);
                return;
            }
            _curLocalTier += 1;
            _curLocalParent = element.data()["code"];
            showLocalListDialog(snapshot, title);
          },
        ));
      }
    });
    switch (_curLocalTier) {
      case 1:
        SimpleDialog dialog =
            SimpleDialog(title: Text('${title}'), children: dialogWidgetList);
        showDialog(
            context: context,
            builder: (context) {
              return dialog;
            }).then((value) => setState(() {
              _curLocalTier = 1;
              _curLocalParent = "";
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

  Container buildPersonalityContainer(AsyncSnapshot snapshot) {
    return Container(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomDropdownButton(
            itemList: personalityList,
            label: "성격",
            onChanged: (value) {
              if (value != "선택" && _personalityItems.length < 5) {
                _personalityItems.remove(value);
                _personalityItems.add(value);
                setState(() {});
              }
            },
            selectedItem: _personality),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: _personalityItems.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      _personalityItems[index],
                      overflow: TextOverflow.ellipsis,
                    )),
                    IconButton(
                        onPressed: () {
                          _personalityItems.removeAt(index);
                          setState(() {});
                        },
                        icon: Icon(Icons.cancel_outlined))
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
