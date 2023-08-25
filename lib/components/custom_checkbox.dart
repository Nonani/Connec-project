import 'package:flutter/material.dart';

import '../style/text_style.dart';

Widget inputCheckBox(
    String text, bool checkBoxValue, void Function(bool?)? changedFunc) {
  return Container(
    margin: const EdgeInsets.fromLTRB(13, 4, 13, 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(value: checkBoxValue, onChanged: changedFunc),
        Text(
          text,
          style: checkTextStyle,
        ),
      ],
    ),
  );
}
