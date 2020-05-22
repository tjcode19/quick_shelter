import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/widgets/tapableText.dart';
//import 'package:camera/camera.dart';

import '../constants.dart';
import '../widgets/raised_button.dart';

class IdentityCard extends StatefulWidget {
  @override
  _IdentityCardState createState() => _IdentityCardState();
}

class _IdentityCardState extends State<IdentityCard> {
  bool _viewMore = false;
  // Function _nextView() {
  //   Navigator.pushNamedAndRemoveUntil(
  //       context, regCompletedRoute, (route) => false);
  // }

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
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              tapableText('I’ll do this later. Skip', () {
                                print("object");
                                Navigator.pushNamed(context, regCompletedRoute);
                              }),
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
                      const SizedBox(height: 30),
                      RaisedButtonWidget(
                          regCompletedRoute, 'Complete Registraton', true),
                      const SizedBox(height: 20),
                      InkWell(
                        splashColor: Colors.orange,
                        highlightColor: Colors.orange[100],
                        onTap: () {
                          setState(() {
                            _viewMore = !_viewMore;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
                          decoration: BoxDecoration(
                              color: appPrimary,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10)),
                              border: Border.all(color: appTextColorPrimary2)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Why we need your ID?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  Text(
                                    'view >',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  )
                                ],
                              ),
                              Visibility(
                                visible: _viewMore,
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                        color: Colors.white38, thickness: 1.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'We use your ID to makesure your details are genuine and not someone else',
                                            softWrap: true,
                                            style: TextStyle(
                                                color: appTextColorPrimary2),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 12, 0, 4),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.check,
                                            color: appTextColorPrimary2,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'We use it to secure your account',
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: appTextColorPrimary2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 1),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.check,
                                            color: appTextColorPrimary2,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'For trust and transparency',
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: appTextColorPrimary2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
