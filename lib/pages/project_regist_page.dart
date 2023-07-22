import 'package:connec/components/custom_edit_textform.dart';
import 'package:flutter/material.dart';

import '../style/titlestyle.dart';

class ProjectRegistPage extends StatefulWidget {
  const ProjectRegistPage({Key? key}) : super(key: key);

  @override
  State<ProjectRegistPage> createState() => _ProjectRegistPageState();
}

class _ProjectRegistPageState extends State<ProjectRegistPage> {
  String _projectName = '';
  String _introduction = '';
  String _content = '';

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              SignUpEditTextForm(label: "프로젝트 이름", hint: "프로젝트 이름을 작성해주세요", onSaved:(newValue) => _projectName = newValue),
              SignUpEditTextForm(label: "한줄 소개", hint: "프로젝트를 한 줄로 요약해주세요", onSaved:(newValue) => _introduction = newValue),
              SignUpEditTextForm(label: "내용", hint: "프로젝트의 내용에 대해 500자 내로 설명해주세요", onSaved:(newValue) => _content = newValue),

            ],
          ),
        ));
  }
}
