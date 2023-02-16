import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
            bottom: BorderSide(color: Color(0xffdbdbdb), width: 2.5)),
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        title: const Text(
          'CONNEC',
          style: TextStyle(
            color: Color(0xff5f66f2),
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: TextField(
          maxLines: 20,
          onChanged: ((value) {
            setState(() {
              inputText = value;
            });
          }),
        ),
      ),
      bottomNavigationBar:
      ElevatedButton(child: Text("연락 보내기"), onPressed: () async{
        if(widget.docID == null){

        }else{

        }
        var info = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get();
        var data = info.data();
        final url =
        Uri.parse('https://foggy-boundless-avenue.glitch.me/sendComm');
        try {
          http.Response response = await http.post(
            url,
            headers: <String, String>{
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: <String, String>{
              'to': '${widget.uid}',
              'from': "${FirebaseAuth.instance.currentUser!.uid}",

            },
          );
        }catch (e) {
        }
      }),
    );
  }
}
