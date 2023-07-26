import 'package:connec/components/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../style/titlestyle.dart';

class ProjectDetailPage extends StatelessWidget {
  ProjectDetailPage(this.dID, {Key? key}) : super(key: key);
  final dID;
  Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Image.asset(
                "assets/images/connec_logo2.png",
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('수정하기'),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) =>
                //           EditMyInfoPage(
                //               snapshot.data["location"],
                //               snapshot.data["work"]),
                //     )).then((value) => setState(() {}));
              },
            ),
            ListTile(
              title: Text('공유하기'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: const Color(0xfffafafa),
        shape: const Border(
            bottom: BorderSide(color: Color(0xffdbdbdb), width: 2)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff5f66f2),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '프로젝트 상세',
          style: featureTitle,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _future(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            logger.w(snapshot.data);
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("프로젝트 이름"),
                        Text(snapshot.data["name"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("한 줄 소개"),
                        Text(snapshot.data["introduction"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("내용"),
                        Text(snapshot.data["context"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("본인의 역할"),
                        Text(snapshot.data["role"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("본인의 성과"),
                        Text(snapshot.data["accomplishment"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("참여 기간"),
                        Text(snapshot.data["period"]),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("참여자 명단"),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data["participants"].length,
                          itemBuilder: (context, index) {
                            Map<String,dynamic> item = snapshot.data['participants'][index];

                            return Text(
                                "${item["name"]}\t ${item["phone_number"] != '' ? item["phone_number"] : "미등록"}");
                          },
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CustomLoadingDialog();
          }
        },
      ),
    );
  }

  Future _future() async {
    final url =
        Uri.parse('https://foggy-boundless-avenue.glitch.me/project/info');
    try {
      http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: <String, String>{
          'docId': dID,
        },
      );
      logger.w(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      logger.w(e);
    }

    return null;
  }
}
