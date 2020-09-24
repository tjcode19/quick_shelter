import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_shelter/models/GetPublicProperties.dart';
// import 'package:quick_shelter/models/GetSavedProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/commonFunctions.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/raised_button.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../colors.dart';
import '../../constants.dart';

class CollPropertyDetailsSearched extends StatefulWidget {
  final propDetails;

  CollPropertyDetailsSearched({Key key, this.propDetails}) : super(key: key);
  @override
  _CollPropertyDetailsSearchedState createState() =>
      _CollPropertyDetailsSearchedState();
}

class _CollPropertyDetailsSearchedState
    extends State<CollPropertyDetailsSearched> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final QuickShelterRepository repo = QuickShelterRepository();
  bool rememberMe = false;
  PropLandingData _propertyDetails;
  List<Photos> propPhotos = List<Photos>();

  // var ls = [
  //   ImageList('assets/images/1_thumbnail.png', 'assets/images/1_big.png'),
  //   ImageList('assets/images/2_thumbnail.png', 'assets/images/2_big.png'),
  //   ImageList('assets/images/3_thumbnail.png', 'assets/images/3_big.png'),
  //   ImageList('assets/images/3_thumbnail.png', 'assets/images/3_big.png'),
  // ];

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

  _makePayment() {
    showLoadingDialog(context, _keyLoader);
    print(_propertyDetails.iD);
    var _apiCall = repo.doPayment(_propertyDetails.iD);

    _apiCall.then((value) async {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode &&
          value.data.status != false) {
        print('Auth: ${value.data.data.reference}');
        if (value.data.data.authorizationUrl != null) {
          Navigator.pushNamed(context, paymentWebviewRoute, arguments: value);
        } else {
          snackBar('Payment cannot be completed', _scaffoldKey);
        }
      } else {
        //showInSnackBar(value.message);
        print('Payment failed');
        snackBar(value.responseMessage, _scaffoldKey);
      }
    }, onError: (e) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      snackBar('Payment failed', _scaffoldKey);
      print('Payment failed $e');
    });
  }

  @override
  void initState() {
    super.initState();

    _propertyDetails = widget.propDetails;
    propPhotos = _propertyDetails.property.photos;
  }

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;
    return Scaffold(
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
          IndexedStack(
            index: _currentPosition,
            children: propPhotos
                .map(
                  (e) => Container(
                    height: screeSize.height / 2 + 50,
                    constraints: BoxConstraints.loose(Size.infinite),
                    child:
                        // Image.asset(
                        //   e.path,
                        //   fit: BoxFit.cover,
                        // ),
                        FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: (propPhotos.isNotEmpty)
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
                  visible: (_currentPosition < (propPhotos.length - 1)
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
                children: propPhotos.map((e) {
                  int indexL = propPhotos.indexOf(e);
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
                          image: (propPhotos.isNotEmpty)
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
                          'Studio Apartment, Fully Furnished',
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
                              text: (_propertyDetails.price != null)
                                  ? formatMoney(
                                          _propertyDetails.price.toDouble())
                                      .withoutFractionDigits
                                  : '0',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: '00',
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
                                color: appColorSecondary, // button color
                                child: InkWell(
                                  splashColor: Colors.orange, // inkwell color
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.favorite,
                                        size: 25, color: Colors.white),
                                  ),
                                  onTap: () {
                                    // Navigator.pushNamed(context, profileRoute);
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
                        formatDate(_propertyDetails.listingDate),
                        Icons.date_range),
                    Divider(color: Colors.white38, thickness: 1.0),
                    const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: <Widget>[
                    //     Container(
                    //       width: MediaQuery.of(context).size.width / 2 - 50,
                    //       margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    //       child: OutlineButton(
                    //         padding: EdgeInsets.all(10),
                    //         color: Colors.white,
                    //         highlightedBorderColor: Colors.white,
                    //         borderSide: BorderSide(color: appTextColorPrimary2),
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.only(
                    //                 topRight: Radius.circular(15))),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: <Widget>[
                    //             Container(
                    //               padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                    //               child: Text(
                    //                 'Delete Property',
                    //                 style: TextStyle(
                    //                     color: appTextColorPrimary2,
                    //                     fontSize: 15),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         onPressed: () {
                    //           Navigator.pop(context);
                    //         },
                    //       ),
                    //     ),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width / 2 - 20,
                    //       margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    //       child: RaisedButton(
                    //         padding: EdgeInsets.all(10),
                    //         highlightElevation: 5.0,
                    //         elevation: 3.0,
                    //         splashColor: Colors.orange[100],
                    //         highlightColor: Colors.orange[100],
                    //         color: appColorSecondary,
                    //         shape: RoundedRectangleBorder(
                    //             //borderRadius: new BorderRadius.circular(10.0),
                    //             borderRadius: BorderRadius.only(
                    //                 topRight: Radius.circular(20))),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: <Widget>[
                    //             Container(
                    //               padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                    //               child: Text(
                    //                 'Edit Property',
                    //                 style: TextStyle(
                    //                     color: appTextColorPrimary2,
                    //                     fontSize: 15),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         onPressed: () {
                    //           // _settingModalBottomSheet(context);
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    (_propertyDetails.listingType == 'FOR SALE')
                        ? RaisedButtonWidget(
                            'pop',
                            'Buy Property',
                            true,
                            action: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Container(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Login Required',
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 15),
                                          RaisedButtonWidget(
                                            loginRoute,
                                            'Login Here',
                                            true,
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            'OR',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 15),
                                          RaisedButtonWidget(
                                            signUpRoute,
                                            'Create Account',
                                            false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : RaisedButtonWidget(
                            'pop',
                            'Rent Property',
                            true,
                            action: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Container(
                                      height: 200,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Login Required',
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 15),
                                          RaisedButtonWidget(
                                            loginRoute,
                                            'Login Here',
                                            true,
                                          ),
                                          SizedBox(height: 15),
                                          Text(
                                            'OR',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(height: 15),
                                          RaisedButtonWidget(
                                            signUpRoute,
                                            'Create Account',
                                            false,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
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
