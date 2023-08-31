import 'package:connec/style/divider_style.dart';
import 'package:flutter/material.dart';

Widget projectDetailElement(String label, String data) {

  return Container(
    margin: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Text(data),
       greyDivider,
      ],
    ),
  );
}