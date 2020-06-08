import 'package:flutter/material.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';

import '../constants.dart';
import '../widgets/input_field.dart';
import '../widgets/raised_button.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

 void  _signUpFunc(){
    print('Sign Up Funtion');
    final userFirstName = _firstNameController.text;
    final userLastName = _lastNameController.text;
    final userEmail = _emailController.text;
    final userPhone = _phoneController.text;
    final userPassword = _passwordController.text;

    if (userEmail.isEmpty || userPassword.isEmpty) {
      snackBar('Email and Password must be filled', _scaffoldKey);
      return;
    }
    showLoadingDialog(context, _keyLoader);

    var _signUp = repo.signUpData(userFirstName, userLastName, userPhone, userEmail, userPassword);

    _signUp.then((value) {
      print(value.message);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.accessToken != null) {        
        Navigator.pushNamed(context, verifyPhoneRoute);
      } else {
        snackBar('Registration Failed \t ${value.message}', _scaffoldKey);
      }
      //snackBar(value.message, _scaffoldKey);
    });

  }
  Future<bool> _onBackPressed() {
    return Navigator.popAndPushNamed(context, getStartedRoute);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: Scaffold(
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
                            margin: EdgeInsets.only(top: 30),
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
                        InputFieldWidget('Firstname', TextInputType.text, false, controller: _firstNameController,),
                        const SizedBox(height: 20),
                        InputFieldWidget('Lastname', TextInputType.text, false, controller: _lastNameController,),
                        const SizedBox(height: 20),
                        InputFieldWidget('ex. email@email.com', TextInputType.emailAddress, false, controller: _emailController,capitalizationType: TextCapitalization.none,),
                        const SizedBox(height: 20),
                        InputFieldWidget('Phone Number', TextInputType.phone, false, controller: _phoneController,),
                        const SizedBox(height: 20),
                        InputFieldWidget('Password', TextInputType.text, true, controller: _passwordController,),
                        
                        const SizedBox(height: 30),
                        RaisedButtonWidget(verifyPhoneRoute, 'Continue', true),
                        const SizedBox(height: 25),
                        GestureDetector(
                          onTap: (){
                           // Navigator.pushNamed(context, loginRoute);
                            Navigator.popAndPushNamed(context, loginRoute);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: 'Already a member? ',
                                style: TextStyle(fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Log in',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}