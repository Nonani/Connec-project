import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shape: Border(bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        title: Text("로그인",
            style: TextStyle(
                fontFamily: "EchoDream", fontSize: 20, color: Colors.black)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.15,
              child: Center(
                child: Text(
                  "CONNEC",
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "EchoDream",
                      fontWeight: FontWeight.w800,
                      color: Color(0xff5f66f2)),
                ),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customEditTextForm("이메일", "example@connec.co.kr", false),
                  customEditTextForm("비밀번호", "비밀번호를 입력해주세요", true),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    width: double.infinity,
                    height: 70,
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "이메일 로그인",
                          style: TextStyle(
                              fontFamily: "EchoDream",
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xff5f66f2),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            )))),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "비밀번호 찾기",
                      style: TextStyle(color: Color(0xffbdbdbd)),
                    )),
                SizedBox(
                  height: size.height * 0.01,
                  child: VerticalDivider(
                    color: Color(0xffbdbdbd),
                    //color of divider
                    width: 10,
                    //width space of divider
                    thickness: 1,
                    //thickness of divier line
                    indent: 10,
                    //Spacing at the top of divider.
                    endIndent: 10, //Spacing at the bottom of divider.
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "회원가입",
                      style: TextStyle(color: Color(0xffbdbdbd)),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
                child: Text(
              "다른 방법으로 로그인 하기",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            )),
            SizedBox(height: size.height*0.02),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: size.width * 0.01),
                customImageButton(AssetImage("assets/images/kakao_btn.png")),
                customImageButton(AssetImage("assets/images/naver_btn.png")),
                customImageButton(AssetImage("assets/images/facebook_btn.png")),
                SizedBox(width: size.width * 0.01),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customEditTextForm(String label, String hint, bool isSecret) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${label}",
              style: TextStyle(
                fontFamily: "EchoDream",
                fontWeight: FontWeight.w600,
                fontSize: 16,
              )),
          SizedBox(height: 10),
          TextFormField(
            obscureText: isSecret,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff5f66f2), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff5f66f2), width: 2),
                  borderRadius: BorderRadius.circular(25),
                ),
                hintText: "${hint}",
                hintStyle: TextStyle(
                    color: Color(0xffbdbdbd),
                    fontSize: 15,
                    fontFamily: "EchoDream",
                    fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }

  Widget customImageButton(AssetImage img) {
    return GestureDetector(
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(image: img, fit: BoxFit.cover),
          ),
        ),
        onTap: () {
          print("you clicked me");
        });
  }
}
