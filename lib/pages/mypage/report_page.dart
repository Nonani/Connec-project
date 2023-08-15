import 'package:connec/const/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/custom_dropdown_button.dart';
import '../../components/custom_edit_textform.dart';
import '../../style/buttonstyle.dart';
import '../../style/titlestyle.dart';

class ReportPage extends StatefulWidget {
  final String to;
  final String from;

  const ReportPage({required this.to, required this.from, super.key});

  @override
  State<StatefulWidget> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String reportDetail = "";
  String category = reportCategoryList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 56,
        backgroundColor: const Color(0xfffafafa),
        shape: const Border(
            bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff5f66f2),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: GestureDetector(
          child: Text(
            'CONNEC',
            style: connecTitle,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      body: Form(
        child: Column(
          children: [
            Container(
              height:50,
              margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
              decoration: BoxDecoration(
                color: Color(0xffeeeeee),
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff5f66f2),
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    '신고 대상',
                    style: TextStyle(
                      color: Color(0xff333333),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    (FirebaseAuth.instance.currentUser!.uid==widget.from)?
                    '${widget.to}':widget.from,
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            CustomDropdownButton(
                itemList: reportCategoryList,
                label: "신고 분류",
                onChanged: (value) {
                  category = value;
                  setState(() {});
                },
                selectedItem: category),
            SignUpEditTextForm(
              label: "신고 내용",
              hint: "해당 내용에 대해 자세히 서술해 주세요",
              type: TextInputType.text,
              onSaved: (newValue) => reportDetail = newValue,
            ),
            //TODO Implement Image Upload
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: featureButton,
        onPressed: () {
          //TODO Implement report send
        },
        child: Text(
          "신고하기",
          style: buttonText,
        ),
      ),
    );
  }
}
