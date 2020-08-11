import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/models/GetUserProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/commonFunctions.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../constants.dart';

class PropertyListingDeatils extends StatefulWidget {
  final propDetails;
  PropertyListingDeatils({Key key, this.propDetails}) : super(key: key);

  @override
  _PropertyListingDeatilsState createState() => _PropertyListingDeatilsState();
}

class _PropertyListingDeatilsState extends State<PropertyListingDeatils> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ScrollController _controller;

  GetUserListings _propertyListDetails;

  String listingType = "";
  bool sale = true;
  bool rent = false;

  String stateSelection = "";
  bool _isVisible = true;

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _isVisible = false;
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        _isVisible = true;
        // _prefUserFN = _prefUserFN;
      });
    }
  }

  void _deleteListing() {
    var _apiCall = repo.deletePropListing(_propertyListDetails.iD.toString());

    _apiCall.then((value) {
      //print('donnned ${value.data}');
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        print('Listing deleted');

        //_showToast(value.responseMessage);
        // snackBar(value.responseMessage, _scaffoldKey, type: 'success');
        // Navigator.pop(context);
        widget.propDetails['refFunc']();
        int count = 0;
        Navigator.popUntil(context, (route) {
          return count++ == 4;
        });
      } else {
        // _showToast(value.responseMessage);
        print('Failed to load properties');
      }
    });
  }

  Future<bool> _onDeleteCall() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
          'Delete Listing?',
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 18,
              color: appColorSecondary),
        ),
        content: new Text('Are you sure you want to delete this listing?'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => {
              //SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop'),
              showLoadingDialog(context, _keyLoader),
              _deleteListing()
            },
            child: Text("YES"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _propertyListDetails = widget.propDetails['data'];
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
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Listing Details',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      addPropertyListingRoute,
                      arguments: {
                        'dataLoad': _propertyListDetails,
                        'type': 'edit',
                        'refFunc': widget.propDetails['refFunc']
                      },
                    );
                  },
                  child: Text(
                    'Edit Listing',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Divider(color: Colors.white38, thickness: 1.0),
            _rowCont('Listing Type', _propertyListDetails.listingType,
                Icons.location_on),
            Divider(color: Colors.white38, thickness: 1.0),
            _rowCont(
                'Price',
                (_propertyListDetails.price != null)
                    ? _propertyListDetails.price.toDouble()
                    : 'NA',
                Icons.pin_drop),
            Divider(color: Colors.white38, thickness: 1.0),
            _rowCont(
                'Available Date',
                (_propertyListDetails.availableFrom != null)
                    ? formatDate(_propertyListDetails.availableFrom)
                    : 'NA',
                Icons.pin_drop),
            Divider(color: Colors.white38, thickness: 1.0),
            _rowCont(
                'Listing Date',
                (_propertyListDetails.listingDate != null)
                    ? formatDate(_propertyListDetails.listingDate)
                    : 'NA',
                Icons.pin_drop),
            Visibility(
              visible: (_propertyListDetails.listingType == 'FOR RENT')
                  ? true
                  : false,
              child: Column(
                children: <Widget>[
                  Divider(color: Colors.white38, thickness: 1.0),
                  _rowCont(
                      'Minimum Period',
                      '${_propertyListDetails.minPeriod} ${_propertyListDetails.periodUnits}',
                      Icons.pin_drop),
                ],
              ),
            ),
            Divider(color: Colors.white38, thickness: 1.0),
            _rowCont(
                'Availability',
                (_propertyListDetails.iSAVAILABLE != false) ? 'Yes' : 'No',
                Icons.pin_drop),
            const SizedBox(height: 20),
            RaisedButtonWidget(
              addProperty2Route,
              'Delete Listing',
              true,
              action: _onDeleteCall,
            )
          ],
        ),
      ),
    );
  }

  _rowCont(String title, var subTitle, iconNew) {
    return Container(
      color: appTextColorPrimary,
      margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(children: [
            // Icon(
            //   iconNew,
            //   color: appTextColorPrimary2,
            //   size: 16.0,
            // ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              title,
              style: TextStyle(color: appTextColorPrimary2, fontSize: 16.0),
            ),
          ]),
          (title != 'Price')
              ? Container(
                  width: 170.0,
                  child: Text(
                    (subTitle != null) ? subTitle : 'NA',
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right,
                  ),
                )
              : RichText(
                  text: TextSpan(
                    text: '₦',
                    style: TextStyle(fontSize: 15, color: appTextColorPrimary2),
                    children: <TextSpan>[
                      TextSpan(
                        text: (subTitle != 'NA')
                            ? formatMoney(subTitle).withoutFractionDigits
                            : '0',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: '.00',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: appTextColorPrimary2,
                        ),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
