import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget CustomDropdownButton(
    {required List<String> itemList,
      required String label,
      required ValueChanged onChanged,
      required String selectedItem}) {
  return Container(
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0xff5f66f2),
          width: 1.0,
        ),
      ),
    ),
    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),

    width: double.infinity,
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
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Color(0xffeeeeee),
          ),
          child: DropdownButtonFormField<String>(
            value: selectedItem,
            isExpanded: true,
            decoration: InputDecoration(

              border: InputBorder.none,
            ),
            validator: (value) {
              if(value!.isEmpty || value == '선택'){
                return '선택해주세요.';
              }else {
                return null;
              }
            },
            elevation: 16,
            icon: const Visibility(
                visible: false, child: Icon(Icons.arrow_downward)),
            style: selectedItem == "선택"
                ? const TextStyle(
              color: Color(0xffbdbdbd),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            )
                : const TextStyle(
              color: Color(0xff333333),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'S-CoreDream-4',
            ),

            onChanged: onChanged,
            items:itemList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  );
}