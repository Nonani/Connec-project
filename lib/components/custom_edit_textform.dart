import 'package:flutter/material.dart';

Widget LoginEditTextForm(
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
        Text("${label}",
            style: TextStyle(
              fontFamily: "EchoDream",
              fontWeight: FontWeight.w600,
              fontSize: 16,
            )),
        SizedBox(height: 10),
        TextFormField(
          validator: validate != null
              ? validate
              : (value) {
                  return null;
                },
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
            hintText: "${hint}",
            hintStyle: TextStyle(
                color: Color(0xffbdbdbd),
                fontSize: 15,
                fontFamily: "EchoDream",
                fontWeight: FontWeight.w400),
          ),
          onSaved: onSaved,
        ),
      ],
    ),
  );
}

Widget SignUpEditTextForm(
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
        Text("${label}",
            style: TextStyle(
              fontFamily: "EchoDream",
              fontWeight: FontWeight.w600,
              fontSize: 17,
            )),
        SizedBox(height: 10),
        TextFormField(
          maxLines: label == "소개" || label == "제안 내용" ? 5 : 1,
          obscureText: isSecret,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Color(0xffbdbdbd),
                fontSize: 16,
                fontFamily: 'EchoDream',
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: Color(0xffeeeeee),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xff5f66f2)))),
          onSaved: onSaved,
          validator: validate != null
              ? validate
              : (value) {
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
