import 'package:flutter/material.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';

import '../constants.dart';
import '../widgets/raised_button.dart';

class RegCompleted extends StatefulWidget {
  @override
  _RegCompletedState createState() => _RegCompletedState();
}

class _RegCompletedState extends State<RegCompleted> {
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _surName, _userEmail, _userPassword;

  _getUserSurName() async {
    _surName = await _sharedPreferenceQS.getSharedPrefs(String, 'surName');
    _userEmail = await _sharedPreferenceQS.getSharedPrefs(String, 'userEmail');
    _userPassword =
        await _sharedPreferenceQS.getSharedPrefs(String, 'userPassword');

    setState(() {
      _surName = _surName;
    });
  }

  void _doLogin() async {
    print('loginRes');
    FocusScope.of(context).requestFocus(new FocusNode());

    showLoadingDialog(context, _keyLoader);

    var _loginRes = repo.loginData(_userEmail, _userPassword);

    await _loginRes.then((value) async {
      //print('donnned ${value.auth}');
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
        snackBar(value.responseMessage, _scaffoldKey);
      }
    }, onError: (error) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    });
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
      print(value.responseCode);
      if (value.responseCode == globalSuccessGetResponseCode) {
        setState(() {
          _sharedPreferenceQS.setData('String', 'userFN', value.data.firstName);
          _sharedPreferenceQS.setData('String', 'userLN', value.data.surName);
          _sharedPreferenceQS.setData(
              'String', 'userPN', value.data.phoneNumber);
          _sharedPreferenceQS.setData('String', 'userEm', value.data.email);
          _sharedPreferenceQS.setData('bool', 'detailsLoaded', true);
        });
      } else {}
    });
  }

  Future<bool> _onBackPressed() {
    return Navigator.pushNamedAndRemoveUntil(
        context, getStartedRoute, (route) => false);
  }

  @override
  void initState() {
    super.initState();

    _getUserSurName();
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/building.png',
                      height: 300,
                      width: MediaQuery.of(context).size.width - 10,
                    ),
                    const SizedBox(height: 25),
                    RichText(
                      text: TextSpan(
                        text: 'Welcome ',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        children: [
                          TextSpan(text: _surName),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Text(
                        'We hope you find homes, apartment rentals and real estate listings.',
                        style: TextStyle(
                            color: Color.fromRGBO(226, 208, 195, 1),
                            fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              RaisedButtonWidget(
                dashboardRoute,
                'Continue',
                true,
                action: _doLogin,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
