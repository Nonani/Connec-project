import 'package:connec_project/components/customEditTextForm.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            customEditTextForm(
              label: "이메일",
              hint: "example@connec.co.kr",
              onSaved: (newValue) {
              },
            ),
            customEditTextForm(
              label: "비밀번호",
              hint: "기호/영문/숫자 포함 8자 이상",
              isSecret: true,
              onSaved: (newValue) {
              },
            ),
            customEditTextForm(
              label: "비밀번호 확인",
              hint: "비밀번호를 입력해주세요",
              isSecret: true,
              onSaved: (newValue) {
              },
            ),
            customEditTextForm(
              label: "이름",
              hint: "이름(실명)을 입력해주세요",
              onSaved: (newValue) {
              },
            ),
            customEditTextForm(
              label: "직군/직무",
              hint: "이름(실명)을 입력해주세요",
              onSaved: (newValue) {
              },
            ),
            customEditTextForm(
              label: "경력",
              hint: "이름(실명)을 입력해주세요",
              onSaved: (newValue) {
              },
            ),
            customEditTextForm(
              label: "활동지",
              hint: "이름(실명)을 입력해주세요",
              onSaved: (newValue) {
              },
            ),
            customEditTextForm(
              label: "성별",
              hint: "이름(실명)을 입력해주세요",
              onSaved: (newValue) {
              },
            ),customEditTextForm(
              label: "나이",
              hint: "이름(실명)을 입력해주세요",
              onSaved: (newValue) {
              },
            ),customEditTextForm(
              label: "능력",
              hint: "이름(실명)을 입력해주세요",
              onSaved: (newValue) {
              },
            ),customEditTextForm(
              label: "소개",
              hint: "이름(실명)을 입력해주세요",
              onSaved: (newValue) {
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(child: Text("test"),onPressed: (){}),
    );
  }
}
