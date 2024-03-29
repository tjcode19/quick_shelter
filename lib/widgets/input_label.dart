import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

Widget inputlabel(String label, icon, {color: Colors.white}){
  return Row(
                children: [
                  Icon(icon ,color: appColorSecondary, size: 16,),
                  SizedBox(width: 5.0),
                    Container(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 15,
                          color: color,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                ],
              );
}