import 'package:flutter/material.dart';


class ContactStatePage extends StatelessWidget {
  const ContactStatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xfffafafa),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff5f66f2),
        elevation: 0,
        title: Text('제안 세부내용',
          style: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 0,
              margin: EdgeInsets.only(
                left: 17.5,
                right: 17.5,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff5f66f2),
                  width: 2,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
