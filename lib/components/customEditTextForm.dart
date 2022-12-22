import 'package:flutter/material.dart';
Widget customEditTextForm(
    {required String label,
      required String hint,
      bool isSecret = false,
      required FormFieldSetter onSaved}) {
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