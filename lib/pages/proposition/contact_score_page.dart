import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import '../../style/buttonstyle.dart';

class ContactScorePage extends StatefulWidget {
  const ContactScorePage(
      {Key? key,
      required this.to_uid,
      required this.name,
      required this.urlImage})
      : super(key: key);
  final String to_uid;
  final String name;
  final String urlImage;

  @override
  State<ContactScorePage> createState() => _ContactScorePageState();
}

class _ContactScorePageState extends State<ContactScorePage> {
  TextEditingController textEditingController = TextEditingController();
  double _expertise = 0;
  double _personality = 0;
  double _speed = 0;
  double _average() {
    return (_expertise + _personality + _speed) / 3;
  }
  String _formatAverage() {
    if (_average() == _average().truncateToDouble()) {
      return _average().toStringAsFixed(0);
    } else {
      return _average().toStringAsFixed(1);
    }
  }

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
        title: Text(
          '평가하기',
          style: TextStyle(
            color: Color(0xfffafafa),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(
          child: Container(
            width: 200,
            height: 200,
            margin: EdgeInsets.only(left: 80, right: 80, top: 40, bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                "${widget.urlImage}",
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            widget.name,
            style: TextStyle(
              color: Color(0xff333333),
              fontSize: 20,
              fontFamily: 'S-CoreDream-6',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 16,
            left: 26,
            right: 26,
          ),
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Color(0xff5f66f2), width: 1.5),
                bottom: BorderSide(color: Color(0xff5f66f2), width: 1.5)),
            color: Color(0xffeeeeee),
          ),
          child: Column(
            children: [
              Text(
                '${_formatAverage()} 점',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 46,
                  fontFamily: 'S-CoreDream-5',
                  fontWeight: FontWeight.w500,
                ),
              ),
              RatingBar.builder(
                initialRating: _average(),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                ignoreGestures: true,
                itemSize: 35,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color(0xff5f66f2),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '전문성',
                style: TextStyle(
                  color: Color(0xffbdbdbd),
                  fontSize: 17,
                  fontWeight: FontWeight.w200,
                ),
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber),
                itemSize: 30,
                onRatingUpdate: (value) {
                  setState(() {
                    _expertise = value;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '인성',
                style: TextStyle(
                  color: Color(0xffbdbdbd),
                  fontSize: 17,
                  fontWeight: FontWeight.w200,
                ),
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber),
                itemSize: 30,
                onRatingUpdate: (value) {
                  setState(() {
                    _personality = value;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 26, right: 26, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '신속성',
                style: TextStyle(
                  color: Color(0xffbdbdbd),
                  fontSize: 17,
                  fontWeight: FontWeight.w200,
                ),
              ),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Colors.amber),
                itemSize: 30,
                onRatingUpdate: (value) {
                  setState(() {
                    _speed = value;
                  });
                },
              ),
            ],
          ),
        ),
        Container(
            margin: EdgeInsets.only(
              left: 26,
              right: 26,
              bottom: 20
            ),
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
            ),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: '전문성, 인성, 신속성에 대해 500자 이하로 작성해주세요.',
                hintStyle: TextStyle(
                    color: Color(0xff333333),
                    fontSize: 11,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 5,
            )),
      ])),
      bottomNavigationBar: ElevatedButton(
        style: featureButton,
        onPressed: () async {
          Logger logger = Logger();
          final url = Uri.parse(
              '');
          try {
            http.Response response = await http.post(
              url,
              headers: <String, String>{
                'Content-Type': 'application/x-www-form-urlencoded',
              },
              body: <String, String>{
                'reporting_uid': FirebaseAuth.instance.currentUser!.uid,
                'reported_uid': widget.to_uid,
                'content': textEditingController.text.toString(),
              },
            );
            logger.w(response.body);
            return jsonDecode(response.body);
          } catch (e) {
            print("Error getting document: $e");
          }
        },
        child: Text(
          '확인',
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
