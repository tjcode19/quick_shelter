import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/constants.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();


  _updatePassword() {   

    if(_passwordController.text != _confirmPassController.text){
      snackBar('Password does not match', _scaffoldKey);
      return;
    }

    showLoadingDialog(context, _keyLoader);

    var _apiCall = repo.updatePassword(_passwordController.text,);

    _apiCall.then((value) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.code != '200') {
        snackBar(value.message, _scaffoldKey);
      } else {        
        _settingModalBottomSheet(context);
      }
    }, onError: (error){
      snackBar('Update failed, try again later', _scaffoldKey);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    });
  }



  @override
  void initState() {
    super.initState();
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
                    'Change Password',
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
            Row(
              children: [
                Container(
                  child: Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            InputFieldWidget(
              '',
              TextInputType.text,
              true,
              controller: _passwordController,
              color: appSecondaryColor,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  child: Text(
                    'Confirm New Password',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            InputFieldWidget(
              '',
              TextInputType.text,
              true,
              controller: _confirmPassController,
              color: appSecondaryColor,
            ),
            const SizedBox(height: 10),
           
            const SizedBox(height: 10),
          
            const SizedBox(height: 20),
            RaisedButtonWidget(
              profileRoute,
              'Change Password',
              true,
              action: _updatePassword,
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
