import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../constants.dart';

class AddPropStep2 extends StatefulWidget {
  @override
  _AddPropStep2State createState() => _AddPropStep2State();
}

class _AddPropStep2State extends State<AddPropStep2> {
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
                  'Add Property Images',
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Step 2 of 3',
                  style: TextStyle(color: Colors.white70, fontSize: 14.0),
                  textAlign: TextAlign.center,
                )
              ]),
              
              const SizedBox(height: 20),
              Container(
                height: 150.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    border: Border.all(color: appTextColorPrimary2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 150.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    border: Border.all(color: appTextColorPrimary2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 150.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    border: Border.all(color: appTextColorPrimary2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              RaisedButtonWidget(addPropertyStep3Route, 'Continue', true),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
