import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_shelter/models/GetAllProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/screens/dashboard/dashboard_collections.dart';
import 'package:quick_shelter/utils/commonFunctions.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/raised_button.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../colors.dart';
import '../../constants.dart';

class PropertyDetails extends StatefulWidget {
  final propertyDetails;
  const PropertyDetails({Key key, this.propertyDetails}):super(key:key);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool rememberMe = false;
  GetAllPropData _propertyDetails;
  bool _isSaved = false;

  //final userColl = DashboardCollections();

 
  int imageNum = 0;
  int _currentPosition = 0;

  void _toggleFavorite(pos, action, eventY) {
    setState(() {
      print('SetState: $_currentPosition');
      if (eventY == 'addSub') {
        if (action == 'add') {
          _currentPosition += 1;
        } else {
          _currentPosition -= 1;
        }
      } else {
        _currentPosition = pos;
      }
      print('SetStateLater: $_currentPosition');
    });
  }

  _saveProperty() {
    if (_isSaved) {
      var _apiCall = repo.addSavedListing(_propertyDetails.iD);

      _apiCall.then((value) async {
        print('Property Saved ${value.responseCode} ');
        if (value.responseCode == globalSuccessResponseCode) {
          // Navigator.pushNamed(context, dashboardRoute);
          print('Property Listing Saved');
          DashboardCollections().method();
          //widget?._callback();
        } else {
          //showInSnackBar(value.message);
          print('Saving property failed');
        }
      },onError: (e){
         print('Saving property failed $e');
      });
    } else {}
  }

  _makePayment() {
    showLoadingDialog(context, _keyLoader);
    print(_propertyDetails.iD);
      var _apiCall = repo.doPayment(_propertyDetails.iD);

      _apiCall.then((value) async {
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        if (value.responseCode == globalSuccessGetResponseCode && value.data.status!=false) {          
         print('Auth: ${value.data.data.authorizationUrl}');
         if(value.data.data.authorizationUrl != null){
           Navigator.pushNamed(context, paymentWebviewRoute, arguments: value);
         }
         else{
           snackBar('Payment cannot be completed', _scaffoldKey);
         }
           
        } else {
          //showInSnackBar(value.message);     
          print('Payment failed');     
          snackBar(value.responseMessage, _scaffoldKey);
        }
      }, onError: (e){
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
        snackBar('Payment failed', _scaffoldKey);
        print('Payment failed $e');
      });
  }

  @override
  void initState() {
    super.initState();

    _propertyDetails = widget.propertyDetails;
  }

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/1_big.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Stack(
          //         alignment: Alignment.center,
          //         children: [
          //         Container(
          //           child: CircularProgressIndicator()),
          //         FadeInImage.memoryNetwork(
          //           width: 175,
          //           height: 123,
          //           placeholder: kTransparentImage,
          //           image: (_propertyDetails.photos.isNotEmpty)
          //               ? _propertyDetails.photos[0].path
          //               : 'https://picsum.photos/250?image=9',
          //           fit: BoxFit.cover,
          //         ),
          //       ]),

          IndexedStack(
            index: _currentPosition,
            children: _propertyDetails.property.photos
                .map(
                  (e) => Container(
                    height: screeSize.height / 2 + 50,
                    constraints: BoxConstraints.loose(Size.infinite),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: (_propertyDetails.property.photos.isNotEmpty)
                          ? e.path
                          : 'https://picsum.photos/250?image=9',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                .toList(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: IconButton(
                    color: Theme.of(context).primaryColor,
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: appColorSecondary,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Text(_propertyDetails.listingType)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, screeSize.height / 3 - 50, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Visibility(
                  visible: (_currentPosition != 0 ? true : false),
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: appColorSecondary,
                          ),
                        ),
                        onTap: () {
                          print(_currentPosition);
                          _toggleFavorite(0, 'sub', 'addSub');
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: (_currentPosition <
                          (_propertyDetails.property.photos.length - 1)
                      ? true
                      : false),
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: appColorSecondary,
                          ),
                        ),
                        onTap: () {
                          print(_currentPosition);
                          _toggleFavorite(0, 'add', 'addSub');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, screeSize.height / 3 + 40, 10, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _propertyDetails.property.photos.map((e) {
                  int indexL = _propertyDetails.property.photos.indexOf(e);
                  return GestureDetector(
                    onTap: () {
                      print(indexL);
                      _toggleFavorite(indexL, 'click', 'clicking');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: (indexL == _currentPosition)
                          ? BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: appColorSecondary,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            )
                          : null,
                      child: Stack(alignment: Alignment.center, children: [
                        Container(child: CircularProgressIndicator()),
                        FadeInImage.memoryNetwork(
                          width: 55,
                          height: 55,
                          placeholder: kTransparentImage,
                          image: (_propertyDetails.property.photos.isNotEmpty)
                              ? e.path
                              : 'https://picsum.photos/250?image=9',
                          fit: BoxFit.cover,
                        ),
                      ]),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(129, 92, 67, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              width: screeSize.width,
              height: screeSize.height / 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          (_propertyDetails.property.title != null)
                            ? (_propertyDetails.property.title.length > 50)
                                ? '${_propertyDetails
                                    .property
                                    .title
                                    .substring(0, 50)} ...'
                                : _propertyDetails.property.title
                            : 'NA',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(height: 10),
                    Container(
                      child: RichText(
                        text: TextSpan(
                          text: '₦',
                          style: TextStyle(
                              fontSize: 22, color: appTextColorPrimary2),
                          children: <TextSpan>[
                            TextSpan(
                              text:(_propertyDetails.price!=null)?
                                  formatMoney(_propertyDetails.price.toDouble())
                                      .withoutFractionDigits:'0',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: '.00',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                                color: appTextColorPrimary2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _propertyDetails
                                  .property.specifications.nOOFBEDROOMS
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/bed.svg',
                                  color: Colors.white,
                                  width: 25,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Bedrooms',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // SizedBox(width: 20.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _propertyDetails
                                  .property.specifications.nOOFBATHROOMS
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/icons/bath.svg',
                                  color: Colors.white,
                                  width: 25,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Bathroom',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            ClipOval(
                              child: Material(
                                color: (_isSaved)
                                    ? appColorSecondary
                                    : Colors.grey, // button color
                                child: InkWell(
                                  splashColor: Colors.orange, // inkwell color
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.favorite,
                                        size: 25, color: Colors.white),
                                  ),
                                  onTap: () {
                                    // Navigator.pushNamed(context, profileRoute);
                                    setState(() {
                                      _isSaved = !_isSaved;
                                      _saveProperty();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 25),
                    Container(
                      child: Text(
                        'Property Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    _rowCont('Location', _propertyDetails.property.location,
                        Icons.location_on),
                    Divider(color: Colors.white38, thickness: 1.0),
                    _rowCont('State', _propertyDetails.property.state,
                        Icons.pin_drop),
                    Divider(color: Colors.white38, thickness: 1.0),
                    _rowCont('Land Area', _propertyDetails.property.landArea,
                        Icons.landscape),
                    Divider(color: Colors.white38, thickness: 1.0),
                    _rowCont(
                        'Available date',
                        (_propertyDetails.listingDate != null)
                            ? formatDate(_propertyDetails.listingDate)
                            : 'NA',
                        Icons.date_range),
                    Divider(color: Colors.white38, thickness: 1.0),
                    const SizedBox(height: 20),
                    (_propertyDetails.listingType == 'FOR SALE')
                        ? RaisedButtonWidget(
                            'pop',
                            'Buy Property',
                            true,
                            action: _makePayment,
                          )
                        : RaisedButtonWidget(
                            'pop',
                            'Rent Property',
                            true,
                            action: _makePayment,
                          ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _rowCont(String title, String subTitle, iconNew) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(children: [
            Icon(
              iconNew,
              color: appTextColorPrimary2,
              size: 16.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              title,
              style: TextStyle(color: appTextColorPrimary2),
            ),
          ]),
          Container(
            width: 170.0,
            child: Text(
              subTitle,
              softWrap: true,
              style: TextStyle(color: appTextColorPrimary2),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageList {
  ImageList(this.thumbnail, this.bigPix);
  final String thumbnail;
  final String bigPix;
}
