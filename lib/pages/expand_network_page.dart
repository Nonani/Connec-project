
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../components/custom_edit_textform.dart';
import 'package:http/http.dart' as http;
import '../services/service_class.dart';

class ExpandNetworkPage extends StatefulWidget {

  const ExpandNetworkPage({Key? key}) : super(key: key);

  @override
  State<ExpandNetworkPage> createState() => _ExpandNetworkPageState();

}
class _ExpandNetworkPageState extends State<ExpandNetworkPage>{
  String? _userCode;
  final _formKey = GlobalKey<FormState>();
  final logger = Logger();
  @override
  Widget build(BuildContext context){
    var provider = Provider.of<ServiceClass>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: const Color(0xfffafafa),
        shape: const Border(
            bottom: BorderSide(
                color: Color(0xffdbdbdb),
                width: 2
            )
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff5f66f2),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("네트워크 확장",
          style: TextStyle(
            color: Color(0xff333333),
            fontSize: 20,
            fontFamily: 'EchoDream',
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: const [IconButton(
            icon: Icon(Icons.link_sharp),
            color: Color(0xff5f66f2),
            onPressed: null),
        ],
      ),

      body : Consumer<ServiceClass>(
        builder: (context, data, child){
          return data.loading ?
          Container(
              child: const Text("네트워크 확장")
          ): SafeArea(
              child: Form (
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ Padding(
                    padding: EdgeInsets.only(top: 47.1),
                    child: LoginEditTextForm(
                      label: "확장할 지인 코드",
                      hint: "지인의 코드를 입력해 주세요",
                      isSecret: false,
                      onSaved: (newValue) => _userCode = newValue,
                    ),
                  ),
                    const Padding(
                        padding: EdgeInsets.only(left: 22.5, top: 8.1),
                        child: Text("서로가 모두 네트워크 확장을 신청하면 2~3일 이내\n네트워크가 업데이트 됩니다.",
                          style: TextStyle(
                            color: Color(0xffafafaf),
                            fontSize: 11.5,
                            fontFamily: 'EchoDream',
                          ),
                        )
                    ),
                  ],
                ),
              )
          );
        },
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            var info = await FirebaseFirestore.instance.collection('member').doc(_userCode).get();
            var data = info.data();
            final url = Uri.parse('https://foggy-boundless-avenue.glitch.me/sendReq');
            try {
              http.Response response = await http.post(
                url,
                headers: <String, String> {
                  'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: <String, String> {
                  'to': data!['uid'],
                  'from': 'kakao:2593652809'
                },
              );
              logger.w(response.body);
            }catch(e){
              //logger.w(e);
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff5f66f2),
          minimumSize: const Size(100, 56),
        ),
        child: const Text('확장하기',
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
