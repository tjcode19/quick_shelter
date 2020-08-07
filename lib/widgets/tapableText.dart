import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';

Widget tapableText(String text, Function onTap, {color: appTextColorPrimary2}) {
  return GestureDetector(
    onTap: onTap,
    child: Text(text, style: TextStyle(color: color, fontSize: 14.0),),
  );
}