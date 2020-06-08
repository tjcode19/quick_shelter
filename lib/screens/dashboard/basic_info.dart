import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/constants.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final QuickShelterRepository repo = QuickShelterRepository();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _fNameController = TextEditingController();
  final _lNameController = TextEditingController();
  final _phoneController = TextEditingController();


  _getUserProfile(){
    print('Get User Profile');
    showLoadingDialog(context, _keyLoader);
    var _apiCall = repo.getProfile();

    _apiCall.then((value) {
      print(value);
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

      setState(() {
        _fNameController.text = value.firstName;
        _lNameController.text = value.surName;
        _phoneController.text = value.phoneNumber;
        _emailController.text = value.email;
        
      });
    });

  }

  @override
  void initState() {
    super.initState();
    _getUserProfile();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: appSecondaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4,),
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundColor: appTextColorPrimary2,
                    child: Icon(
                      Icons.person,
                      size: 45.0,
                      color: appSecondaryColor,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30.0),
                  child: Text(
                    'Upload Profile Picture',
                    style: TextStyle(fontSize: 15, color: appSecondaryColor),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  child: Text(
                    'First Name',
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
              false,
              controller: _fNameController,
              color: appSecondaryColor,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  child: Text(
                    'Last Name',
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
              false,
              controller: _lNameController,
              color: appSecondaryColor,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  child: Text(
                    'Email',
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
              TextInputType.emailAddress,
              false,
              capitalizationType: TextCapitalization.none,
              controller: _emailController,
              color: appSecondaryColor,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  child: Text(
                    'Phone Number',
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
              TextInputType.phone,
              false,
              controller: _phoneController,
              color: appSecondaryColor,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  child: Text(
                    'Password',
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
            
            const SizedBox(height: 20),
            RaisedButtonWidget(profileRoute, 'Update', true),
          ]),
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: 160,
          margin: EdgeInsets.only(right: 5, left: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              //borderRadius: BorderRadius.all(Radius.circular(15)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                    blurRadius: 8, color: Colors.grey[300], spreadRadius: 2)
              ]),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.check),
              const SizedBox(height: 10),
              Text(
                'Account Updated Successfully',
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: RaisedButton(
                  padding: EdgeInsets.all(16),
                  highlightElevation: 5.0,
                  elevation: 3.0,
                  splashColor: Colors.teal[100],
                  highlightColor: Colors.teal[200],
                  color: Color.fromRGBO(45, 157, 127, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    "Dismiss",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
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
