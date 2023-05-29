import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dropdown_button.dart';
import 'package:connec/components/custom_edit_textform.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../components/custom_dialog.dart';
import '../../const/data.dart';
import '../../style/buttonstyle.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({required this.uid, required this.workCode, Key? key})
      : super(key: key);

  final String uid;

  final String workCode;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String inputText = '';
  String contactText = '';
  final _formKey = GlobalKey<FormState>();
  String offer = offerItemList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        title: Text(
          'CONNEC',
          style: connecTitle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            CustomDropdownButton(
                itemList: offerItemList,
                label: "제안 목적",
                onChanged: (value) {
                  offer = value;
                  setState(() {});
                },
                selectedItem: offer),
            SignUpEditTextForm(
              label: "제안 내용",
              hint: "인재에게 원하는 업무 내용을 작성해주세요\n(500자 이내)",
              onSaved: (newValue) => contactText = newValue,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
              alignment: AlignmentDirectional.centerStart,
              child: Text("인재가 수락을 하면 연락처를 알려드립니다.",
                  style: TextStyle(
                    color: Color(0xffbdbdbd),
                    fontSize: 16,
                    fontFamily: 'EchoDream',
                    fontWeight: FontWeight.w400,
                  )),
            )
            // TextField(
            //   maxLines: 20,
            //   onChanged: ((value) {
            //     setState(() {
            //       inputText = value;
            //     });
            //   }),
            // ),
          ]),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
          style: featureButton,
          child: Text(
            "제안권 사용",
            style: buttonText,
          ),
          onPressed: () async {
            FirebaseFirestore db = FirebaseFirestore.instance;
            Logger logger = Logger();
            int couponNum = (await db
                .collection('coupons')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get())
                .data()!['num'];
            if (_formKey.currentState!.validate() && couponNum > 0) {
              _formKey.currentState!.save();
              print(contactText);
              print(offer);
              showCustomDialog(context);

              var info = await db
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get();
              final url = Uri.parse(
                  'https://foggy-boundless-avenue.glitch.me/proposition/sendReq');
              try {
                http.Response response = await http.post(
                  url,
                  headers: <String, String>{
                    'Content-Type': 'application/x-www-form-urlencoded',
                  },
                  body: <String, String>{
                    'to': widget.uid,
                    'from': FirebaseAuth.instance.currentUser!.uid,
                    'workArea': widget.workCode,
                    'purpose': offer,
                    'context': contactText
                  },
                );
                logger.w(response.body);
              } catch (e) {
                logger.w(e);
              }

              Navigator.pop(context);
              Navigator.pop(context);
              await consume(widget.uid);
            } else {
              print(couponNum);
            }
          }),
    );
  }

  Future<void> consume(String uid) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    int couponNum = (await db
        .collection('coupons')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get())
        .data()!['num'];
    String name = (await db.collection('users').doc(uid).get()).data()!['name'];
    await db
        .collection('coupons')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'num': couponNum - 1});
    await db
        .collection('couponLog')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'consume': FieldValue.arrayUnion([
        {'time': DateTime.now().toString(), 'type': '사용', 'user': name}
      ])
    });
  }
}
