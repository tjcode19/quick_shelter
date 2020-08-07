import 'package:flutter/material.dart';
import '../widgets/commonUtils.dart';
import '../constants.dart';
import '../pin_entry_text_field.dart';
import '../repository/quick_shelter_repo.dart';
import '../widgets/raised_button.dart';

class VerifyPhone extends StatefulWidget {
  @override
  _VerifyPhoneState createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {

  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _validatePhone(String phoneNum, String code){
    print('get pin');
    showLoadingDialog(context, _keyLoader);

    var _validatePh = repo.validatePhone(phoneNum, code);

    _validatePh.then((value) {
      print(value.message);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      // if (value == null) {        
      //   Navigator.pushNamed(context, dashboardRoute);
      // } else {
      //   //showInSnackBar(value);
      // }
      snackBar(value.message, _scaffoldKey);
    });

  }

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
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
                  //height: screeSize.height - 100,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(129, 92, 67, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            'Verify Phone Number',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
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
                          style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 80),
                      PinEntryTextField(
                        showFieldAsBox: false,
                        fields: 6,                        
                        onSubmit: (String pin) {
                          _validatePhone('07036443808', pin);
                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return AlertDialog(
                          //         title: Text("Pin"),
                          //         content: Text('Pin entered is $pin'),
                          //       );
                          //     }); //end showDialog()
                        }, // end onSubmit
                      ),
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
                            text: 'Resend  | ',
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.0),
                            children: [
                              WidgetSpan(
                                child: Icon(
                                  Icons.call,
                                  size: 15,
                                  color: Colors.white,
                                ),
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
