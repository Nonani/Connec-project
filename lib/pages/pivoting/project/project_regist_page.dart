import 'package:connec/components/custom_edit_textform.dart';
import 'package:connec/style/icon_style.dart';
import 'package:connec/style/padding_style.dart';
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

class ProjectRegistPage extends StatefulWidget {
  const ProjectRegistPage({Key? key}) : super(key: key);

  @override
  State<ProjectRegistPage> createState() => _ProjectRegistPageState();
}

class _ProjectRegistPageState extends State<ProjectRegistPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController personController = TextEditingController();
  TextEditingController keywordController = TextEditingController();
  String _projectName = '';
  String _introduction = '';
  String _content = '';
  String _role = '';
  String _accomplishment = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  final List<String> _personItems = [];
  final List<String> _keywordItems = [];
  final List<PlatformFile> _selectedFile = [];

  FilePickerResult? result;

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
            '프로젝트 등록',
            style: featureTitle,
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                inputEditTextForm(
                    label: "프로젝트 이름",
                    hint: "프로젝트 이름을 작성해주세요",
                    type: TextInputType.text,
                    onSaved: (newValue) => _projectName = newValue),
                inputEditTextForm(
                    label: "한줄 소개",
                    hint: "프로젝트를 한 줄로 요약해주세요",
                    type: TextInputType.text,
                    onSaved: (newValue) => _introduction = newValue),
                inputEditTextForm(
                    label: "내용",
                    lineNum: 10,
                    type: TextInputType.text,
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
                        onPressed: _pickFile,
                        label: const Text('파일 선택'),
                        backgroundColor: Color(0xff5f66f2),
                      ),
                      Column(
                        children: _selectedFile
                            .map((file) => Padding(
                                  padding: topPadding10,
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
                inputEditTextForm(
                    label: "본인의 역할",
                    hint: "본인의 역할에 대해 500자 내로 설명해주세요",
                    lineNum: 10,
                    type: TextInputType.text,
                    onSaved: (newValue) => _role = newValue),
                inputEditTextForm(
                    label: "본인의 성과",
                    hint: "본인의 성과에 대해 500자 내로 설명해주세요",
                    lineNum: 10,
                    type: TextInputType.text,
                    onSaved: (newValue) => _accomplishment = newValue),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text("참여자 명단\t", style: labelStyle),
                                    Text(" ※ 최대 5명",
                                        style: constraintStyle)
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    var name = personController.text;
                                    if (name.isNotEmpty &&
                                        !_personItems.contains(name) &&
                                        _personItems.length < 5) {
                                      _personItems.add(name);
                                      setState(() {
                                        personController.clear();
                                      });
                                    }
                                  },
                                  icon: addIcon
                                )
                              ]),
                          TextFormField(
                            controller: personController,
                            decoration: InputDecoration(
                                hintText: "참여자의 이름을 작성해주세요",
                                hintStyle: inputHintStyle,
                                filled: true,
                                fillColor: Color(0xffeeeeee),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Color(0xff5f66f2)))),
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
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
            height: 56,
            child: ElevatedButton(
                style: featureButton,
                child: Text(
                  '완료',
                  style: buttonText,
                ),
                onPressed: () async {
                  _formKey.currentState!.save();
                  if (_startDate.compareTo(_endDate) != -1) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            // The background color
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: bottomPadding10,
                                      child: removeIcon),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('시작일은 종료일보다 앞서야 합니다.',
                                            style: dialogContextStyle),
                                      ]),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  if (_formKey.currentState!.validate()) {
                    Logger logger = Logger();

                    Map<String, dynamic> jsonData = {
                      "uid": FirebaseAuth.instance.currentUser!.uid,
                      "name": _projectName,
                      "introduction": _introduction,
                      "context": _content,
                      "role": _role,
                      "accomplishment": _accomplishment,
                      "period": [_startDate.toString(), _endDate.toString()],
                      "keywords": _keywordItems,
                      "participants": _personItems,
                      'fileExtensions':
                          List.generate(_selectedFile.length, (index) {
                        logger.w(
                            p.extension(_selectedFile[index].path.toString()));
                        return p
                            .extension(_selectedFile[index].path.toString());
                      })
                    };
                    showCustomDialog(context);

                    var dio = Dio();
                    var formData = FormData.fromMap({
                      'data': jsonData,
                      'files': List.generate(
                          _selectedFile.length,
                          (index) => MultipartFile.fromFileSync(
                              _selectedFile[index].path.toString())),
                    });
                    // 업로드 요청
                    await dio.post(
                            'https://foggy-boundless-avenue.glitch.me/project/upload', data: formData)
                        .then((res) {
                          logger.w(res);
                          Navigator.pop(context);
                          Navigator.of(context, rootNavigator: true).pop(context);
                    });
                  }
                })));
  }

  void _removeFile(PlatformFile file) {
    setState(() {
      _selectedFile.remove(file);
    });
  }

  Future<void> _pickFile() async {
    result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null && _selectedFile.isEmpty) {
      setState(() {
        _selectedFile.add(result!.files[0]);
      });
    } else {
      print("User canceled the file picker");
    }
  }
}
