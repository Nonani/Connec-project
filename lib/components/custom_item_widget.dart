import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomItemWidget extends StatelessWidget {
  const CustomItemWidget({
    Key? key,
    required TextStyle nameStyle,
    required TextStyle contextStyle,
    required String name,
    required String rate,
    required String number,
    required String representative,
  }) : _nameStyle = nameStyle,
        _contextStyle = contextStyle,
        _name = name,
        _rate = rate,
        _number = number,
        _representative = representative,
        super(key: key);

  final TextStyle _nameStyle;
  final TextStyle _contextStyle;

  final String _name;
  final String _rate;
  final String _number;
  final String _representative;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: Image.network(
                "",
                width: 120,
                height: 120,
                fit: BoxFit.fitHeight),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 6, left: 8),
            child: SizedBox(
              width: 240,
              height: 103,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(_name, style: _nameStyle),
                  Container(
                    height: 0,
                    margin: const EdgeInsets.only(
                        top: 7.5, bottom: 10.5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xff5f66f2),
                        width: 1,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                        children: [
                          Text("지인 평점",
                              style: _contextStyle),
                          Text("지인 수",
                              style: _contextStyle),
                          Text("지인 대표 분야",
                              style: _contextStyle)
                        ],
                      ),
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.end,
                        children: [
                          Text("${_rate}/5.0",
                              style: _contextStyle),
                          Text(_number,
                              style: _contextStyle),
                          Text(_representative,
                              style: _contextStyle)
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}