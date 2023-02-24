import 'package:flutter/material.dart';

class MemberItemWidget extends StatelessWidget {
  const MemberItemWidget({
    Key? key,
    required TextStyle nameStyle,
    required TextStyle classStyle,
    required TextStyle contextStyle,
    required TextStyle itemStyle,
    required String field,
    required String rate,
    required String relationship,
    required String pCapability,
    required String sCapability,
  })  : _nameStyle = nameStyle,
        _classStyle = classStyle,
        _sectionStyle = contextStyle,
        _field = field,
        _rate = rate,
        _relationship = relationship,
        _pCapability = pCapability,
        _sCapability = sCapability,
        super(key: key);

  final TextStyle _nameStyle;
  final TextStyle _classStyle;
  final TextStyle _sectionStyle;

  final String _field;
  final String _rate;
  final String _relationship;
  final String _pCapability;
  final String _sCapability;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, left: 8),
            child: SizedBox(
              width: 360,
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(_field, style: _nameStyle),
                      SizedBox(width: 10),
                      Text(_field, style: _classStyle),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 160),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 21),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 7),
                                    child: Text("관계", style: _sectionStyle)),
                                Padding(
                                    padding: EdgeInsets.only(top: 7),
                                    child: Text("평점", style: _sectionStyle)),
                                Padding(
                                    padding: EdgeInsets.only(top: 7),
                                    child: Text("성격", style: _sectionStyle)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(top: 7),
                                  child: Text(_relationship,
                                      style: _sectionStyle)),
                              Padding(
                                  padding: EdgeInsets.only(top: 7),
                                  child: Text("${_rate} / 5.0",
                                      style: _sectionStyle)),
                              Padding(
                                  padding: EdgeInsets.only(top: 7),
                                  child:
                                      Text(_pCapability, style: _sectionStyle)),
                              Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child:
                                  Text(_sCapability, style: _sectionStyle)),
                            ],
                          )
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
