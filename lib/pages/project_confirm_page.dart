import 'package:flutter/material.dart';

import '../style/titlestyle.dart';

class ProjectConfirmPage extends StatefulWidget {
  const ProjectConfirmPage({Key? key}) : super(key: key);

  @override
  State<ProjectConfirmPage> createState() => _ProjectConfirmPageState();
}

class _ProjectConfirmPageState extends State<ProjectConfirmPage> {
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
          '프로젝트 참여 확인',
          style: featureTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: [

          ],
        ),
      ),
    );
  }
}
