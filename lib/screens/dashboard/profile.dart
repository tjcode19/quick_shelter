import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_shelter/constants.dart';

import '../../colors.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Container(
          padding: EdgeInsets.all(8),
          child: ClipOval(
            child: Material(
              color: appTextColorPrimary2, // button color
              child: InkWell(
                splashColor: Colors.orange[100], // inkwell color
                child: Image.asset(
                  'assets/images/person.png',
                  color: appSecondaryColor,
                  height: 24.0,
                  width: 24.0,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        title: RichText(
          text: TextSpan(
            text: 'Hi, ',
            style: TextStyle(fontSize: 16, color: appTextColorPrimary),
            children: <TextSpan>[
              TextSpan(
                text: 'Tolulope',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, personalInfoRoute);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
                margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10)),
                    border: Border.all(color: appTextColorPrimary2)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: appTextColorPrimary,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Personal Information',
                              style: TextStyle(
                                  color: appTextColorPrimary, fontSize: 15),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_drop_down_circle,
                          color: appTextColorPrimary2,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
               // Navigator.pushNamed(context, personalInfoRoute);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10)),
                    border: Border.all(color: appTextColorPrimary2)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.ac_unit,
                              color: appTextColorPrimary,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Identification',
                              style: TextStyle(
                                  color: appTextColorPrimary, fontSize: 15),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_drop_down_circle,
                          color: appTextColorPrimary2,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
