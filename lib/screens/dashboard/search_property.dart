import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/input_field_multi_line.dart';
import 'package:quick_shelter/widgets/input_label.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../constants.dart';

class SearchProp extends StatefulWidget {
  @override
  _SearchPropState createState() => _SearchPropState();
}

class _SearchPropState extends State<SearchProp> {
  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;

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
              Stack(
                children: <Widget>[
                  Container(
                    height: 70,
                  ),
                  Positioned(
                    right: 0.0,
                    top: 0,
                    child: Container(
                      width: screeSize.width / 2,
                      child: OutlineButton(
                        padding: EdgeInsets.all(11),
                        color: Colors.white,
                        highlightedBorderColor: Colors.white,
                        borderSide: BorderSide(color: appTextColorPrimary2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15))),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 3, 4, 4),
                          child: Text(
                            'For Rent',
                            style: TextStyle(color: appTextColorPrimary2, fontSize: 13),
                          ),
                        ),
                        onPressed: () {
                          //showSnackBar("OutlineButton with Shape");
                        },
                      ),
                    ),
                  ),
                  Container(
                      width: screeSize.width / 2,
                      child:
                          RaisedButtonWidget('routeName', 'For Sale', false)),
                ],
              ),
              //RaisedButtonWidget('routeName','For Sale', false),

              const SizedBox(height: 10),
              inputlabel('Price Range', Icons.local_offer),
              const SizedBox(height: 8),
              InputFieldWidget(
                  '100,000 - 300,000', TextInputType.number, false),
              const SizedBox(height: 20),
              inputlabel('Bedrooms', Icons.hotel),
              const SizedBox(height: 8),
              InputFieldWidget('2', TextInputType.number, false),
              const SizedBox(height: 20),
              inputlabel('Location', Icons.location_on),
              const SizedBox(height: 8),
              InputFieldWidget('ex. Lekki Phase 1', TextInputType.text, false),
              const SizedBox(height: 20),
              inputlabel('Building Type', Icons.home),
              const SizedBox(height: 8),
              InputFieldWidget(
                  'Fully Detached Duplex', TextInputType.text, false),
              const SizedBox(height: 40),
              RaisedButtonWidget(dashboardRoute, 'Search', true),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
