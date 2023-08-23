import 'package:connec/style/text_style.dart';
import 'package:flutter/material.dart';

Widget loginEditTextForm(
    {required String label,
    bool isSecret = false,
    required String hint,
    required FormFieldSetter onSaved,
    FormFieldValidator? validate}) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: inputLabelStyle),
        SizedBox(height: 10),
        TextFormField(
          validator: validate ?? (value) => null,
          obscureText: isSecret,
          decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff5f66f2), width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff5f66f2), width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff5f66f2), width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff5f66f2), width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            hintText: hint,
            hintStyle: inputHintStyle,
          ),
          onSaved: onSaved,
        ),
      ],
    ),
  );
}

Widget inputEditTextForm(
    {required String label,
    int lineNum = 1,
    bool isSecret = false,
    controller,
    required String hint,
    required FormFieldSetter onSaved,
    required TextInputType type,
    FormFieldValidator? validate}) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: inputLabelStyle),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: type,
          maxLines: lineNum,
          obscureText: isSecret,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: inputHintStyle,
              filled: true,
              fillColor: Color(0xffeeeeee),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xff5f66f2)))),
          onSaved: onSaved,
          validator: validate ??
              (value) {
                if (value!.isEmpty) {
                  return "빈 칸입니다.";
                } else {
                  return null;
                }
              },
        ),
      ],
    ),
  );
}

Widget customKeywordTextForm(
    {required String label,
    required String hint,
    required onChanged,
    required TextInputType type,
    required TextEditingController textController,
    int lineNum = 1,
    bool isSecret = false,
    FormFieldValidator? validate}) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: inputLabelStyle),
            Text(
              "   ※ 최대 5개",
              style: inputConstraintStyle,
            )
          ],
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: textController,
          keyboardType: type,
          maxLines: lineNum,
          obscureText: isSecret,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: inputHintStyle,
              filled: true,
              fillColor: Color(0xffeeeeee),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xff5f66f2)))),
          onChanged: onChanged,
        ),
      ],
    ),
  );
}
