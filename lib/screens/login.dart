import 'package:flutter/material.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import '../repository/quick_shelter_repo.dart';
import '../widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';
import '../constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rememberMe = false;
  String _prefEmail;

  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Future<Null> getSharedPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _prefEmail = prefs.getString("Email");
  //   bool rem = (prefs.getBool('rememberMe') == null)
  //       ? false
  //       : prefs.getBool('rememberMe');
  //   print(rem);

  //   setState(() {
  //     _emailController.text = _prefEmail;
  //     rememberMe = rem;
  //   });
  // }

  getLoginPref() async {
    _prefEmail = await _sharedPreferenceQS.getSharedPrefs(String, 'Email');
    bool _rem = await _sharedPreferenceQS.getSharedPrefs(bool, 'rememberMe');
    bool rem = (_rem == null) ? false : _rem;

    setState(() {
      _emailController.text = _prefEmail;
      rememberMe = rem;
    });
  }

  _setLoginPref(bool clearValues) async {
    if (!clearValues) {
      _sharedPreferenceQS.setData('bool', 'rememberMe', rememberMe);
      _sharedPreferenceQS.setData('String', 'Email', _emailController.text);
    } else {
      _sharedPreferenceQS.setData('bool', 'rememberMe', rememberMe);
      _sharedPreferenceQS.setData('String', 'Email', '');
    }
  }

  @override
  void initState() {
    super.initState();
    _prefEmail = "";
    getLoginPref();
  }

  void _submitData() async {
    print('loginRes');
    FocusScope.of(context).requestFocus(new FocusNode());

    final userEmail = _emailController.text;
    final userPassword = _passwordController.text;

    if (userEmail.isEmpty || userPassword.isEmpty) {
      snackBar('Email and Password must be filled', _scaffoldKey);
      return;
    }

    rememberMe = (rememberMe == null) ? false : rememberMe;

    if (rememberMe) {
      print('Remembered');
      await _setLoginPref(false);
    } else {
      print('Not Remembered');
      await _setLoginPref(true);
    }

    showLoadingDialog(context, _keyLoader);

    var _loginRes = repo.loginData(userEmail.trim(), userPassword);

    await _loginRes.then((value) async {
      print('donnned ${value.responseCode}');
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessResponseCode &&
          value.data.auth == true) {
        _sharedPreferenceQS.setData(
            'String', 'accessToken', value.data.accessToken);
        _sharedPreferenceQS.setData(
            'String', 'userFN', value.data.user.firstName);
        await _resetDetails().runtimeType;
        await _getUserProfile().runtimeType;
        Navigator.pushNamed(context, dashboardRoute);
      } else {
        showInSnackBar(
            'Login Failed: ${(value.responseMessage != null) ? value.responseMessage : ''}');
      }
    }, onError: (error) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      showInSnackBar("Login Failed $error");
    });
    print('######');
  }

  _resetDetails() {
    _sharedPreferenceQS.setData('String', 'userLN', '');
    _sharedPreferenceQS.setData('String', 'userPN', '');
    _sharedPreferenceQS.setData('String', 'userEm', '');
    _sharedPreferenceQS.setData('bool', 'detailsLoaded', false);
    print('User details cleared');
  }

  _getUserProfile() {
    print('Get User Profile');
    var _apiCall = repo.getProfile();

    _apiCall.then((value) {
      _sharedPreferenceQS.setData('String', 'userLN', value.data.surName);
      _sharedPreferenceQS.setData('String', 'userPN', value.data.phoneNumber);
      _sharedPreferenceQS.setData('String', 'userEm', value.data.email);
      //_sharedPreferenceQS.setData('String', 'nationalId', value.data.nationalID);
      _sharedPreferenceQS.setData(
          'bool', 'isEmailVerified', value.data.isEmailVerified);
      _sharedPreferenceQS.setData(
          'bool', 'isPhoneVerified', value.data.isPhoneVerified);
      _sharedPreferenceQS.setData('bool', 'detailsLoaded', true);

      print('User details set');
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

    final screeSize = MediaQuery.of(context).size;
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
                    margin:
                        EdgeInsets.fromLTRB(0, screeSize.height * 0.07, 10, 10),
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
                    height: screeSize.height -80,
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, forgotPasswordRoute);
                              },
                              child: Text(
                                'Forgot Password',
                                style: TextStyle(color: Colors.white),
                              ),
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
}
