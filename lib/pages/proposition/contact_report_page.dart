import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../style/buttonstyle.dart';

class ContactReportPage extends StatefulWidget {


  ContactReportPage({Key? key, required this.to_uid, required this.name, }) : super(key: key);
  final String to_uid;
  final String name;
  @override
  State<ContactReportPage> createState() => _ContactReportPageState();
}

class _ContactReportPageState extends State<ContactReportPage> {
  final List<XFile?> _pickedImages = [];
  TextEditingController textEditingController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  List<String> dropdownList = ["정보 불일치", "연락 두절", "기타"];
  String selectedPurpose = "정보 불일치";
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
          '신고하기',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, top: 26),
              child: Text(
                '▶ 신고한 내용',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 18,
                  fontFamily: 'S-CoreDream-5',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 26, top: 18),
              child: Row(
                children: [
                  Text(
                    '신고 대상',
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 26),
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: Color(0xffafafaf),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 26, top: 20),
              child: Row(
                children: [
                  Text(
                    '신고 목적',
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 26),
                  DropdownButton(
                    value: selectedPurpose,
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    items: dropdownList.map((String item) {
                      return DropdownMenuItem<String>(
                        child: Text('$item'),
                        value: item,
                      );
                    }).toList(),
                    onChanged: (dynamic value) {
                      setState(() {
                        selectedPurpose = value;
                      });
                    },
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 26, top: 20, right: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('신고 내용',
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextField(
                    controller: textEditingController,
                    style:  TextStyle(
                      color: Color(0xffbdbdbd),
                      fontSize: 15,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 26, top: 20, right: 26),
              child: Text('참고 이미지',
                style: TextStyle(
                  color: Color(0xff666666),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),  SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 26, top: 20, right: 26),
              height: 150,
              child: Column(
                children: [
                  _gridPhoto(),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(left: 26, right: 26),
              child: TextButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: Icon(Icons.photo_library),
                label: Text('사진 첨부'),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: featureButton,
        onPressed: () async{
          Logger logger = Logger();
          Uri apiUrl = Uri.parse("https://foggy-boundless-avenue.glitch.me/proposition/report"); // 백엔드 엔드포인트로 변경
          Map<String, dynamic> jsonStringData = {
            'reporting_uid': FirebaseAuth.instance.currentUser!.uid,
            'reported_uid': widget.to_uid,
            'purpose' : selectedPurpose,
            'content': textEditingController.text.toString(),
          };


          // Multipart 요청 준비
          try{
            http.MultipartRequest request = http.MultipartRequest("POST", apiUrl);
            String jsonData = json.encode(jsonStringData);
            logger.w(jsonData);
            request.fields['json_data'] = jsonData;
            // 이미지 파일을 순회하면서 원하는 형식으로 추가
            for (XFile? pickedImage in _pickedImages) {
              if (pickedImage != null) {
                // File에서 이미지 데이터 읽기
                File imageFile = File(pickedImage.path);
                List<int> imageData = await imageFile.readAsBytes();

                // Multipart 파일으로 변환
                http.MultipartFile multipartImage = http.MultipartFile.fromBytes(
                  "image",
                  imageData,
                  filename: imageFile.path,
                  contentType: MediaType("image", "jpg"), // 필요한 경우 변경
                );

                // 이미지 파일을 Multipart 요청에 추가
                request.files.add(multipartImage);
              }
            }

            // 요청 보내기
            http.StreamedResponse response = await request.send();

            // 응답 처리
            if (response.statusCode == 200) {
              print("Image Upload Successful");
            } else {
              print("Image Upload Failed");
            }
          }catch(e){
            logger.w(e);
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
  Widget _gridPhoto() {
    return Expanded(
      child: _pickedImages.isNotEmpty
          ? GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        children: _pickedImages
            .where((element) => element != null)
            .map((e) => _gridPhotoItem(e!))
            .toList().cast<Widget>(),
      )
          : const SizedBox(),
    );
  }
  Widget _gridPhotoItem(XFile e) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(e.path),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _pickedImages.remove(e);
                });
              },
              child: const Icon(
                Icons.cancel_rounded,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<void> _pickImage(ImageSource source) async {
    final List<XFile>? images = await picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _pickedImages.addAll(images);
      });
    }
  }

}
