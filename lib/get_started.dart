import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quick_shelter/constants.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  Future<bool> _onBackPressed() {
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/welcome.png"),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Text(
                'Get Started',
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
              RaisedButtonWidget(loginRoute, 'Log In', Colors.white,
                  Theme.of(context).primaryColor),
              const SizedBox(height: 20),
              RaisedButtonWidget(
                signUpRoute,
                'Sign Up',
                Theme.of(context).primaryColor,
                Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
