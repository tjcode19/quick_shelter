import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/models/GetUserProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class AddPropListing extends StatefulWidget {
  final propDetails;

  AddPropListing({Key key, this.propDetails}) : super(key: key);
  @override
  _AddPropListingState createState() => _AddPropListingState();
}

class _AddPropListingState extends State<AddPropListing> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _propTypeController = TextEditingController();
  final _propMinPeriodController = TextEditingController();
  final _propPeriodUnitController = TextEditingController();
  final _propPriceController = TextEditingController();
  final _propAvailableDateController = TextEditingController();
  //final _propCountryController = TextEditingController();

  String listingType = "";
  bool sale = false;
  bool rent = false;
  bool isAvailable = false;
  String _actionType;
  GetUserPropData _propertyDet;
  GetUserListings _propertyListDetails;

  String stateSelection = "";

  void _addPropertyListing() {
    if (listingType.isEmpty) {
      snackBar('Please select Listing Type', _scaffoldKey);
      return;
    }

    //var detailsOne = widget.propData;

    isAvailable = (isAvailable == null) ? false : isAvailable;

    showLoadingDialog(context, _keyLoader);
    Map data = {
      "PropertyID": _propertyDet.iD,
      "ListingType": listingType,
      "AvailableFrom": _propAvailableDateController.text,
      "MinPeriod": _propMinPeriodController.text,
      "PeriodUnits": _propPeriodUnitController.text,
      "Price": _propPriceController.text,
      "IS_AVAILABLE": isAvailable
    };

    var _apiCall = repo.addPropertyListing(data, _propertyDet.iD.toString());

    _apiCall.then(
      (value) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (value.responseCode == globalSuccessResponseCode) {
          // Navigator.pushNamed(context, addPropertyStep2Route, arguments: {
          //   'propID': value.propertyID,
          // });
          _settingModalBottomSheet(context,'Yay, Property Listing Added','You have successfully added listing to your property.');
        } else {
          snackBar('Adding or property failed', _scaffoldKey);
        }
        //snackBar(value.message, _scaffoldKey);
      },
    );
  }

  void _editPropertyListing() {
    if (listingType.isEmpty) {
      snackBar('Please select Listing Type', _scaffoldKey);
      return;
    }

    //var detailsOne = widget.propData;

    isAvailable = (isAvailable == null) ? false : isAvailable;

    showLoadingDialog(context, _keyLoader);
    Map data = {
      "ListingType": listingType,
      "AvailableFrom": _propAvailableDateController.text,
      "MinPeriod": _propMinPeriodController.text,
      "PeriodUnits": _propPeriodUnitController.text,
      "Price": _propPriceController.text,
      "IS_AVAILABLE": isAvailable
    };

    var _apiCall =
        repo.editPropertyListing(data, _propertyListDetails.iD.toString());

    _apiCall.then(
      (value) {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (value.responseCode == globalSuccessResponseCode) {
          _settingModalBottomSheet(context, 'Yay, Property Listing Updated','You have successfully updated your property listing.');
        } else {
          snackBar('Property Update Failed', _scaffoldKey);
        }
      },
    );
  }

  _setValues() {
    listingType = _propertyListDetails.listingType;
    _propMinPeriodController.text = _propertyListDetails.minPeriod.toString();
    _propPeriodUnitController.text = _propertyListDetails.periodUnits;
    _propPriceController.text = _propertyListDetails.price.toString();
    _propAvailableDateController.text = _propertyListDetails.availableFrom;
    isAvailable = _propertyListDetails.iSAVAILABLE;

    setState(() {
      if (listingType != 'FOR SALE') {
        sale = false;
        rent = true;
      } else {
        sale = true;
        rent = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    //_setValues();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _getProperty();
      //await showLoadingDialog(context, _keyLoader);
      _actionType = widget.propDetails['type'];
      if (_actionType == 'new') {
        _propertyDet = widget.propDetails['dataLoad'];
        print('New Listing: $_propertyDet');
      } else {
        _propertyListDetails = widget.propDetails['dataLoad'];
        _setValues();
        print('Edit Listing: $_propertyListDetails');
      }
    });

    fToast = FToast(context);
  }

  FToast fToast;

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
                  'List Property',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                // Text(
                //   'Step 1 of 4',
                //   style: TextStyle(color: Colors.white, fontSize: 15.0),
                //   textAlign: TextAlign.center,
                // )
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
                        'Choose Listing Type',
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
              const SizedBox(height: 10),
              saleRentButton(),
              const SizedBox(height: 10),
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
                            'Price',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        InputFieldWidget(
                          'ex. 3,000,000',
                          TextInputType.number,
                          false,
                          controller: _propPriceController,
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
                            'Available From',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: AbsorbPointer(
                            child: InputFieldWidget(
                              'ex. 2',
                              TextInputType.number,
                              false,
                              controller: _propAvailableDateController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 18),
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
                            'Minimum Period',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showNumberDialog(context, _propMinPeriodController,
                                'Minimum Period');
                          },
                          child: AbsorbPointer(
                            child: InputFieldWidget(
                              'ex. 3',
                              TextInputType.number,
                              false,
                              controller: _propMinPeriodController,
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
                            'Period Unit',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showPeriodUnitDialog(context);
                          },
                          child: AbsorbPointer(
                            child: InputFieldWidget(
                              'ex. 2',
                              TextInputType.number,
                              false,
                              controller: _propPeriodUnitController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
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
                        value: isAvailable,
                        activeColor: Theme.of(context).primaryColor,
                        onChanged: (bool value) {
                          setState(() {
                            isAvailable = value;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Is Available',
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              (_actionType != 'edit')
                  ? RaisedButtonWidget(
                      addProperty2Route,
                      'Add Listing',
                      true,
                      action: _addPropertyListing,
                    )
                  : RaisedButtonWidget(
                      addProperty2Route,
                      'Edit Listing',
                      true,
                      action: _editPropertyListing,
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  final propType = ['ENTIRE HOUSE', 'APARTMENT', 'SHARED APARTMENT'];
  final noList = ['1', '2', '3', '4', '5', '6', '7'];
  final periodUnit = ["YEAR", "MONTH", "WEEK"];

  // replace this function with the examples above
  Future showPropertyTypeDialog(BuildContext context) async {
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text(
        'Select Property Type',
        style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.normal),
      ),
      children: propType.map((e) {
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
      _propTypeController.text = dialogVal;
    });
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
  Future showPeriodUnitDialog(BuildContext context) async {
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: Text(
        'Select Period Unit',
        style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.normal),
      ),
      children: periodUnit.map((e) {
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
      _propPeriodUnitController.text = dialogVal;
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
        FocusScope.of(context).requestFocus(new FocusNode());
        selectedDate = picked;
        // DateTime now = DateTime.now();
        String formattedDate = DateFormat('dd MMM, yyyy').format(selectedDate);
        _propAvailableDateController.text = formattedDate;
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
                      //print(rent);
                      _showToast('You selected FOR RENT');
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
                    //print('pressed');
                    _showToast('You selected FOR SALE');
                  },
                ),
              ),
            ],
          )
        : (rent)
            ? Stack(
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
                          style: TextStyle(
                              color: appTextColorPrimary2, fontSize: 15),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          sale = true;
                          rent = false;
                          listingType = 'FOR SALE';
                        });
                        _showToast('You selected FOR SALE');
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
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20))),
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
                          _showToast('You selected FOR RENT');
                          //print('pressed');
                        },
                      ),
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
                          'For Sale New',
                          style: TextStyle(
                              color: appTextColorPrimary2, fontSize: 15),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          sale = true;
                          rent = false;
                          listingType = 'FOR SALE';
                        });
                        _showToast('You selected FOR SALE');
                        //showSnackBar("OutlineButton with Shape");
                      },
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    top: 0,
                    child: Container(
                      width: screeSize.width / 2 - 5,
                      color: appSecondaryColor,
                      child: OutlineButton(
                        padding: EdgeInsets.all(10),
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
                                color: appTextColorPrimary2, fontSize: 15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            sale = false;
                            rent = true;
                            listingType = 'FOR RENT';
                          });
                          _showToast('You selected FOR RENT');
                          //showSnackBar("OutlineButton with Shape");
                        },
                      ),
                    ),
                  ),
                ],
              );
  }

  void _settingModalBottomSheet(context, sTitle, sBody) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          margin: EdgeInsets.only(right: 0, left: 0),
          decoration: BoxDecoration(
              color: appSecondaryColor,
              //borderRadius: BorderRadius.all(Radius.circular(15)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(blurRadius: 5, color: Colors.white, spreadRadius: 1)
              ]),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: appTextColorPrimary2,
              ),
              const SizedBox(
                  height:
                      10), //You have successfully added a new property to your collections.
              Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    sTitle,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    'You have successfully updated your property details.',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 40),

              Container(
                width: MediaQuery.of(context).size.width - 30,
                margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  highlightElevation: 5.0,
                  elevation: 3.0,
                  splashColor: Colors.orange[100],
                  highlightColor: Colors.orange[100],
                  color: appColorSecondary,
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
                          'Dismiss',
                          style: TextStyle(
                              color: appTextColorPrimary2, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    // _settingModalBottomSheet(context);
                    widget.propDetails['refFunc']();
                    int count = 0;
                    Navigator.popUntil(context, (route) {
                      return count++ == 4;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showToast(String msg) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white30,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            msg,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM_RIGHT,
      toastDuration: Duration(seconds: 2),
    );
  }
}
