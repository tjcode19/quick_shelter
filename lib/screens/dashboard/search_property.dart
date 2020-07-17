import 'package:flutter/material.dart';
import 'package:quick_shelter/models/GetAllProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import '../../colors.dart';
import '../../widgets/input_field.dart';
import '../../widgets/input_label.dart';
import '../../widgets/raised_button.dart';

import '../../constants.dart';

class SearchProp extends StatefulWidget {
  @override
  _SearchPropState createState() => _SearchPropState();
}

class _SearchPropState extends State<SearchProp> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final _propTypeController = TextEditingController();
  final _propLocationController = TextEditingController();
  final _propPriceRangeController = TextEditingController();
  final _noOfBedroomsController = TextEditingController();

  bool sale = true;
  bool rent = false;
  String listingType = 'FOR RENT';

  List<GetAllPropData> _propertyList = List<GetAllPropData>();

  void _getAllProperties() async {
    print('Get Properties');
    showLoadingDialog(context, _keyLoader);
    var _apiCall = repo.getAllProperties('0', '10', '2020-01-01', '2020-07-11');

    await _apiCall.then((value) {
      print('donnned ${value.data}');
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        setState(() => {_propertyList = value.data});
        Navigator.pushNamed(context, searchResultRoute,
            arguments: _propertyList);
        //_isPropLoaded = true;
      } else {
        //showInSnackBar(value.message);
        print('Failed to load properties');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
              saleRentButton(),
              const SizedBox(height: 10),
              inputlabel('Price Range', Icons.local_offer),
              const SizedBox(height: 8),
              InputFieldWidget(
                '100,000 - 300,000',
                TextInputType.number,
                false,
                controller: _propPriceRangeController,
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
              const SizedBox(height: 20),
              inputlabel('Location', Icons.location_on),
              const SizedBox(height: 8),
              InputFieldWidget(
                'ex. Lekki Phase 1',
                TextInputType.text,
                false,
                controller: _propLocationController,
              ),
              const SizedBox(height: 20),
              inputlabel('Building Type', Icons.home),
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
