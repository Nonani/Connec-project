import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

Widget ReceiveNetworkRequest(Map<String, String> notice) {
  Logger logger = Logger();
  try {
    switch (notice["case"]) {
      case "waiting":
        return Container(
          child: Text("${notice["from"]}님이 요청을 보냈습니다."),
        );
      case "rejected":
        return Container();
      case "accepted":
        return Container();
      default:
        return Container();
    }
  } catch (e) {
    logger.w(e);
    return Container();
  }
}
Widget SentNetworkRequest(Map<String, String> notice) {
  Logger logger = Logger();
  try {
    switch (notice["case"]) {
      case "waiting":
        return Container(
          child: Text("${notice["to"]}님이 요청을 확인중입니다."),
        );
      case "rejected":
        return Container(
          child: Text("${notice["to"]}님이 요청을 거절하였습니다."),
        );
      case "accepted":
        return Container(
          child: Text("${notice["to"]}님이 요청을 수락하였습니다."),
        );
      default:
        return Container();
    }
  } catch (e) {
    logger.w(e);
    return Container();
  }
}
