import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/custom_edit_textform.dart';

class ChangeNamePage extends StatefulWidget {
  const ChangeNamePage({Key? key}) : super(key: key);

  @override
  State<ChangeNamePage> createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  final _formKey = GlobalKey<FormState>();

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
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '이름 변경',
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 47.1),
              child: LoginEditTextForm(
                label: "이름",
                hint: "김컨넥",
                isSecret: false,
                onSaved: (newValue) => null,
              ),
            ),
          ],
        ),
      )),
        bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();



            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff5f66f2),
            minimumSize: const Size(100, 56),
          ),
          child: const Text(
            '변경하기',
            style: TextStyle(
              color: Color(0xfffafafa),
              fontSize: 20,
              fontFamily: 'S-CoreDream-4',
            ),
          ),
        ),
    );
  }
}
