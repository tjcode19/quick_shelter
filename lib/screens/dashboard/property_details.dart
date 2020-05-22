import 'package:flutter/material.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../colors.dart';
import '../../constants.dart';

class PropertyDetails extends StatefulWidget {
  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/welcome.png"),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 135, 10, 10),
                  child: IconButton(
                    color: Theme.of(context).primaryColor,
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(129, 92, 67, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            'Studio Apartment, Fully Furnished',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          )),
                      const SizedBox(height: 20),
                      Container(
                        child: Text(
                          'N55,000,000',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                       const SizedBox(height: 120),
                      Container(
                        child: Text(
                          'Property Details',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                       Divider(color: Colors.white38, thickness: 1.0),
                      _rowCont('Location', 'Lagos State', Icons.check),
                      Divider(color: Colors.white38, thickness: 1.0),
                      _rowCont('State', 'Lagos State', Icons.check),
                      Divider(color: Colors.white38, thickness: 1.0),
                      _rowCont('Land Area', '77km', Icons.check),
                      Divider(color: Colors.white54, thickness: 1.0),
                      _rowCont('Available Date', '20 May, 2020', Icons.check),
                      const SizedBox(height: 20),
                      RaisedButtonWidget(dashboardRoute, 'Buy Property', true),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  _rowCont(String title, String subTitle, iconNew) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row( children: [
            Icon(
              iconNew,
              color: appTextColorPrimary2,
            ),
            Text(
              title,
              style: TextStyle(color: appTextColorPrimary2),
            ),
          ]),
          Text(
            subTitle,
            style: TextStyle(color: appTextColorPrimary2),
          ),
        ],
      ),
    );
  }
}
