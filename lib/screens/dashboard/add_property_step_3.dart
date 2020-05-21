import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/input_field_multi_line.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../constants.dart';

class AddPropStep3 extends StatefulWidget {
  @override
  _AddPropStep3State createState() => _AddPropStep3State();
}

class _AddPropStep3State extends State<AddPropStep3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appSecondaryColor,
      appBar: AppBar(
        backgroundColor: appSecondaryColor,
        elevation: 0.0,
        leading: IconButton(
          color: Colors.white,
          iconSize: 30.0,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Upload Documents (Optional)',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Step 3 of 3',
                  style: TextStyle(color: Colors.white70, fontSize: 14.0),
                  textAlign: TextAlign.center,
                )
              ]),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        'Legal Required Documents',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Divider(color: Colors.white38, thickness: 1.0),
              _rowCont('Certificate of occupancy', 'Approved', Icons.check),
              Divider(color: Colors.white38, thickness: 1.0),
              _rowCont('Deed of assignment', 'Approved', Icons.check),
              Divider(color: Colors.white54, thickness: 1.0),
              _rowCont('Deed of lease', 'Approved', Icons.check),
              Divider(color: Colors.white54, thickness: 1.0),
              _rowCont('Deed of Sublease', 'Approved', Icons.check),
              Divider(color: Colors.white54, thickness: 1.0),
              _rowCont('Land Certificate', 'Approved', Icons.check),
              Divider(color: Colors.white54, thickness: 1.0),
              _rowCont('Deed of Mortgate', 'Approved', Icons.check),
              Divider(color: Colors.white54, thickness: 1.0),
              _rowCont('Survey Plan', 'Approved', Icons.check),
              Divider(color: Colors.white54, thickness: 1.0),
              const SizedBox(height: 40),
              RaisedButtonWidget(dashboardRoute, 'Continue', true),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _rowCont(String title, String subTitle, iconNew) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              title,
              style: TextStyle(color: appTextColorPrimary2),
            ),
            Text(
              subTitle,
              style: TextStyle(color: appTextColorPrimary2),
            ),
          ]),
          Icon(
            iconNew,
            color: appTextColorPrimary2,
          )
        ],
      ),
    );
  }
}
