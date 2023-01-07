import 'package:flutter/material.dart';
Widget customImageButton(AssetImage img, GestureTapCallback onTap, double size) {
  return GestureDetector(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          image: DecorationImage(image: img, fit: BoxFit.cover),
        ),
      ),
      onTap: onTap);
}