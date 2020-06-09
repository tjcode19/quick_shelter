import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/input_field_multi_line.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../constants.dart';

class DashboardAddProp extends StatefulWidget {
  @override
  _DashboardAddPropState createState() => _DashboardAddPropState();
}

class _DashboardAddPropState extends State<DashboardAddProp> {
  final _sellingPriceController = TextEditingController();
  final _noOfBedroomsController = TextEditingController();
  final _noOfBathroomsController = TextEditingController();
  var _propertyTypeController = TextEditingController();
  final _propStateController = TextEditingController();
  final _propLocationController = TextEditingController();
  final _propLandAreaController = TextEditingController();
  final _propDescController = TextEditingController();
  final _propAvailableDateController = TextEditingController();

  final QuickShelterRepository repo = QuickShelterRepository();

  String type = "";
 

  var data = {
        'Type': 'type',
        'Location': 'loc',
        'Adddress': 'addr',
        'Description': 'descrip',
        'State': 'password',
        'Country': 'password',
        'LandArea':' password',
        "Specifications": {
          "NO_OF_ROOMS": 3,
          "NO_OF_FLOORS": 3,
          "HAS_SWIMMING_POOL": true
        },
        "addListing": 'phoneNum',
        "Listing": {
          "ListingType": "FOR RENT",
          "AvailableFrom": "01-12-2020",
          "MinPeriod": "3",
          "PeriodUnits": "YEAR"
        }
      };

  void _addProperty() {
    var _apiCall = repo.addProperty(data);

    _apiCall.then((value) {
      print(value.message);
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.code == '200') {
        //_sharedPreferenceQS.setData(String, 'accessToken', value.accessToken);
        //Navigator.pushNamed(context, verifyPhoneRoute);
       // _settingModalBottomSheet(context);
      } else {
        //snackBar('Registration Failed \t ${value.message}', _scaffoldKey);
      }
      //snackBar(value.message, _scaffoldKey);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: appSecondaryColor,
      appBar: AppBar(
        backgroundColor: appSecondaryColor,
        elevation: 0.0,
        leading: IconButton(
          color: Colors.white,
          iconSize: 30.0,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Add Property',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Step 1 of 3',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  textAlign: TextAlign.center,
                )
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        'Choose Property Category',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Stack(
                children: <Widget>[
                  Container(
                    height: 70,
                  ),
                  Positioned(
                    right: 0.0,
                    top: 0,
                    child: Container(
                      width: screeSize.width / 2,
                      child: OutlineButton(
                        padding: EdgeInsets.all(11),
                        color: Colors.white,
                        highlightedBorderColor: Colors.white,
                        borderSide: BorderSide(color: appTextColorPrimary2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15))),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 3, 4, 4),
                          child: Text(
                            'For Rent',
                            style: TextStyle(
                                color: appTextColorPrimary2, fontSize: 13),
                          ),
                        ),
                        onPressed: () {
                          //showSnackBar("OutlineButton with Shape");
                        },
                      ),
                    ),
                  ),
                  Container(
                      width: screeSize.width / 2,
                      child:
                          RaisedButtonWidget('routeName', 'For Sale', false)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Selling Price',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              InputFieldWidget('Selling Price', TextInputType.number, false, controller: _sellingPriceController),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: screeSize.width / 2 - 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Bedrooms',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        InputFieldWidget('ex. 3', TextInputType.text, false, controller: _noOfBedroomsController,),
                      ],
                    ),
                  ),
                  Container(
                    width: screeSize.width / 2 - 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Bathroom',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        InputFieldWidget('ex. 2', TextInputType.text, false, controller: _noOfBathroomsController,),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Property Type',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              InputFieldMultiLineWidget('Property description', 3),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Property State & Location',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      width: screeSize.width / 2 - 30,
                      child:
                          InputFieldWidget('ex. Lagos state', TextInputType.text, false, controller: _propStateController,)),
                  Container(
                      width: screeSize.width / 2 - 30,
                      child:
                          InputFieldWidget('ex. Lekki Phase 1', TextInputType.text, false, controller: _propLocationController,)),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Land Area',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              InputFieldWidget('ex. 77 km2', TextInputType.text, false, controller: _propLandAreaController,),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Available Date',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              InputFieldWidget('30 May, 2020', TextInputType.text, false, controller: _propAvailableDateController,),
              const SizedBox(height: 40),
              RaisedButtonWidget(addPropertyStep2Route, 'Continue', true, action: _addProperty,),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
