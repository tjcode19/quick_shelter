import 'package:flutter/material.dart';

import 'constants.dart';
import 'widgets/input_field.dart';
import 'widgets/raised_button.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                            'Sign Up',
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          )),
                      const SizedBox(height: 20),
                      Container(
                        child: Text(
                          'Please provide correct email address and password to login.',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(height: 40),
                      InputFieldWidget('Firstname'),
                      const SizedBox(height: 10),
                      InputFieldWidget('Lastname'),
                      const SizedBox(height: 10),
                      InputFieldWidget('ex. email@email.com'),
                      const SizedBox(height: 10),
                      InputFieldWidget('Phone Number'),
                      const SizedBox(height: 10),
                      InputFieldWidget('Password'),
                      
                      const SizedBox(height: 20),
                      RaisedButtonWidget(loginRoute, 'Continue', true),
                      const SizedBox(height: 25),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Already a member? Log in',
                          style: Theme.of(context).textTheme.bodyText1,
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