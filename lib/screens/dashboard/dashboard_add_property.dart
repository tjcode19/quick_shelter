import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/input_field_multi_line.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../constants.dart';

class DashboardAddProp extends StatefulWidget {
  @override
  _DashboardAddPropState createState() => _DashboardAddPropState();
}

class _DashboardAddPropState extends State<DashboardAddProp> {
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
          icon: Icon(Icons.close),
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
                  'Add Property',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Step 1 of 3',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  textAlign: TextAlign.center,
                )
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        'Choose Property Category',
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
              RaisedButtonWidget('routeName',' btnLabel', false),
              const SizedBox(height: 20),
              Row(
                children: [
                    Container(
                      child: Text(
                        'Selling Price',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              InputFieldWidget('Selling Price', TextInputType.number, false),
              const SizedBox(height: 20),
              Row(
                children: [
                    Container(
                      child: Text(
                        'Property Type',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              InputFieldMultiLineWidget('Property Description', 3),
              const SizedBox(height: 20),
              Row(
                children: [
                    Container(
                      child: Text(
                        'Property State & Location',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              InputFieldWidget('State', TextInputType.text, false),
              const SizedBox(height: 20),
              Row(
                children: [
                    Container(
                      child: Text(
                        'Land Area',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              InputFieldWidget('ex. 77 km2', TextInputType.text, false),
              const SizedBox(height: 20),
              Row(
                children: [
                    Container(
                      child: Text(
                        'Available Date',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              InputFieldWidget('30 May, 2020', TextInputType.text, false),
              const SizedBox(height: 40),
              RaisedButtonWidget(dashboardRoute, 'Continue', true),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
