import 'package:flutter/material.dart';
Widget CustomLoadingDialog(){
  return Dialog(
    // The background color
    backgroundColor: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          // The loading indicator
          CircularProgressIndicator(),
          SizedBox(
            height: 15,
          ),
          // Some text
          Text('로딩 중...',
            style: TextStyle(
              color: Color(0xff5f66f2),
              fontSize: 17,
              fontFamily: 'S-CoreDream-5',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8,),
          Text('잠시만 기다려주세요.',
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 20,
              fontFamily: 'S-CoreDream-6',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    ),
  );
}
Widget CustomLoadingPage(){
  return Scaffold(
    appBar: AppBar(
      leading: Container(),
      elevation: 0,
      backgroundColor: const Color(0xfffafafa),
      shape: const Border(
          bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
      title:Text('CONNEC',
        style: TextStyle(
          color: Color(0xff5f66f2),
          fontSize: 25,
          fontWeight: FontWeight.w900,
        ),
      ),
      centerTitle: true,

    ),
    body:Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 50,),
            Text('로딩 중...',
              style: TextStyle(
                color: Color(0xff5f66f2),
                fontSize: 20,
                fontFamily: 'S-CoreDream-5',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8,),
            Text('잠시만 기다려주세요.',
              style: TextStyle(
                color: Color(0xff333333),
                fontSize: 21,
                fontFamily: 'S-CoreDream-6',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    )
  );
}

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomLoadingDialog();
    },
  );
}