import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/input_field.dart';
import '../widgets/raised_button.dart';

class VerifyPhone extends StatefulWidget {
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 60),
                          child: Text(
                            'Verify Phone Number',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          )),
                      const SizedBox(height: 20),
                      Container(
                        child: Text(
                          'We sent a code to verify your phone number.',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        child: Text(
                          '+2348 000 000 0000',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(height: 80),
                      InputFieldWidget('Firstname'),
                      const SizedBox(height: 40),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Didn’t receive OTP?',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            text: 'Resend | ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.call, size: 14, color: Colors.white,),
                              ),
                              TextSpan(text: ' Call me'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 70),
                      RaisedButtonWidget(identityCardRoute, 'Continue', true),
                      const SizedBox(height: 35),
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
