
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../components/custom_edit_textform.dart';
import '../../services/service_class.dart';

class ResetPasswordPage extends StatefulWidget {

  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();

}
class _ResetPasswordPageState extends State<ResetPasswordPage>{
  String email = "";
  final _formKey = GlobalKey<FormState>();
  final logger = Logger();

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: const Color(0xfffafafa),
        shape: const Border(
            bottom: BorderSide(
                color: Color(0xffdbdbdb),
                width: 2
            )
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff5f66f2),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("비밀번호 찾기",
          style: featureTitle,
        ),
      ),

      body : Consumer<ServiceClass>(
        builder: (context, data, child){
          return data.loading ?
          Container(
              child: const Text("비밀번호 찾기")
          ): SafeArea(
              child: Form (
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ Padding(
                    padding: EdgeInsets.only(top: 47.1),
                    child: signUpEditTextForm(
                      label: "가입한 이메일 주소를 입력해 주세요.",
                      hint: "example@connec.co.kr",
                      isSecret: false,
                      type: TextInputType.emailAddress,
                      onSaved: (newValue) => email = newValue,
                    ),
                  ),
                    const Padding(
                        padding: EdgeInsets.only(left: 22.5, top: 8.1),
                        child: Text("가입하신 이메일 주소를 입력해주시면\n새로운 비밀번호를 설정 가능한 링크를 보내드립니다.",
                          style: TextStyle(
                            color: Color(0xffafafaf),
                            fontSize: 11.5,
                            fontFamily: 'S-CoreDream-4',
                          ),
                        )
                    ),
                  ],
                ),
              )
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        } on FirebaseAuthException catch (e) {
          logger.w(e);
          return;
        }
      }
      },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff5f66f2),
          minimumSize: const Size(100, 56),
        ),
        child: const Text('전송하기',
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
