import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
//import 'package:camera/camera.dart';

import '../constants.dart';
import '../widgets/raised_button.dart';

class IdentityCard extends StatefulWidget {
  @override
  _IdentityCardState createState() => _IdentityCardState();
}


class _IdentityCardState extends State<IdentityCard> {
 

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
                  margin: EdgeInsets.fromLTRB(0, 35, 10, 10),
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
                  height: screeSize.height - 100,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(129, 92, 67, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Identity Card',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              Text(
                                'I’ll do this later. Skip',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            ],
                          )),
                      const SizedBox(height: 20),
                      Container(
                        child: Text(
                          'Please provide a means of identification to complete registration.',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        height: 150.0,
                        width: double.infinity,
                        //color: appPrimary,
                        decoration: BoxDecoration(
                          color: appPrimary,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: appTextColorPrimary2)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.camera_alt, color: Colors.white,),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
                                child: Text(
                                  'Upload valid ID Image',
                                  style: TextStyle(color: appTextColorPrimary2),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                                child: Text(
                                  '(Intl. passport, NIN, drivers license, voters card)',
                                  style: TextStyle(color: appTextColorPrimary2),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      RaisedButtonWidget(
                          regCompletedRoute, 'Complete Registraton', true),
                      const SizedBox(height: 20),
                      RaisedButtonWidget(
                          regCompletedRoute, 'Why we need your ID?', false),
                      const SizedBox(height: 5),
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
}
