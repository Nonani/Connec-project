
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/CustomEditTextForm.dart';
import '../services/service_class.dart';

class ExpandNetworkPage extends StatefulWidget {

  const ExpandNetworkPage({Key? key}) : super(key: key);

  @override
  State<ExpandNetworkPage> createState() => _ExpandNetworkPageState();

}
class _ExpandNetworkPageState extends State<ExpandNetworkPage>{
  String? _userCode;

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
            fontFamily: 'S-CoreDream-5Medium',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [ Padding(
                    padding: EdgeInsets.only(top: 47.1),
                    child: CustomEditTextForm(
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
                            fontFamily: 'S-CoreDream-4',
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
        onPressed: () {  },
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
