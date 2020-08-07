import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/constants.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';

import '../../pin_entry_text_field.dart';

class Identification extends StatefulWidget {
  @override
  _IdentificationState createState() => _IdentificationState();
}

class _IdentificationState extends State<Identification> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();

  final _passwordController = TextEditingController();
  bool _viewMore = false;
  bool _viewMore1 = false;
  bool _loader1 = false;
  bool _loader2 = false;
  String _prefEm = "", _prefPh = "";
  bool _detailsLoaded, _isPhone, _isEmail;

  _requestOtp(int rw) {
    setState(() {
      if (rw == 1) {
        _loader1 = true;
      }
      if (rw == 2) {
        _loader2 = true;
      }
    });

    var _apiCall = repo.requestOtp(
      _passwordController.text,
    );

    _apiCall.then((value) {
      if (value.responseCode != globalSuccessGetResponseCode) {
        snackBar(value.responseMessage, _scaffoldKey);
        setState(() {
          _loader1 = false;
          _loader2 = false;
        });
      } else {
        // _settingModalBottomSheet(context);
        setState(() {
          if (rw == 1) {
            _viewMore = !_viewMore;
            _loader1 = false;
          } else {
            _viewMore1 = !_viewMore1;
            _loader2 = false;
          }
        });
      }
    }, onError: (error) {
      snackBar('OTP request failed, try again later', _scaffoldKey);
      setState(() {
        if (rw == 1) {
          _viewMore = !_viewMore;
          _loader1 = false;
        } else {
          _viewMore1 = !_viewMore1;
          _loader2 = false;
        }
      });
    });
  }

  _validatePhone(String phoneNum, String code) {
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

  _getUserProfile() async {
    _detailsLoaded =
        await _sharedPreferenceQS.getSharedPrefs(bool, 'detailsLoaded');
    if (_detailsLoaded) {
      String prefPh =
          await _sharedPreferenceQS.getSharedPrefs(String, 'userPN');
      String prefEm =
          await _sharedPreferenceQS.getSharedPrefs(String, 'userEm');
      bool isPhone =
          await _sharedPreferenceQS.getSharedPrefs(String, 'isPhoneVerified');
      bool isEmail =
          await _sharedPreferenceQS.getSharedPrefs(String, 'isEmailVerified');
      setState(() {
        _prefEm = prefEm;
        _prefPh = prefPh;
        _isEmail = (isEmail != null) ? isEmail : false;
        _isPhone = (isPhone != null) ? isPhone : false;
      });
    } else {
      snackBar('Falied to retrieve user details', _scaffoldKey);
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
        leading: IconButton(
          color: appSecondaryColor,
          iconSize: 30.0,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(children: [
            Row(
              children: [
                Container(
                  child: Text(
                    'Identification',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: appSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 55),
            Container(
              padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
              decoration: BoxDecoration(
                  color: appPrimary,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(10)),
                  border: Border.all(color: appTextColorPrimary2)),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Email Address',
                            style: TextStyle(
                                color: appSecondaryColor, fontSize: 16),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _prefEm,
                            style: TextStyle(
                                color: appSecondaryColorLight, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          (!_isEmail)
                              ? GestureDetector(
                                  onTap: () {
                                    _requestOtp(1);
                                  },
                                  child: Text(
                                    'Verify Now ',
                                    style: TextStyle(
                                        color: appSecondaryColor, fontSize: 14),
                                  ),
                                )
                              : Row(
                                  children: <Widget>[
                                    Text(
                                      'Verified',
                                      style: TextStyle(
                                          color: appSecondaryColor,
                                          fontSize: 14),
                                    ),
                                    Icon(
                                      Icons.check_circle,
                                      color: Color.fromRGBO(215, 247, 223, 0.7),
                                    )
                                  ],
                                ),
                          Visibility(
                            visible: _loader1,
                            child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _viewMore,
                    child: Column(
                      children: <Widget>[
                        Divider(color: appTextColorPrimary2, thickness: 1.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Enter the OTP sent to you email',
                                softWrap: true,
                                style: TextStyle(color: appSecondaryColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        PinEntryTextField(
                          showFieldAsBox: false,
                          fields: 6,
                          keyboardType: TextInputType.text,
                          onSubmit: (String pin) {
                            _validatePhone(_prefEm, pin);
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
              decoration: BoxDecoration(
                  color: appPrimary,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(10)),
                  border: Border.all(color: appTextColorPrimary2)),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Phone Number',
                            style: TextStyle(
                                color: appSecondaryColor, fontSize: 16),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _prefPh,
                            style: TextStyle(
                                color: appSecondaryColorLight, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          (!_isPhone)
                              ? GestureDetector(
                                  onTap: () {
                                    _requestOtp(2);
                                  },
                                  child: Text(
                                    'Verify Now ',
                                    style: TextStyle(
                                        color: appSecondaryColor, fontSize: 14),
                                  ),
                                )
                              : Row(
                                  children: <Widget>[
                                    Text(
                                      'Verified',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 14),
                                    ),
                                    SizedBox(width: 5.0,),
                                    Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                          Visibility(
                            visible: _loader2,
                            child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _viewMore1,
                    child: Column(
                      children: <Widget>[
                        Divider(color: appTextColorPrimary2, thickness: 1.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                'Enter the OTP sent to your phone number',
                                softWrap: true,
                                style: TextStyle(color: appSecondaryColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        PinEntryTextField(
                          showFieldAsBox: false,
                          fields: 6,
                          onSubmit: (String pin) {
                            _validatePhone(_prefPh, pin);
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

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (BuildContext bc) {
        return Container(
          height: 250,
          margin: EdgeInsets.only(right: 0, left: 0),
          decoration: BoxDecoration(
            color: appSecondaryColor,
            //borderRadius: BorderRadius.all(Radius.circular(15)),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle_outline,
                size: 55,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              Text(
                'Password Updated Successfully',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: RaisedButton(
                  padding: EdgeInsets.all(16),
                  highlightElevation: 5.0,
                  elevation: 3.0,
                  splashColor: Colors.teal[100],
                  highlightColor: Colors.teal[200],
                  color: appColorSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    "Dismiss",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  onPressed: () {
                    //Navigator.pushNamed(context, basicInfoRoute);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
