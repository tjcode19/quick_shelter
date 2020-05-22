import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';

Widget tapableText(String text, Function onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Text(text, style: TextStyle(color: appTextColorPrimary2, fontSize: 14.0),),
  );
}