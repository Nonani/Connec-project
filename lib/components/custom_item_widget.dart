import 'package:connec/style/contextstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkItemWidget extends StatelessWidget {
  const NetworkItemWidget({
    Key? key,
    required String name,
    required String rate,
    required String number,
    required List<dynamic> representative,
  })  : _name = name,
        _rate = rate,
        _number = number,
        _representative = representative,
        super(key: key);

  final String _name;
  final String _rate;
  final String _number;
  final List<dynamic> _representative;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 3, left: 8),
        child: SizedBox(
          width: 360,
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_name, style: contextTitle),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 120),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text("지인 평점", style: contextKey),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text("지인 수", style: contextKey),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text("지인 성격", style: contextKey),
                      ),
                    ],
                  ),
                  SizedBox(width: 120),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text("$_rate / 5.0", style: contextValue),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(_number, style: contextValue),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Text(_representative[0], style: contextValue)
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: Text(_representative[1], style: contextValue)
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
