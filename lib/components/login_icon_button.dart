import 'package:flutter/material.dart';
Widget customImageButton(AssetImage img, GestureTapCallback onTap) {
  return GestureDetector(
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          image: DecorationImage(image: img, fit: BoxFit.cover),
        ),
      ),
      onTap: onTap);
}