import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_shelter/constants.dart';
import 'package:quick_shelter/models/GetUserProperties.dart';
import 'package:quick_shelter/utils/commonFunctions.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../colors.dart';

class UserPropertyDetails extends StatefulWidget {
  final propDetails;

  UserPropertyDetails({Key key, this.propDetails}) : super(key: key);
  @override
  _UserPropertyDetailsState createState() => _UserPropertyDetailsState();
}

class _UserPropertyDetailsState extends State<UserPropertyDetails> {
  bool rememberMe = false;
  GetUserPropData _propertyDetails;
  List<Photos> propPhotos = List<Photos>();
  String lDate, lType;
  int price;

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

  @override
  void initState() {
    super.initState();

    _propertyDetails = widget.propDetails['data'];
    price = 1;
    lType = "";
    //lDate = _propertyDetails.listings[0].listingDate;
    propPhotos = _propertyDetails.photos;
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
                    child: FadeInImage.memoryNetwork(
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
                // Container(
                //     padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.all(Radius.circular(6)),
                //     ),
                //     child: Text(lType)),
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
                  visible: (_currentPosition < (propPhotos.length - 1) ? true : false),
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
                          : BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.white54,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ),
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
                    const SizedBox(height: 10),
                    Container(
                      child: Text(
                        (_propertyDetails.title != null)?_propertyDetails.title: 'NA',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _propertyDetails.specifications.nOOFROOMS
                                  .toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            SizedBox(height: 5.0),
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
                        SizedBox(width: 20.0),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _propertyDetails.specifications.nOOFBATHROOMS
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
                      ],
                    ),
                    const SizedBox(height: 20),
                    Divider(color: Colors.white38, thickness: 1.0),
                    _rowCont('Location', _propertyDetails.location,
                        Icons.location_on),
                    Divider(color: Colors.white38, thickness: 1.0),
                    _rowCont('State', _propertyDetails.state, Icons.pin_drop),
                    Divider(color: Colors.white38, thickness: 1.0),
                    _rowCont('Land Area', _propertyDetails.landArea,
                        Icons.landscape),
                    Divider(color: Colors.white38, thickness: 1.0),
                    _rowCont(
                        'Available Date', (lDate != null)?formatDate(lDate):'NA', Icons.date_range),
                    Divider(color: Colors.white38, thickness: 1.0),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 50,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: OutlineButton(
                            padding: EdgeInsets.all(12),
                            color: Colors.white,
                            highlightedBorderColor: Colors.white,
                            borderSide: BorderSide(color: appTextColorPrimary2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(3),
                                bottomRight: Radius.circular(3),
                                bottomLeft: Radius.circular(3),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                                  child: Text(
                                    'Edit Property',
                                    style: TextStyle(
                                        color: appTextColorPrimary2,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, editPropMainRoute, arguments: {'data':_propertyDetails, 'refFunc':widget.propDetails['refFunc']});
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: RaisedButton(
                            padding: EdgeInsets.all(12),
                            highlightElevation: 5.0,
                            elevation: 3.0,
                            splashColor: Colors.orange[100],
                            highlightColor: Colors.orange[100],
                            color: appColorSecondary,
                            shape: RoundedRectangleBorder(
                              //borderRadius: new BorderRadius.circular(10.0),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(3),
                                bottomRight: Radius.circular(3),
                                bottomLeft: Radius.circular(3),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                                  child: Text(
                                    'Property Listings',
                                    style: TextStyle(
                                        color: appTextColorPrimary2,
                                        fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              // _settingModalBottomSheet(context);
                              //Navigator.pushNamed(context, propertyListingsRoute, arguments: _propertyDetails);
                              Navigator.pushNamed(context, propertyListingsRoute, arguments: {'data':_propertyDetails, 'refFunc':widget.propDetails['refFunc']});
                            },
                          ),
                        ),
                      ],
                    ),
                    // Container(
                    //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    //   child: OutlineButton(
                    //     padding: EdgeInsets.all(12),
                    //     color: Colors.white,
                    //     highlightedBorderColor: Colors.white,
                    //     borderSide: BorderSide(color: appTextColorPrimary2),
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.only(
                    //       topRight: Radius.circular(15),
                    //       topLeft: Radius.circular(3),
                    //       bottomRight: Radius.circular(3),
                    //       bottomLeft: Radius.circular(3),
                    //     )),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: <Widget>[
                    //         Container(
                    //           padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                    //           child: Text(
                    //             'Delete Property',
                    //             style: TextStyle(
                    //                 color: appTextColorPrimary2, fontSize: 15),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // ),
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
      margin: EdgeInsets.fromLTRB(0, 6, 0, 6),
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
              style: TextStyle(color: appTextColorPrimary2, fontSize: 15.0),
            ),
          ]),
          (title != 'Price')
              ? Container(
                  width: 170.0,
                  child: Text(
                    subTitle,
                    softWrap: true,
                    style: TextStyle(color: appTextColorPrimary2),
                    textAlign: TextAlign.right,
                  ),
                )
              : RichText(
                  text: TextSpan(
                    text: '₦',
                    style: TextStyle(fontSize: 15, color: appTextColorPrimary2),
                    children: <TextSpan>[
                      TextSpan(
                        text: subTitle,
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

class ImageList {
  ImageList(this.thumbnail, this.bigPix);
  final String thumbnail;
  final String bigPix;
}
