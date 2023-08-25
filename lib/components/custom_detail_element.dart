import 'package:flutter/material.dart';

Widget projectDetailElement(String label, String data) {

  return Container(
    margin: const EdgeInsets.all(10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Text(data),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        )
      ],
    ),
  );
}