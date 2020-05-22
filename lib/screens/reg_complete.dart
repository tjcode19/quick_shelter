import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/raised_button.dart';

class RegCompleted extends StatefulWidget {
  @override
  _RegCompletedState createState() => _RegCompletedState();
}

class _RegCompletedState extends State<RegCompleted> {
  Future<bool> _onBackPressed() {
    return Navigator.pushNamedAndRemoveUntil(context, getStartedRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(129, 92, 67, 1),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/images/welcome.png', height: 300, width: MediaQuery.of(context).size.width,),
                    const SizedBox(height: 40),
                    RichText(
                      text: TextSpan(
                        text: 'Welcome ',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        children: [
                          TextSpan(text: 'Tolulope'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: Text(
                        'We hope you find homes, apartment rentals and real estate listings.',
                        style: TextStyle(color: Color.fromRGBO(226, 208, 195, 1), fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
             RaisedButtonWidget(
                          dashboardRoute, 'Continue', true),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
