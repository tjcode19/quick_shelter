import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/models/TransactionStatusResponse.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';

import '../../constants.dart';
import '../../widgets/raised_button.dart';

class TransSuccess extends StatefulWidget {
  final transDetails;

  TransSuccess({Key key, this.transDetails}) : super(key: key);
  @override
  _TransSuccessState createState() => _TransSuccessState();
}

class _TransSuccessState extends State<TransSuccess> {
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _surName, _userEmail, _userPassword;

  TransactionStatusResponse paymentRes;

  void _checkTrans() async {
    print('Check Transaction');
    var _apiCall = repo.checkTransaction(_userPassword);

    await _apiCall.then((value) async {
      print('donnned ${value.responseCode}');
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        
        setState(() {
          paymentRes = value;
        });
      } else {
        //snackBar(value.responseMessage, _scaffoldKey);
      }
    }, onError: (error) {
      print('Check Transaction $error');
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    });
  }



  Future<bool> _onBackPressed() {
    return Navigator.pushNamedAndRemoveUntil(
        context, getStartedRoute, (route) => false);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _checkTrans();      
      await showLoadingDialog(context, _keyLoader);
    });
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
                    Icon(
                      Icons.check_circle,
                      size: 50.0,
                      color: appTextColorPrimary2,
                    ),
                    const SizedBox(height: 25),
                    RichText(
                      text: TextSpan(
                        text: 'Transaction Completed ',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                        children: [
                          TextSpan(text: _surName),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      child: Text(
                        'Transaction ID: ${paymentRes.data.transactionID}', 
                        style: TextStyle(
                            color: Color.fromRGBO(226, 208, 195, 1),
                            fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 10),
                    Container(
                      child: Text(
                        'Payment Status: ${paymentRes.data.status}', 
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
                //action: _doLogin,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
