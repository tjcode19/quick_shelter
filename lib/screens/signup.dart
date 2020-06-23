import 'package:flutter/material.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
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
  final _formKey = GlobalKey<FormState>();
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String password;

  void _signUpFunc() {
    print('Sign Up Funtion');
    final userFirstName = _firstNameController.text;
    final userLastName = _lastNameController.text;
    final userEmail = _emailController.text;
    final userPhone = _phoneController.text;
    final userPassword = _passwordController.text;
    final confirmPassword = _passwordController.text;

    if (userEmail.isEmpty || userPassword.isEmpty) {
      snackBar('All fields must be filled', _scaffoldKey);
      return;
    }
    showLoadingDialog(context, _keyLoader);

    var _signUp = repo.signUpData(
        userFirstName, userLastName, userPhone, userEmail, userPassword);

        _sharedPreferenceQS.setData('String', 'surName', userLastName);

    _signUp.then((value) {
      print(value.message);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.code =='200') {
        _sharedPreferenceQS.setData('String', 'accessToken', value.accessToken);
        _getUserProfile();
        Navigator.pushNamed(context, verifyPhoneRoute);
      } else {
        snackBar('Registration Failed \n ${value.message}', _scaffoldKey);
      }
      //snackBar(value.message, _scaffoldKey);
    });
  }

  _setValue(String _passVal){
    setState(() {

      password = _passVal;
      
    });
  }

    _getUserProfile() {
    print('Get User Profile');
    var _apiCall = repo.getProfile();

    _apiCall.then((value) {
      print(value);
      // if(value.code != '200'){
      //   _sharedPreferenceQS.setData(bool, 'detailsLoaded', false);
      // }
      // else{
        //setState(() {
        _sharedPreferenceQS.setData('String', 'userFN', value.firstName);
        _sharedPreferenceQS.setData('String', 'userLN', value.surName);
        _sharedPreferenceQS.setData('String', 'userPN', value.phoneNumber);
        _sharedPreferenceQS.setData('String', 'userEm', value.email);
        _sharedPreferenceQS.setData('bool', 'detailsLoaded', true);

     // });

     // }
      
    });

  }

  Future<bool> _onBackPressed() {
    return Navigator.popAndPushNamed(context, getStartedRoute);
  }

  void dispose() {
    _firstNameController.dispose();
    super.dispose();
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
                    child: Form(
                      autovalidate: true,
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              )),
                          const SizedBox(height: 20),
                          Container(
                            child: Text(
                              'Can we know you?',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          const SizedBox(height: 40),
                          InputFieldWidget(
                            'Firstname',
                            TextInputType.text,
                            false,
                            controller: _firstNameController,
                            errorMsg: 'First name can not be empty',
                          ),
                          const SizedBox(height: 20),
                          InputFieldWidget(
                            'Lastname',
                            TextInputType.text,
                            false,
                            controller: _lastNameController,
                            errorMsg: 'Last name can not be empty',
                          ),
                          const SizedBox(height: 20),
                          InputFieldWidget(
                            'ex. email@email.com',
                            TextInputType.emailAddress,
                            false,
                            controller: _emailController,
                            capitalizationType: TextCapitalization.none,
                            errorMsg: 'Email can not be empty',
                          ),
                          const SizedBox(height: 20),
                          InputFieldWidget(
                            'Phone Number',
                            TextInputType.phone,
                            false,
                            controller: _phoneController,
                            errorMsg: 'Phone number can not be empty',
                          ),
                          const SizedBox(height: 20),
                          InputFieldWidget(
                            'Password',
                            TextInputType.text,
                            true,
                            controller: _passwordController,
                            capitalizationType: TextCapitalization.none,
                            errorMsg: 'Password can not be empty',
                            onChange: (content){
                              setState(() {
                                password = content;
                              });
                              }
                          ),
                          const SizedBox(height: 20),
                          InputFieldWidget(
                            'Confirm Password',
                            TextInputType.text,
                            true,
                            controller: _confirmPasswordController,
                            capitalizationType: TextCapitalization.none,
                            errorMsg: 'Password does not match',
                            cPassword: password,
                          ),
                          const SizedBox(height: 30),
                          RaisedButtonWidget(
                              verifyPhoneRoute, 'Continue', true, isValidatable: true, formKey: _formKey, action: _signUpFunc,),
                          const SizedBox(height: 25),
                          GestureDetector(
                            onTap: () {
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
