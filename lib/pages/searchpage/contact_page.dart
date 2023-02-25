import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/components/custom_dropdown_button.dart';
import 'package:connec/components/custom_edit_textform.dart';
import 'package:connec/style/titlestyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../components/custom_dialog.dart';
import '../../const/data.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({required this.uid, required this.docID, Key? key})
      : super(key: key);

  final String uid;
  final String docID;

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String inputText = '';
  String contactText = '';
  String OpenTalkUrl = '';
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
              hint: "인재가 관심을 가질 조건을 제안해주세요",
              onSaved: (newValue) => contactText = newValue,
            ),
            SignUpEditTextForm(
              label: "카카오톡 오픈채팅방 링크",
              hint: "오픈채팅방 링크를 입력해주세요",
              onSaved: (newValue) => OpenTalkUrl = newValue,
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
          child: Text("제안 보내기"),
          onPressed: () async {
            FirebaseFirestore db = FirebaseFirestore.instance;
            int couponNum = (await db
                .collection('coupons')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get())
                .data()!['num'];
            if (_formKey.currentState!.validate()&& couponNum > 0) {
              _formKey.currentState!.save();
              print(OpenTalkUrl);
              print(contactText);
              print(offer);
              showCustomDialog(context);
              if (widget.docID.isEmpty) {
                //유저인 경우
                var info = await db
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get();
                final url = Uri.parse(
                    'https://foggy-boundless-avenue.glitch.me/sendComm');
                try {
                  http.Response response = await http.post(
                    url,
                    headers: <String, String>{
                      'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: <String, String>{
                      'to': '${widget.uid}',
                      'from': "${FirebaseAuth.instance.currentUser!.uid}",
                      'type': "user",
                      'docId': '',
                      'purpose': offer,
                      'context': contactText,
                      'chatLink': OpenTalkUrl
                    },
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                  print(response.body);
                } catch (e) {
                  print(e);
                }
              } else {
                //  지인인 경우
                var info = await db
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get();
                final url = Uri.parse(
                    'https://foggy-boundless-avenue.glitch.me/sendComm');
                try {
                  http.Response response = await http.post(
                    url,
                    headers: <String, String>{
                      'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: <String, String>{
                      'to': '${widget.uid}',
                      'from': "${FirebaseAuth.instance.currentUser!.uid}",
                      'type': "member",
                      'docId': '${widget.docID}',
                      'purpose': offer,
                      'context': contactText,
                      'chatLink': OpenTalkUrl
                    },
                  );
                  Navigator.pop(context);
                  Navigator.pop(context);
                  print(response.body);
                } catch (e) {
                  print(e);
                }
              }
            }
          }),
    );
  }

  Future<void> consume() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    int couponNum = (await db
        .collection('coupons')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get())
        .data()!['num'];
    await db
        .collection('coupons')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'num': couponNum - 1});
    await db.collection('couponLog')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'consume': FieldValue.arrayUnion([
        {
          'time': DateTime.now().toString(),
          'type': 'contact'
        }
      ])
    });
  }
}
