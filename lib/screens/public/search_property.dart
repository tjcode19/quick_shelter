import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quick_shelter/models/GetAllProperties.dart';
import 'package:quick_shelter/models/GetPublicProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/commonFunctions.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/tapableText.dart';
import '../../colors.dart';
import '../../widgets/input_field.dart';
import '../../widgets/input_label.dart';
import '../../widgets/raised_button.dart';

import '../../constants.dart';

class SearchPropPub extends StatefulWidget {
  @override
  _SearchPropPubState createState() => _SearchPropPubState();
}

class _SearchPropPubState extends State<SearchPropPub> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _propTypeController = TextEditingController();
  final _propLocationController = TextEditingController();
  final _propPriceRangeController = TextEditingController();
  final _noOfBedroomsController = TextEditingController();
  final _priceMinController = TextEditingController();
  final _priceMaxController = TextEditingController();

  FToast fToast;

  bool sale = false;
  bool rent = false;
  String listingType = '';

  List<PropLandingData> _propertyList = List<PropLandingData>();

  void _getAllProperties() async {
    print('Get Properties');
    if (listingType.isEmpty) {
      snackBar('Please select either Rent or Sale', _scaffoldKey);
      return;
    }
    // if (_propPriceRangeController.text.isEmpty) {
    //   snackBar('Please enter price range', _scaffoldKey);
    //   return;
    // }

    var minPrice = _priceMinController.text;
    var maxPrice = _priceMaxController.text;
    var noOfRm = (_noOfBedroomsController.text  != "")
        ? int.parse(_noOfBedroomsController.text)
        : 0;
    var apType = _propTypeController.text;
    var _listingType = listingType;
    var propState = _propLocationController.text;
    showLoadingDialog(context, _keyLoader);
    DateTime sDate = DateTime.now();
    String sDateC = sDate.toString();
    var _apiCall = repo.searchPropertyPublic(
      '0',
      '100',
      '2020-01-01',
      formatDate(sDateC, pattern: 'yyyy-MM-dd'),
      minPrice,
      maxPrice,
      noOfRm,
      apType,
      _listingType,
      propState,
    );

    await _apiCall.then((value) {
      print('donnned ${value.data}');
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        setState(() => {_propertyList = value.data});
        Navigator.pushNamed(context, searchResultPubRoute, arguments: {
          'dataLoad': _propertyList,
          'listingType': _listingType
        });
        //_isPropLoaded = true;
      } else {
        //showInSnackBar(value.message);
        print('Failed to load properties');
      }
    }, onError: (e) {
      print(e);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    });
  }

  _setPriceRange() {
    Navigator.pop(context);
    setState(() {
      _propPriceRangeController.text = '${formatMoney(
        double.parse(_priceMinController.text),
      ).withoutFractionDigits} - ${formatMoney(double.parse(_priceMaxController.text)).withoutFractionDigits}';
    });
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast(context);
  }

  @override
  Widget build(BuildContext context) {
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
              saleRentButton(),
              const SizedBox(height: 10),
              inputlabel('Price Range', Icons.local_offer),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  showPriceRangeDialog(context);
                },
                child: AbsorbPointer(
                  child: InputFieldWidget(
                    '100,000 - 300,000',
                    TextInputType.number,
                    false,
                    controller: _propPriceRangeController,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              inputlabel('Bedrooms', Icons.hotel),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  showNumberDialog(
                      context, _noOfBedroomsController, 'Bedrooms');
                },
                child: AbsorbPointer(
                  child: InputFieldWidget(
                    'Select no of bedrooms',
                    TextInputType.number,
                    false,
                    controller: _noOfBedroomsController,
                  ),
                ),
              ),
              // const SizedBox(height: 20),
              // inputlabel('State', Icons.location_on),
              // const SizedBox(height: 8),
              // InputFieldWidget(
              //   'ex. Lagos State',
              //   TextInputType.text,
              //   false,
              //   controller: _propLocationController,
              // ),
              const SizedBox(height: 20),
              inputlabel('Type', Icons.home),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  showPropertyTypeDialog(context);
                },
                child: AbsorbPointer(
                  child: InputFieldWidget(
                    'Select Type',
                    TextInputType.text,
                    false,
                    controller: _propTypeController,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              RaisedButtonWidget(
                searchResultRoute,
                'Search',
                true,
                action: _getAllProperties,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
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
      // propertyType = dialogVal;
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
  Future showPriceRangeDialog(BuildContext context) async {
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
        contentPadding: EdgeInsets.all(20),
        title: Text(
          'Set Price Range',
          style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.normal),
        ),
        children: [
          Row(
            children: <Widget>[Text('Min Price')],
          ),
          const SizedBox(height: 4),
          InputFieldWidget(
            '',
            TextInputType.number,
            false,
            controller: _priceMinController,
            color: appColorSecondary,
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[Text('Max Price')],
          ),
          const SizedBox(height: 4),
          InputFieldWidget(
            '',
            TextInputType.number,
            false,
            controller: _priceMaxController,
            color: appColorSecondary,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              tapableText('Continue', _setPriceRange, color: appColorSecondary),
            ],
          ),
        ]);

    // show the dialog
    String dialogVal = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );

    setState(() {
      FocusScope.of(context).requestFocus(new FocusNode());
      //_controll.text = dialogVal;
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
                            color: appTextColorPrimary2, fontSize: 15),
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
