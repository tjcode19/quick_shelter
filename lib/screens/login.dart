import 'package:flutter/material.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(129, 92, 67, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 60),
                          child: Text(
                            'Welcome Back',
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          )),
                      const SizedBox(height: 20),
                      Container(
                        child: Text(
                          'Please provide correct email address and password to login.',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(height: 60),
                      InputFieldWidget('Enter email'),
                      const SizedBox(height: 20),
                      InputFieldWidget('Enter password'),
                      const SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Text(
                            'Forgot Password',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      RaisedButtonWidget(dashboardRoute, 'Log In', true),
                      const SizedBox(height: 80),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Don’t have an account? Register',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(height: 10),
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
