import 'package:flutter/material.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import '../repository/quick_shelter_repo.dart';
import '../widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';
import '../constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int pageStep = 0;

  
  void _submitData() async {
    print('forgotPassword');
    FocusScope.of(context).requestFocus(new FocusNode());

    final userEmail = _emailController.text;

    if (userEmail.isEmpty ) {
      snackBar('Email must be filled', _scaffoldKey);
      return;
    }


    //showLoadingDialog(context, _keyLoader);

    // var _apiCall = repo.forgotPassword(userEmail.trim());

    // await _apiCall.then((value) async {
    //   print('donnned ${value.auth}');
    //   Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    //   if (value.code == '200' && value.auth == true) {
    //     Navigator.pushNamed(context, dashboardRoute);
    //   } else {
    //     showInSnackBar(value.message);
    //   }
    // }, onError: (error) {
    //   Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    //   showInSnackBar("Login Failed");
    // });
    print('######');

    setState(() {
      pageStep+=1;
    });
  }



  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: Colors.red,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      return Navigator.popAndPushNamed(context, getStartedRoute);
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/welcome.png"),
                    fit: BoxFit.cover)),
          ),
          Positioned(
            child: Container(
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
          ),
          (pageStep ==1)?_enterCode():
          (pageStep == 2)?_changePassword():_sendCode(),
        ]),
      ),
    );
  }

  Widget _sendCode() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Container(
            // height: screeSize.height - 80,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(129, 92, 67, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 20),
                Container(
                  child: Text(
                    'Enter your registered email address to reset your password',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 40),
                InputFieldWidget(
                  'Enter email',
                  TextInputType.emailAddress,
                  false,
                  capitalizationType: TextCapitalization.none,
                  controller: _emailController,
                ),
                
                const SizedBox(height: 20),
                RaisedButtonWidget(
                  dashboardRoute,
                  'Send Code',
                  true,
                  action: _submitData,
                ),                
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      );

      Widget _enterCode() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Container(
            // height: screeSize.height - 80,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(129, 92, 67, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 20),
                Container(
                  child: Text(
                    'Enter the code sent to your registered email',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 40),
                InputFieldWidget(
                  'Enter Code',
                  TextInputType.number,
                  false,
                  capitalizationType: TextCapitalization.none,
                  controller: _codeController,
                ),
                
                const SizedBox(height: 20),
                RaisedButtonWidget(
                  dashboardRoute,
                  'Validate Code',
                  true,
                  action: _submitData,
                ),                
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      );

      Widget _changePassword() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          Container(
            // height: screeSize.height - 80,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color.fromRGBO(129, 92, 67, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 40),
                    child: Text(
                      'Reset Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(height: 20),
                Container(
                  child: Text(
                    'Enter your registered email address to reset your password',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 40),
                InputFieldWidget(
                  'Enter New Password',
                  TextInputType.text,
                  true,
                  capitalizationType: TextCapitalization.none,
                  controller: _passwordController,
                ),
                InputFieldWidget(
                  'Confirm Password',
                  TextInputType.text,
                  true,
                  capitalizationType: TextCapitalization.none,
                  controller: _confirmPassController,
                ),
                
                const SizedBox(height: 20),
                RaisedButtonWidget(
                  dashboardRoute,
                  'Create New Password',
                  true,
                  action: _submitData,
                ),                
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      );
}
