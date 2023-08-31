// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/style/title_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// Auto-consume must be true on iOS.
// To try without auto-consume on another platform, change `true` to `false` here.

class IAPHistory extends StatefulWidget {
  @override
  State<IAPHistory> createState() => _IAPHistoryState();
}

class _IAPHistoryState extends State<IAPHistory> {
  int mode = 0;
  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = <Widget>[];
    stack.add(_buildUserInfo());
    stack.add(_buildSwitchButton());
    stack.add(_buildPurchaseHistory());
    return MaterialApp(
      home: Scaffold(
        appBar: _buildAppBar(),
        body: Column(
          children: stack,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 56,
      backgroundColor: const Color(0xfffafafa),
      shape:
          const Border(bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xff5f66f2),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        '쿠폰함',
        style: featureTitle,
      ),
      centerTitle: true,
    );
  }

  Widget _buildUserInfo() {
    return Container(
        height: 60,
        margin: EdgeInsets.only(left: 30, top: 20, right: 30),
        child: FutureBuilder(
          future: userInfo(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data['name'],
                    style: const TextStyle(
                      color: Color(0xff333333),
                      fontSize: 17,
                      fontFamily: 'EchoDream',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "현재 보유한 쿠폰",
                        style: TextStyle(
                          color: Color(0xffbdbdbd),
                          fontSize: 16,
                          fontFamily: 'EchoDream',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "${snapshot.data['num']}개",
                        style: const TextStyle(
                          color: Color(0xff5f66f2),
                          fontSize: 18,
                          fontFamily: 'EchoDream',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ],
              );
            } else {
              return Text(
                "불러오는 중",
                style: TextStyle(
                  color: Color(0xff999999),
                  fontSize: 16,
                  fontFamily: 'EchoDream',
                  fontWeight: FontWeight.w700,
                ),
              );
            }
          },
        ));
  }

  Widget _buildSwitchButton() {
    return Column(children: [
      Container(
        height: 1,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffdbdbdb),
            width: 1,
          ),
        ),
      ),
      Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Color(0xff5f66f2)),
              ),
            ),
            child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    mode = 0;
                  });
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  minimumSize: Size(MediaQuery.of(context).size.width / 2, 46),
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                ),
                child: const Text(
                  "구매 내역",
                  style: TextStyle(
                    color: Color(0xff5f66f2),
                    fontSize: 17,
                    fontFamily: 'EchoDream',
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
          Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xff5f66f2)),
                ),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      mode = 1;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      minimumSize:
                          Size(MediaQuery.of(context).size.width / 2, 46),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  child: const Text(
                    "사용 내역",
                    style: TextStyle(
                      color: Color(0xff5f66f2),
                      fontSize: 17,
                      fontFamily: 'EchoDream',
                      fontWeight: FontWeight.w500,
                    ),
                  )))
        ],
      )
    ]);
  }

  Widget _buildPurchaseHistory() {
    return FutureBuilder(
      future: purchaseHistory(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return Container(
              height: 380,
              child: ListView.builder(
                  itemCount: snapshot.data[mode].length,
                  itemBuilder: (BuildContext context, int index) {
                    if (mode == 0 && snapshot.data[mode].length > 0) {
                      return Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 6),
                          padding: EdgeInsets.only(
                              top: 15, bottom: 12, left: 18, right: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  snapshot.data[mode][index]['time']
                                      .toString()
                                      .substring(0, 10),
                                  style: const TextStyle(
                                    color: Color(0xff666666),
                                    fontFamily: 'EchoDream',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "구매",
                                        style: TextStyle(
                                          color: Color(0xffbdbdbd),
                                          fontSize: 16,
                                          fontFamily: 'EchoDream',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[mode][index]['merch']
                                            .toString().substring(3, 14),
                                        style: const TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: 16,
                                          fontFamily: 'EchoDream',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "금액",
                                        style: TextStyle(
                                          color: Color(0xffbdbdbd),
                                          fontSize: 16,
                                          fontFamily: 'EchoDream',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data[mode][index]['price'].toString()} 원',
                                        style: const TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: 16,
                                          fontFamily: 'EchoDream',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ]),
                              )
                            ],
                          ));
                    } else if (snapshot.data[mode].length > 0) {
                      return Container(
                          color: Colors.white,
                          margin: EdgeInsets.only(bottom: 6),
                          padding: EdgeInsets.only(
                              top: 15, bottom: 12, left: 18, right: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                  snapshot.data[mode][index]['time']
                                      .toString()
                                      .substring(0, 10),
                                  style: const TextStyle(
                                    color: Color(0xff666666),
                                    fontFamily: 'EchoDream',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(snapshot.data[mode][index]['user']),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        child: Row(children: [
                                      Text(
                                        snapshot.data[mode][index]['type'].toString(),
                                        style: const TextStyle(
                                          color: Color(0xff666666),
                                          fontSize: 16,
                                          fontFamily: 'EchoDream',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 27),
                                      const Text(
                                        "쿠폰 1개",
                                        style: TextStyle(
                                          color: Color(0xff5f66f2),
                                          fontSize: 16,
                                          fontFamily: 'EchoDream',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ])),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "구매취소",
                                          style: TextStyle(
                                            color: Color(0xff999999),
                                            fontSize: 16,
                                            fontFamily: 'S-CoreDream-4Regular',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ))
                                  ]),
                            ],
                          ));
                    } else {
                      return Container(
                          height: 380,
                          alignment: Alignment.center,
                          child: const Text(
                            "쿠폰 사용 내역이 없습니다.",
                            style: TextStyle(
                              color: Color(0xffbdbdbd),
                              fontSize: 13,
                              fontFamily: 'EchoDream',
                              fontWeight: FontWeight.w700,
                            ),
                          ));
                    }
                  }));
        } else {
          return Container(
              height: 380,
              alignment: Alignment.center,
              child: const Text(
                "쿠폰 구매 내역이 없습니다.",
                style: TextStyle(
                  color: Color(0xffbdbdbd),
                  fontSize: 13,
                  fontFamily: 'EchoDream',
                  fontWeight: FontWeight.w700,
                ),
              ));
        }
      },
    );
  }

  Future userInfo() async {
    Map<String, dynamic> result = {};
    FirebaseFirestore db = FirebaseFirestore.instance;
    String userName = (await db
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get())
        .data()!['name'];
    int couponNum = (await db
            .collection('coupons')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get())
        .data()!['num'];

    result['name'] = userName;
    result['num'] = couponNum;
    logger.w(result);
    return result;
  }

  Future purchaseHistory() async {
    List<List<dynamic>> result = [[], []];
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String, dynamic>? data = (await db
            .collection('couponLog')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get())
        .data();
    result[0] = data!['purchase'];
    result[1] = data['consume'];
    return result;
  }
}
