import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final QuickShelterRepository repo = QuickShelterRepository();
  final _sellingPriceController = TextEditingController();
  final _noOfBedroomsController = TextEditingController();
  final _noOfBathroomsController = TextEditingController();
  final _propertyTypeController = TextEditingController();
  final _propStateController = TextEditingController();
  final _propLocationController = TextEditingController();
  final _propLandAreaController = TextEditingController();
  final _propDescController = TextEditingController();
  final _propAvailableDateController = TextEditingController();
  final _propAddressController = TextEditingController();
  final _propCountryController = TextEditingController();

  String type = "";
  bool sale = true;
  bool rent = false;

  String stateSelection = "";

  void _addProperty() {
    Map data = {
      'Type': _propertyTypeController.text,
      'Location': _propLocationController.text,
      'Adddress': _propAddressController.text,
      'Description': _propDescController.text,
      'State': _propStateController.text,
      'Country': _propCountryController.text,
      'LandArea': _propLandAreaController.text,
      "Specifications": {
        "NO_OF_LIVINGROOMS": 2,
        "NO_OF_ROOMS": _noOfBedroomsController.text,
        "NO_OF_FLOORS": 3,
        "HAS_SWIMMING_POOL": true
      },
      "addListing": true,
      "Listing": {
        "ListingType": "FOR RENT",
        "IS_AVAILABLE": true,
        "MinPeriod": "3",
        "PeriodUnits": "YEAR"
      }
    };

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
  void initState() {
    // TODO: implement initState
    super.initState();
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
                          sale = !sale;
                          //showSnackBar("OutlineButton with Shape");
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: screeSize.width / 2,
                    child: RaisedButtonWidget('routeName', 'For Sale', false),
                  ),
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
              InputFieldWidget('Selling Price', TextInputType.number, false,
                  controller: _sellingPriceController),
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
                        InputFieldWidget(
                          'ex. 3',
                          TextInputType.text,
                          false,
                          controller: _noOfBedroomsController,
                        ),
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
                        InputFieldWidget(
                          'ex. 2',
                          TextInputType.text,
                          false,
                          controller: _noOfBathroomsController,
                        ),
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
                      'Property Description',
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
                        // DropDownFormField(
                        //   titleText: '',
                        //   hintText: 'Select State',
                        //   value: _myActivity,
                        //   onSaved: (value) {
                        //     setState(() {
                        //       _myActivity = value;
                        //     });
                        //   },
                        //   onChanged: (value) {
                        //     setState(() {
                        //       _myActivity = value;
                        //     });
                        //   },
                        //   dataSource: _states,
                        //   textField: 'display',
                        //   valueField: 'value',
                        // ),
                        InkWell(
                      onTap: () {
                        showAlertDialog(context);
                      },
                      child: Container(
                        child: InputFieldWidget(
                          'ex. Lagos state',
                          TextInputType.text,
                          false,
                          controller: _propStateController,
                          enableField: false,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: screeSize.width / 2 - 30,
                      child: InputFieldWidget(
                        'ex. Lekki Phase 1',
                        TextInputType.text,
                        false,
                        controller: _propLocationController,
                      )),
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
              InputFieldWidget(
                'ex. 77 km2',
                TextInputType.text,
                false,
                controller: _propLandAreaController,
              ),
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
              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: InputFieldWidget(
                  '30 May, 2020',
                  TextInputType.text,
                  false,
                  controller: _propAvailableDateController,
                  enableField: false,
                ),
              ),
              const SizedBox(height: 40),
              RaisedButtonWidget(
                addPropertyStep2Route,
                'Continue',
                true,
                 action: _addProperty,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  final states = ['Lagos', 'Abuja', 'Rivers', 'Oyo'];

  // replace this function with the examples above
  Future showAlertDialog(BuildContext context) async {
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text(
        'Select State',
        style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.normal),
      ),
      children: states.map((e) {
        return new SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context,
                e); //here passing the index to be return on item selection
          },
          child: new Text(e), //item value
        );
      }).toList(),
    );

    // show the dialog
    String dialogVal = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );

    setState(() {
      //stateSelection = dialogVal;
      print('Hello $dialogVal');
      _propStateController.text = dialogVal;
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        // DateTime now = DateTime.now();
        String formattedDate = DateFormat('dd MMM, yyyy').format(selectedDate);
        _propAvailableDateController.text = formattedDate;
      });
  }
}
