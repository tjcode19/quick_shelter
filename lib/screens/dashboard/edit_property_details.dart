import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/models/GetUserProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../constants.dart';

class EditPropDetails extends StatefulWidget {
  final propDetails;

  EditPropDetails({Key key, this.propDetails}) : super(key: key);
  @override
  _EditPropDetailsState createState() => _EditPropDetailsState();
}

class _EditPropDetailsState extends State<EditPropDetails> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _propTypeController = TextEditingController();
  final _propTitleController = TextEditingController();
  final _propStateController = TextEditingController();
  final _propLocationController = TextEditingController();
  final _propDescController = TextEditingController();
  final _noOfLivingController = TextEditingController();
  final _noOfBedroomsController = TextEditingController();
  final _noOfBathroomsController = TextEditingController();
  final _noOfFloorsController = TextEditingController();
  final _propLandUnitController = TextEditingController();
  final _propLandAreaController = TextEditingController();
  final _propAddressController = TextEditingController();
  //final _propCountryController = TextEditingController();

  String listingType = "";
  String propertyType = "";
  bool sale = true;
  bool rent = false;
  bool hasSwimming = false;
  GetUserPropData _propertyDet;

  String stateSelection = "";

  void _addProperty() {
    if (_propTitleController.text.isEmpty) {
      snackBar('Please fill all fields', _scaffoldKey);
      return;
    }
    Map propData = {
      'propType': _propTypeController.text,
      'propTitle': _propTitleController.text,
      'propState': _propStateController.text,
      'propLocation': _propLocationController.text,
      'propDesc': _propDescController.text,
      'listingType': listingType
    };

    Navigator.pushNamed(context, addProperty2Route, arguments: propData);
  }

  void _editProperty() {
    // if (_sellingPriceController.text.isEmpty) {
    //   snackBar('Please fill all fields', _scaffoldKey);
    //   return;
    // }

    //var detailsOne = widget.propData;

    hasSwimming = (hasSwimming == null) ? false : hasSwimming;

    showLoadingDialog(context, _keyLoader);
    Map data = {
      'Type': propertyType,
      'Title': _propTitleController.text,
      'Location': _propLocationController.text,
      'Address': _propAddressController.text,
      'Description': _propDescController.text,
      'State': _propStateController.text,
      'Country': 'Nigeria',
      'LandArea': _propLandAreaController.text,
      "Units": _propLandUnitController.text,
      "Specifications": {
        "NO_OF_LIVINGROOMS": _noOfLivingController.text,
        "NO_OF_BEDROOMS": _noOfBedroomsController.text,
        "NO_OF_BATHROOMS": _noOfBathroomsController.text,
        "NO_OF_FLOORS": _noOfFloorsController.text,
        "HAS_SWIMMING_POOL": hasSwimming
      },
    };

    var _apiCall = repo.editProperty(data, _propertyDet.iD.toString());

    _apiCall.then(
      (value) {
        print(value.responseCode);
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (value.responseCode == globalSuccessResponseCode) {
          // Navigator.pushNamed(context, addPropertyStep2Route, arguments: {
          //   'propID': value.propertyID,
          // });
          _settingModalBottomSheet(context);
        } else {
          snackBar('Adding or property failed', _scaffoldKey);
        }
        //snackBar(value.message, _scaffoldKey);
      },onError: (e){
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        snackBar('Adding or property failed', _scaffoldKey);
      }
    );
  }

  void _setValues() {
    _propTypeController.text =
        (_propertyDet.type != null) ? _propertyDet.type : '';
    _propTitleController.text = _propertyDet.title;
    _propDescController.text = _propertyDet.description;
    _propStateController.text = _propertyDet.state;
    _propLocationController.text = _propertyDet.location;
    _propAddressController.text = _propertyDet.address;
    _propLandAreaController.text = _propertyDet.landArea;
    _noOfLivingController.text =
        _propertyDet.specifications.nOOFLIVINGROOMS.toString();
    _noOfBedroomsController.text =
        _propertyDet.specifications.nOOFROOMS.toString();
    _noOfBathroomsController.text =
        _propertyDet.specifications.nOOFBATHROOMS.toString();
    _noOfFloorsController.text =
        _propertyDet.specifications.nOOFFLOORS.toString();
    hasSwimming = _propertyDet.specifications.hASSWIMMINGPOOL;
    _propLandUnitController.text =
        (_propertyDet.units != null) ? _propertyDet.units : landUnit[0];

    print('Property ID: ${_propertyDet.iD}');
  }

  @override
  void initState() {
    super.initState();

    //_setValues();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // _getProperty();
      //await showLoadingDialog(context, _keyLoader);
      _propertyDet = widget.propDetails['pData'];
      _setValues();
    });
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
                  'Edit Property',
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
              ]),
              const SizedBox(height: 10),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         margin: EdgeInsets.only(
              //           top: 4,
              //         ),
              //         child: Text(
              //           'Choose Property Category',
              //           style: TextStyle(
              //             fontSize: 14,
              //             color: Colors.white,
              //           ),
              //           textAlign: TextAlign.left,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 20),
              // saleRentButton(),
              // const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Property Title',
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
              InputFieldWidget('Property Title', TextInputType.text, false,
                  controller: _propTitleController),
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
              GestureDetector(
                onTap: () {
                  showPropertyTypeDialog(context);
                },
                child: AbsorbPointer(
                  child: InputFieldWidget(
                    'Property Type',
                    TextInputType.text,
                    false,
                    controller: _propTypeController,
                  ),
                ),
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
              InputFieldWidget(
                'Property Description',
                TextInputType.text,
                false,
                controller: _propDescController,
                lines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    child: Text(
                      'Address',
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
              InputFieldWidget('Address', TextInputType.text, false,
                  controller: _propAddressController),
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
                    child: InkWell(
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
                            'Bedroom',
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
                                context, _noOfFloorsController, 'Floors');
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
                          'ex. 77 ',
                          TextInputType.text,
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
                            showLandUnitDialog(
                              context,
                            );
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

              const SizedBox(height: 40),
              RaisedButtonWidget(
                addProperty2Route,
                'Update',
                true,
                action: _editProperty,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  final states = ['Lagos', 'Abuja', 'Rivers', 'Oyo'];
  final propType = ['ENTIRE HOUSE', 'APARTMENT', 'SHARED APARTMENT'];
  final noList = ['1', '2', '3', '4', '5', '6', '7'];
  final landUnit = ["METRE SQUARE", "ACRE", "HECTARE"];

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
      FocusScope.of(context).requestFocus(new FocusNode());
      _propStateController.text = dialogVal;
    });
  }

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
      propertyType = dialogVal;
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

  void _settingModalBottomSheet(context) {
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
                    'Yay! Property Details Updated',
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
}
