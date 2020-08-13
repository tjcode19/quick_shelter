import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quick_shelter/screens/get_started.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _versionName = 'v1.0';
  final splashDelay = 3;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => GetStarted()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                ),
                Text(
                  'Quick Shelter',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(189, 167, 152, 1)),
                ),
              ],
            ),
          ],
        ),
      ),

      // Expanded(
      //   child: Column(
      //     children: <Widget>[
      //       CircularProgressIndicator(),
      //       Container(
      //         height: 10,
      //       ),
      //       Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceAround,
      //           children: <Widget>[
      //             Spacer(),
      //             Text(_versionName),
      //             Spacer(
      //               flex: 4,
      //             ),
      //             Spacer(),
      //           ])
      //     ],
      //   ),
      // ),
    );
  }
}
