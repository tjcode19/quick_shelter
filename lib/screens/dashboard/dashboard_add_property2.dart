import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../constants.dart';

class DashboardAddProp2 extends StatefulWidget {
  final propData;

  DashboardAddProp2({Key key, this.propData}) : super(key: key);

  @override
  _DashboardAddProp2State createState() => _DashboardAddProp2State();
}

class _DashboardAddProp2State extends State<DashboardAddProp2> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _sellingPriceController = TextEditingController();
  final _noOfBedroomsController = TextEditingController();
  final _noOfBathroomsController = TextEditingController();
  final _noOfLivingController = TextEditingController();
  final _propStateController = TextEditingController();
  final _noOfFloorsController = TextEditingController();
  final _propLandAreaController = TextEditingController();
  final _propLandUnitController = TextEditingController();
  final _propAvailableDateController = TextEditingController();
  final _propAddressController = TextEditingController();
  //final _propCountryController = TextEditingController();

  String listingType = "FOR SALE";
  bool sale = true;
  bool rent = false;
  bool hasSwimming = false;
  bool addListing = false;

  String stateSelection = "";

  void _addProperty() {
    var detailsOne = widget.propData;



    hasSwimming = (hasSwimming == null) ? false : hasSwimming;

    showLoadingDialog(context, _keyLoader);
    Map data = {
      'Type': detailsOne['propType'],
      'Title': detailsOne['propTitle'],
      'Location': detailsOne['propLocation'],
      'Adddress': _propAddressController.text,
      'Description': detailsOne['propDesc'],
      'State': detailsOne['propState'],
      'Country': 'Nigeria',
      'LandArea': _propLandAreaController.text,
     // 'Price': _sellingPriceController.text,
      "Specifications": {
        "NO_OF_LIVINGROOMS": _noOfLivingController.text,
        "NO_OF_BEDROOMS": _noOfBedroomsController.text,
        "NO_OF_BATHROOMS": _noOfBathroomsController.text,
        "NO_OF_FLOORS": _noOfFloorsController.text,
        "HAS_SWIMMING_POOL": hasSwimming
      }
//      "addListing": false,
//       "Listing": {
//         "ListingType": listingType,
//         "IS_AVAILABLE": true,
//         "MinPeriod": "3",
//         "PeriodUnits": "YEAR",
//         "Price": _sellingPriceController.text
//       }
    };

    print(data);

    var _apiCall = repo.addProperty(data);

    _apiCall.then(
      (value) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (value.responseCode == globalSuccessResponseCode) {
          Navigator.pushNamed(context, addPropertyStep2Route, arguments: {
            'propID': value.data.propertyID,
            'listingType': detailsOne['listingType'],
            'type':'newProp'
          });
        } else {
          snackBar('Adding or property failed', _scaffoldKey);
        }
        //snackBar(value.message, _scaffoldKey);
      }, onError: (e){
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

    },
    );
  }

  @override
  void initState() {
    super.initState();

    //print(widget.propData);
  }

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
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
                  'Step 2 of 5',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  textAlign: TextAlign.center,
                )
              ]),
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
                            'Livingrooms',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showNumberDialog(
                                context, _noOfLivingController, 'Livingrooms');
                          },
                          child: AbsorbPointer(
                            child: InputFieldWidget(
                              'ex. 3',
                              TextInputType.number,
                              false,
                              controller: _noOfLivingController,
                            ),
                          ),
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
                            'Bedrooms',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showNumberDialog(
                                context, _noOfBedroomsController, 'Bedroom');
                          },
                          child: AbsorbPointer(
                            child: InputFieldWidget(
                              'ex. 2',
                              TextInputType.number,
                              false,
                              controller: _noOfBedroomsController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
                            'Bathrooms',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showNumberDialog(
                                context, _noOfBathroomsController, 'Bathrooms');
                          },
                          child: AbsorbPointer(
                            child: InputFieldWidget(
                              'ex. 3',
                              TextInputType.number,
                              false,
                              controller: _noOfBathroomsController,
                            ),
                          ),
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
                            'Floors',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showNumberDialog(
                                context, _noOfFloorsController, 'Floor');
                          },
                          child: AbsorbPointer(
                            child: InputFieldWidget(
                              'ex. 2',
                              TextInputType.number,
                              false,
                              controller: _noOfFloorsController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
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
                        value: hasSwimming,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (bool value) {
                          setState(() {
                            hasSwimming = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Swimming pool',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              ),
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
                            'Land Area',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        InputFieldWidget(
                          'ex. 77',
                          TextInputType.number,
                          false,
                          controller: _propLandAreaController,
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
                            'Land Units',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showLandUnitDialog(context);
                          },
                          child: AbsorbPointer(
                            child: InputFieldWidget(
                              'ex. meter square',
                              TextInputType.text,
                              false,
                              controller: _propLandUnitController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
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

  // replace this function with the examples above
  Future showNumberDialog(BuildContext context, _controll, String lb) async {
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: Text(
        'Select Number Of $lb',
        style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.normal),
      ),
      children: noList.map((e) {
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
      FocusScope.of(context).requestFocus(new FocusNode());
      _controll.text = dialogVal;
    });
  }

  // replace this function with the examples above
  Future showLandUnitDialog(BuildContext context) async {
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: Text(
        'Select Land Unit',
        style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.normal),
      ),
      children: landUnit.map((e) {
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
      FocusScope.of(context).requestFocus(new FocusNode());
      _propLandUnitController.text = dialogVal;
    });
  }

  Widget saleRentButton() {
    final screeSize = MediaQuery.of(context).size;
    return (sale)
        ? Stack(
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
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(15))),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10, 3, 4, 4),
                      child: Text(
                        'For Rent',
                        style: TextStyle(
                            color: appTextColorPrimary2, fontSize: 13),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        rent = true;
                        sale = false;
                        listingType = 'FOR RENT';
                      });
                      print(rent);
                      //showSnackBar("OutlineButton with Shape");
                    },
                  ),
                ),
              ),
              Container(
                width: screeSize.width / 2,
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  highlightElevation: 5.0,
                  elevation: 3.0,
                  splashColor: Colors.orange[100],
                  highlightColor: Colors.orange[100],
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      //borderRadius: new BorderRadius.circular(10.0),
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(20))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                        child: Text(
                          'For Sale',
                          style: TextStyle(
                              color: appTextColorPrimary, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      sale = true;
                      rent = false;
                      listingType = 'FOR SALE';
                    });
                    print('pressed');
                  },
                ),
              ),
            ],
          )
        : Stack(
            children: <Widget>[
              Container(
                height: 70,
              ),
              Container(
                width: screeSize.width / 2 - 5,
                child: OutlineButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  highlightedBorderColor: Colors.white,
                  borderSide: BorderSide(color: appTextColorPrimary2),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(15))),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 3, 4, 4),
                    child: Text(
                      'For Sale',
                      style:
                          TextStyle(color: appTextColorPrimary2, fontSize: 15),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      sale = true;
                      rent = false;
                      listingType = 'FOR SALE';
                    });
                    //showSnackBar("OutlineButton with Shape");
                  },
                ),
              ),
              Positioned(
                right: 0.0,
                top: 0,
                child: Container(
                  width: screeSize.width / 2,
                  child: RaisedButton(
                    padding: EdgeInsets.all(10),
                    highlightElevation: 5.0,
                    elevation: 3.0,
                    splashColor: Colors.orange[100],
                    highlightColor: Colors.orange[100],
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        //borderRadius: new BorderRadius.circular(10.0),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                          child: Text(
                            'For Rent',
                            style: TextStyle(
                                color: appTextColorPrimary, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        sale = false;
                        rent = true;
                        listingType = 'FOR RENT';
                      });
                      print('pressed');
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
