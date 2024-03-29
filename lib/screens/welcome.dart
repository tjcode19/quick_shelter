import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quick_shelter/screens/get_started.dart';

class WelcomePage extends StatelessWidget {
  Future<bool> _onBackPressed() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/welcome1.png"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: Column(              
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text('Welcome to',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
                const SizedBox(height: 20),
                Container(
                    child: Text(
                  'Quick Shelter',
                  style: TextStyle(color: Colors.white, fontSize: 40.0),
                )),
                const SizedBox(height: 20),
                Container(
                  child: Text(
                    'Now you can Buy, Rent and Sell properties from your mobile phone as quickly as possible.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    padding: EdgeInsets.all(12),
                    highlightElevation: 5.0,
                    elevation: 3.0,
                    splashColor: Colors.orange[50],
                    highlightColor: Colors.orange[100],
                    color: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        //borderRadius: new BorderRadius.circular(10.0),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(20))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                          child: Text(
                            'Get Started',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 25,
                          ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).push(_createRoute());
                      //Navigator.pushNamed(context, getStartedRoute);
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => GetStarted(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
}
