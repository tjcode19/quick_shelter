import 'package:flutter/material.dart';
import 'package:quick_shelter/models/LoginResponse.dart';
import 'package:quick_shelter/repository/login_repo.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';
import '../constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberMe = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  //Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Future<bool> saveData(nameKey, value) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return await preferences.setString(nameKey, value);
  // }

  //  Future<String> loadData(nameKey) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String name_str =  preferences.getString(nameKey);

  //   setState(() {
  //     _emailController.text=name_str;
  //   });
  // }

  _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String n = prefs.getString('Email');

    _emailController.text = n;
  }

  //Incrementing counter after click
  _setData()  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Email', _emailController.text);
  }

  void _submitData() {
    print('loginRes');

    final userEmail = _emailController.text;
    final userPassword = _passwordController.text;

    if (userEmail.isEmpty || userPassword.isEmpty) {
     // _showSnackBar('Problem Login In');
      return;
    }

    if (rememberMe) {
      //  saveData('Email', userEmail);
      //  saveData('Password', userPassword);
      _setData();
      _loadData();
    }

    showLoadingDialog(context, _keyLoader);
    var _loginRes = repo.loginData(userEmail.trim(), userPassword);

    _loginRes.then((value) {
      print('donnned ${value.auth}');
      if (value.auth) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        Navigator.pushNamed(context, dashboardRoute);
      } else {
        _showSnackBar('Problem Login In');
      }
    });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

    print(_loginRes);
    print('######');
    //print(loginRes.auth);

    //Navigator.of(context).pop();
  }

  void _showSnackBar(String text) {
    final snackBar = SnackBar(content: Text(text));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() {
      Navigator.popAndPushNamed(context, getStartedRoute);
    }

    final screeSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                    height: screeSize.height - 80,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(129, 92, 67, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 60),
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(height: 20),
                        Container(
                          child: Text(
                            'Please provide correct email address and password to login.',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        const SizedBox(height: 60),
                        InputFieldWidget(
                          'Enter email',
                          TextInputType.emailAddress,
                          false,
                          capitalizationType: TextCapitalization.none,
                          controller: _emailController,
                        ),
                        const SizedBox(height: 20),
                        InputFieldWidget(
                          'Enter password',
                          TextInputType.text,
                          true,
                          capitalizationType: TextCapitalization.none,
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 24.0,
                                  height: 24.0,
                                  child: Theme(
                                    data: ThemeData(
                                        unselectedWidgetColor: Colors.white,
                                        selectedRowColor: Colors.amber),
                                    child: Checkbox(
                                      value: rememberMe,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      onChanged: (bool value) {
                                        setState(() {
                                          rememberMe = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Remember Me',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            Text(
                              'Forgot Password',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        RaisedButtonWidget(
                          dashboardRoute,
                          'Log In',
                          true,
                          action: _submitData,
                        ),
                        const SizedBox(height: 80),
                        GestureDetector(
                          onTap: () {
                            //Navigator.pushNamed(context, signUpRoute);
                            Navigator.popAndPushNamed(context, signUpRoute);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: 'Don’t have an account? ',
                                style: TextStyle(fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Register',
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
                        const SizedBox(height: 10),
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

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: appPrimary,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.white),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
