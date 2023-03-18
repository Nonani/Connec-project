import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dialog.dart';
import 'package:connec/style/buttonstyle.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

import '../../const/data.dart';
import '../../models/SignUpBody.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/custom_dropdown_button.dart';
import '../../components/custom_edit_textform.dart';
import '../../services/Job.dart';
import '../../services/service_class.dart';
import 'job_dialog.dart';

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
  String? _location;
  String? _locaion_label;
  String _gender = genderList.first;
  String _age = ageList.first;
  String? _introduction;
  bool _checkboxValue1 = false;
  bool _checkboxValue2 = false;
  int _curLocalTier = 1;
  String _curLocalParent = "";
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
                      buildWorkContainer(snapshot),
                      buildPersonalityContainer(snapshot),
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
                  final jobProvider =
                      Provider.of<JobProvider>(context, listen: false);
                  if (_formKey.currentState!.validate() &&
                      _checkboxValue1 &&
                      _checkboxValue2 &&
                      // _workAreaCodes.isNotEmpty &&
                      _personalityItems.length >= 2 &&
                      _location != null) {
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
                      personality: _personalityItems,
                      career: jobProvider.getCareerList(),
                      gender: _gender,
                      introduction: _introduction,
                      location: _location,
                      workArea: jobProvider.getSubType(),
                      serviceName: widget.serviceName.toString(),
                    ));
                    if (provider.isComplete) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  } else if (jobProvider.jobList.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (context) => workValidationDialog());
                  } else if (_location == null) {
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

  Container buildWorkContainer(AsyncSnapshot snapshot) {
    final jobProvider = Provider.of<JobProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                  '최소 1개, 최대 5개까지 등록 가능',
                  style: TextStyle(
                      color: Color(0xffbdbdbd),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            (jobProvider.jobList.length < 5)
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          DialogRoute(
                            context: context,
                            builder: (context) => JobTypePage( onClose: (){setState((){});},),
                          )).then((value) => setState(
                            () {},
                          ));

                      // showWorkListDialog(snapshot, "전문분야");
                    },
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.blue,
                    ))
                : IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.grey,
                    ))
          ],
        ),
        SizedBox(
          height: 5,
        ),
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: jobProvider.jobList.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (BuildContext context, int index) {
            Logger logger = Logger();
            logger.w(jobProvider.jobList[index].subType);
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffeeeeee),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          jobProvider.jobList[index].subType!.name,
                          overflow: TextOverflow.ellipsis,
                        )),
                        IconButton(
                            onPressed: () {
                              jobProvider.jobList.removeAt(index);
                              setState(() {});
                            },
                            icon: Icon(Icons.cancel_outlined))
                      ],
                    ),
                    Text(
                      '경력  ${jobProvider.jobList[index].career!.year}년 ${jobProvider.jobList[index].career!.month}개월',
                      style: TextStyle(
                        color: Color(0xff999999),
                        fontSize: 12,
                        fontFamily: 'S-CoreDream-5',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ]),
    );
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
            validator: (value) {
              if (_personalityItems.length < 3) {
                return "3개 이상 선택해주세요";
              } else
                return null;
            },
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
            primary: false,
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
