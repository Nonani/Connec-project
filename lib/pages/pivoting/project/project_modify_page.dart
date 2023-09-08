import 'dart:convert';

import 'package:connec/components/custom_edit_textform.dart';
import 'package:connec/style/icon_style.dart';
import 'package:connec/style/text_style.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../components/custom_dialog.dart';
import '../../../style/button_style.dart';
import '../../../style/title_style.dart';

import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

class ProjectModifyPage extends StatefulWidget {
  const ProjectModifyPage(this.projectID, {Key? key}) : super(key: key);
  final String projectID;

  @override
  State<ProjectModifyPage> createState() => _ProjectModifyPageState();
}

class _ProjectModifyPageState extends State<ProjectModifyPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController personController = TextEditingController();
  String _projectName = '';
  String _introduction = '';
  String _content = '';
  String _role = '';
  String _accomplishment = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  final List<dynamic> _personItems = [];
  final List<dynamic> _keywordItems = [];
  final List<PlatformFile> _selectedFiles = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();
  final TextEditingController _contextController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _accomplishmentController =
      TextEditingController();
  final TextEditingController _keywordController = TextEditingController();
  FilePickerResult? result;

  @override
  void dispose() {
    _nameController.dispose();
    _introductionController.dispose();
    _contextController.dispose();
    _roleController.dispose();
    _accomplishmentController.dispose();
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            '프로젝트 수정',
            style: featureTitle,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: FutureBuilder(
            future: _future(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                if (_nameController.text.isEmpty) {
                  _nameController.text = snapshot.data['name'];
                  _introductionController.text = snapshot.data['introduction'];
                  _contextController.text = snapshot.data['context'];
                  _roleController.text = snapshot.data['role'];
                  _accomplishmentController.text =
                      snapshot.data['accomplishment'];
                  _personItems.addAll(snapshot.data['participants']
                      .map((participant) => participant['name'])
                      .toList());
                  _startDate = DateTime.parse(snapshot.data['period'][0]);
                  _endDate = DateTime.parse(snapshot.data['period'][1]);

                  if (snapshot.data['keywords'].runtimeType == "".runtimeType) {
                    _keywordItems.add(snapshot.data['keywords']);
                  } else {
                    _keywordItems.addAll(snapshot.data['keywords']);
                  }
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inputEditTextForm(
                        label: "프로젝트 이름",
                        hint: "프로젝트 이름을 작성해주세요",
                        type: TextInputType.text,
                        controller: _nameController,
                        onSaved: (newValue) => _projectName = newValue),
                    inputEditTextForm(
                        label: "한줄 소개",
                        hint: "프로젝트를 한 줄로 요약해주세요",
                        type: TextInputType.text,
                        controller: _introductionController,
                        onSaved: (newValue) => _introduction = newValue),
                    inputEditTextForm(
                        label: "내용",
                        lineNum: 10,
                        type: TextInputType.text,
                        controller: _contextController,
                        hint: "프로젝트의 내용에 대해 500자 내로 설명해주세요",
                        onSaved: (newValue) => _content = newValue),
                    SingleChildScrollView(
                        child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton.extended(
                            backgroundColor: Color(0xff5f66f2),
                            onPressed: _pickFile,
                            label: Text('Choose Files'),
                          ),
                          Column(
                            children: _selectedFiles
                                .map((file) => Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            file.name,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                          IconButton(
                                            icon: cancelIcon,
                                            onPressed: () {
                                              _removeFile(file);
                                            },
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
                      ),
                    )),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("키워드 목록\t", style: labelStyle),
                                        Text(" ※ 최대 5개",
                                            style: constraintStyle)
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          String name = keywordController.text;
                                          if (name.isNotEmpty &&
                                              !_keywordItems.contains(name) &&
                                              _keywordItems.length < 5) {
                                            _keywordItems.add(name);
                                            setState(() {
                                              keywordController.clear();
                                            });
                                          }
                                        },
                                        icon:addIcon
                                    )
                                  ]),
                              TextFormField(
                                controller: keywordController,
                                decoration: InputDecoration(
                                    hintText: "키워드를 작성해주세요",
                                    hintStyle: inputHintStyle,
                                    filled: true,
                                    fillColor: Color(0xffeeeeee),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Color(0xff5f66f2)
                                        )
                                    )
                                ),
                              ),
                            ])),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                      child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _keywordItems.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                      "#${_keywordItems[index]}",
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      _keywordItems.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: cancelIcon)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                      child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _keywordItems.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                  _keywordItems[index],
                                  overflow: TextOverflow.ellipsis,
                                )),
                                IconButton(
                                    onPressed: () {
                                      _keywordItems.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: cancelIcon)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    inputEditTextForm(
                        label: "본인의 역할",
                        hint: "본인의 역할에 대해 500자 내로 설명해주세요",
                        lineNum: 10,
                        type: TextInputType.text,
                        controller: _roleController,
                        onSaved: (newValue) => _role = newValue),
                    inputEditTextForm(
                        label: "본인의 성과",
                        hint: "본인의 성과에 대해 500자 내로 설명해주세요",
                        lineNum: 10,
                        type: TextInputType.text,
                        controller: _accomplishmentController,
                        onSaved: (newValue) => _accomplishment = newValue),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("진행 기간", style: labelStyle),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "시작: ${_startDate.year} - ${_startDate.month} - ${_startDate.day}"),
                                IconButton(
                                    onPressed: () async {
                                      final selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: _startDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),
                                      );
                                      if (selectedDate != null) {
                                        setState(() {
                                          _startDate = selectedDate;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.calendar_month))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "종료: ${_endDate.year} - ${_endDate.month} - ${_endDate.day}"),
                                IconButton(
                                    onPressed: () async {
                                      final selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: _endDate,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime.now(),
                                      );
                                      if (selectedDate != null) {
                                        setState(() {
                                          _endDate = selectedDate;
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.calendar_month))
                              ],
                            ),
                          ]),
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("참여자 명단\t", style: labelStyle),
                                        Text(" ※ 최대 5명", style: constraintStyle)
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        var name = personController.text;
                                        if (name.isNotEmpty &&
                                            !_personItems.contains(name) &&
                                            _personItems.length < 5) {
                                          _personItems.add(name);
                                          setState(() {});
                                        }
                                      },
                                      icon: addIcon,
                                    )
                                  ]),
                              SizedBox(height: 10),
                              TextFormField(
                                controller: personController,
                                decoration: InputDecoration(
                                    hintText: "참여자의 이름을 작성해주세요",
                                    hintStyle: inputHintStyle,
                                    filled: true,
                                    fillColor: Color(0xffeeeeee),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Color(0xff5f66f2)))),
                              ),
                            ])),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                      child: ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _personItems.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Text(
                                  _personItems[index],
                                  overflow: TextOverflow.ellipsis,
                                )),
                                IconButton(
                                    onPressed: () {
                                      _personItems.removeAt(index);
                                      setState(() {});
                                    },
                                    icon: cancelIcon)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          )),
        ),
        bottomNavigationBar: SizedBox(
            height: 56,
            child: ElevatedButton(
                style: featureButton,
                child: Text(
                  '완료',
                  style: buttonText,
                ),
                onPressed: () {
                  Logger logger = Logger();
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    showCustomDialog(context);
                    Map<String, dynamic> jsonData = {
                      'docId': widget.projectID,
                      "uid": FirebaseAuth.instance.currentUser!.uid,
                      "name": _projectName,
                      "introduction": _introduction,
                      "context": _content,
                      "role": _role,
                      "accomplishment": _accomplishment,
                      "period": [_startDate, _endDate],
                      "keywords": _keywordItems,
                      "participants": _personItems,
                      'fileExtensions': List.generate(
                          _selectedFiles.length,
                          (index) => p
                              .extension(_selectedFiles[index].path.toString()))
                    };
                    Dio dio = Dio();
                    FormData formData = FormData.fromMap({
                      'data': jsonData,
                      'files': List.generate(
                          _selectedFiles.length,
                          (index) => MultipartFile.fromFileSync(
                              _selectedFiles[index].path.toString())),
                      // 파일 확장자를 추출합니다.
                    });

                    // 업로드 요청
                    dio.post(
                            'https://foggy-boundless-avenue.glitch.me/project/modify',
                            data: formData)
                        .then((response) {
                      logger.w(response);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }).catchError((error) => logger.w(error));
                  }
                })));
  }

  Future<dynamic> _future() async {
    Logger logger = Logger();
    final url =
        Uri.parse('https://foggy-boundless-avenue.glitch.me/project/info');
    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'docId': widget.projectID,
        },
      );
      Map<String, dynamic> data = const JsonDecoder().convert(response.body);

      return data;
    } catch (error) {
      logger.w(error);
    }
  }

  Future<void> _pickFile() async {
    result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        _selectedFiles.addAll(result!.files);
      });
    } else {
      print("User canceled the file picker");
    }
  }

  void _removeFile(PlatformFile file) {
    setState(() {
      _selectedFiles.remove(file);
    });
  }
}
