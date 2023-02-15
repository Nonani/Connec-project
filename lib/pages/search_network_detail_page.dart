import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class SearchNetworkDetailPage extends StatelessWidget {
  Map<String, dynamic> data;

  SearchNetworkDetailPage(this.data, {Key? key}) : super(key: key);

  final logger = Logger();
  // final TextStyle _nameStyle = const TextStyle(
  //   color: Color(0xff333333),
  //   fontSize: 19,
  //   fontFamily: 'S-CoreDream-6Bold',
  //   fontWeight: FontWeight.w500,
  // );
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
  build(BuildContext context) {
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
          child: SingleChildScrollView(
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
                            data['title'],
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
                              color: const Color(0xff5f66f2),
                              width: 1,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 17.5, right: 17.5),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("관계", style: _contextStyleKey),
                                  Text('한 다리', style: _contextStyleValue),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("평점", style: _contextStyleKey),
                                  Text("${data['rate']} / 5.0",
                                      style: _contextStyleValue),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "직군/직무",
                                    style: _contextStyleKey,
                                  ),
                                  SizedBox(width: 20,),
                                  FutureBuilder(
                                    future: workString(data['workArea']),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Expanded(
                                          child: Text(
                                            snapshot.data!,
                                            style: _contextStyleValue,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        );
                                      } else {
                                        return Text("불러오는 중",
                                            style: _contextStyleValue);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("경력", style: _contextStyleKey),
                                  SizedBox(width: 20,),
                                  Text(data['career'][0],
                                      style: _contextStyleValue),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("지역", style: _contextStyleKey),
                                  Text(data['location'],
                                      style: _contextStyleValue),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("성별", style: _contextStyleKey),
                                  Text(data['gender'],
                                      style: _contextStyleValue),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("나이", style: _contextStyleKey),
                                  Text(data['age'], style: _contextStyleValue),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("성격", style: _contextStyleKey),
                                  Text(data['personality'][0],
                                      style: _contextStyleValue),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("소개", style: _contextStyleKey),
                                  Text(data['introduction'],
                                      style: _contextStyleValue),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]))),
            ]),
          ),
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
                '연락하기',
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

  Future<String> workString(List<dynamic> workData) async {
    logger.w(workData);
    String ret = "";
    FirebaseFirestore db = FirebaseFirestore.instance;
    for (String code in workData) {
      QuerySnapshot<Map<String, dynamic>> data =
      await db.collection('workData').where('code', isEqualTo: code).get();
      ret = "> ${data.docs[0]['title']}";
      data = await db
          .collection('workData')
          .where('code', isEqualTo: data.docs[0]['parent'])
          .get();
      ret = "> ${data.docs[0]['title']}" + ret;
      data = await db
          .collection('workData')
          .where('code', isEqualTo: data.docs[0]['parent'])
          .get();
      ret = data.docs[0]['title'] + ret;
    }
    logger.w(ret);
    return ret;
  }
}
