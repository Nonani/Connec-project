import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../components/custom_edit_textform.dart';
import 'package:http/http.dart' as http;
import '../components/custom_expansion_tile.dart';
import '../services/service_class.dart';
import 'expand_network_page.dart';

class AcquitanceManagementPage extends StatelessWidget {
  Map<String, dynamic> data;

  AcquitanceManagementPage(this.data, {Key? key}) : super(key: key);

  final logger = Logger();
  final TextStyle _nameStyle = const TextStyle(
    color: Color(0xff333333),
    fontSize: 19,
    fontFamily: 'S-CoreDream-6Bold',
    fontWeight: FontWeight.w500,
  );
  final TextStyle _contextStyleKey = const TextStyle(
    color: Color(0xffafafaf),
    fontSize: 13,
    fontFamily: 'EchoDream',
    fontWeight: FontWeight.w200,
  );
  final TextStyle _contextStyleValue = const TextStyle(
    color: Color(0xff666666),
    fontSize: 13,
    fontFamily: 'EchoDream',
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 56,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff5f66f2),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Center(
          child: Column(children: [
            Container(
                width: double.infinity, height: 250, child: Image.network("")),
            Container(
                height: 450,
                width: 330,
                margin: const EdgeInsets.only(top: 13, bottom: 10.5),
                child: SingleChildScrollView(
                    child: Column(children: [
                  Container(
                    padding: EdgeInsets.only(top: 13, bottom: 13),
                    child: Text(
                      data['capability'],
                      style: const TextStyle(
                        color: Color(0xff333333),
                        fontSize: 21,
                        fontFamily: 'EchoDream',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: 336,
                    height: 0,
                    margin: const EdgeInsets.only(top: 7.5, bottom: 10.5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff5f66f2),
                        width: 1,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 17.5, right: 17.5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("관계", style: _contextStyleKey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("평점", style: _contextStyleKey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("직군/직무", style: _contextStyleKey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("경력", style: _contextStyleKey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("활동지", style: _contextStyleKey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("성별", style: _contextStyleKey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("나이", style: _contextStyleKey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("능력", style: _contextStyleKey),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("소개", style: _contextStyleKey),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child:
                                      Text('한 다리', style: _contextStyleValue),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text("${data['capability']} / 5.0",
                                      style: _contextStyleValue),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(data['capability'],
                                      style: _contextStyleValue),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(data['work'],
                                      style: _contextStyleValue),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(data['location'],
                                      style: _contextStyleValue),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(data['gender'],
                                      style: _contextStyleValue),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(data['age'],
                                      style: _contextStyleValue),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(data['capability'],
                                      style: _contextStyleValue),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(data['introduction'],
                                      style: _contextStyleValue),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ]))),
          ]),
        ),
        bottomNavigationBar: Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5f66f2),
                  minimumSize: const Size(180, 56),
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  elevation: 0),
              child: const Text(
                '수정',
                style: TextStyle(
                  color: Color(0xfffafafa),
                  fontSize: 20,
                  fontFamily: 'EchoDream',
                ),
              ),
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () async {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff5f66f2),
                  minimumSize: const Size(180, 56),
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  elevation: 0),
              child: const Text(
                '삭제',
                style: TextStyle(
                  color: Color(0xfffafafa),
                  fontSize: 20,
                  fontFamily: 'EchoDream',
                ),
              ),
            ),
          ),
        ]));
  }
}
