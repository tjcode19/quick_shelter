import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_shelter/models/GetSavedProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/commonFunctions.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../colors.dart';
import '../../constants.dart';

class DashboardCollections extends StatefulWidget {
  method() => createState().refresh();

  @override
  _DashboardCollectionsState createState() => _DashboardCollectionsState();
}

class _DashboardCollectionsState extends State<DashboardCollections> {
  final QuickShelterRepository repo = QuickShelterRepository();
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  List<Data> _propertyList = List<Data>();
  List<Data> _propertyRentList = List<Data>();
  List<Data> saleList = List<Data>();
  List<Data> rentList = List<Data>();
  String listingType = "";
  bool sale = true;
  bool rent = false;
  String _prefUserFN;

  String message = "";

  // refresh() {
  //   print('refresh');
  //   // setState(() {
  //   _getSavedProperties();
  //   //});
  // }

  // PropertyDetails(
  //      refreshCallback: refresh,
  //   );

  refresh() => _getSavedPropert();

  void _getSavedPropert() async {
    List<Data> _propertyList = List<Data>();
    List<Data> _propertyRentList = List<Data>();
    List<Data> saleList = List<Data>();
    List<Data> rentList = List<Data>();
    print('Get Saved Properties');
    //showLoadingDialog(context, _keyLoader);
    var _apiCall = repo.getSavedProperties('0', '100');

    await _apiCall.then((value) {
      print('Saved Prop DONE ${value.responseCode}');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        print('Saved prop: ${value.data.length}');

        for (int l = 0; l < value.data.length; l++) {
          if (value.data[l].listingType != 'FOR RENT') {
            saleList.add(value.data[l]);
            // print('${saleList[l].listingType} Sales');
          } else {
            rentList.add(value.data[l]);
            //print('${rentList[l].listingType} Rent');
          }
        }

        setState(() => {
              _propertyList = saleList,
              _propertyRentList = rentList,
              if (_propertyList.length < 1)
                {
                  sale = false,
                  rent = true,
                }

              //print(_propertyRentList[0].price)
            });
      } else {
        //showInSnackBar(value.message);
        print('Failed to load properties');
      }
    });
  }

  void _getSavedProperties() async {
    print('Get Saved Properties');
    //showLoadingDialog(context, _keyLoader);
    var _apiCall = repo.getSavedProperties('0', '100');

    await _apiCall.then((value) {
      print('Saved Prop DONE ${value.responseCode}');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        print('Saved prop: ${value.data.length}');

        for (int l = 0; l < value.data.length; l++) {
          if (value.data[l].listingType != 'FOR RENT') {
            saleList.add(value.data[l]);
            // print('${saleList[l].listingType} Sales');
          } else {
            rentList.add(value.data[l]);
            //print('${rentList[l].listingType} Rent');
          }
        }

        setState(() => {
              _propertyList = saleList,
              _propertyRentList = rentList,
              if (_propertyList.length < 1)
                {
                  sale = false,
                  rent = true,
                },

              //print(_propertyRentList[0].price)
            });
      } else {
        //showInSnackBar(value.message);
        print('Failed to load properties');
      }
    });
  }

  Future<Null> _refresh() {
    print('Refresh Properties');
    //showLoadingDialog(context, _keyLoader);
    var _apiCall = repo.getSavedProperties('0', '100');

    return _apiCall.then((value) {
      print('Saved Prop DONE ${value.responseCode}');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        print('Saved prop: ${value.data.length}');

        for (int l = 0; l < value.data.length; l++) {
          if (value.data[l].listingType != 'FOR RENT') {
            saleList.add(value.data[l]);
            // print('${saleList[l].listingType} Sales');
          } else {
            rentList.add(value.data[l]);
            //print('${rentList[l].listingType} Rent');
          }
        }

        setState(() => {
              _propertyList = saleList,
              _propertyRentList = rentList,
              if (_propertyList.length < 1)
                {
                  sale = false,
                  rent = true,
                },

              //print(_propertyRentList[0].price)
            });
      } else {
        //showInSnackBar(value.message);
        print('Failed to load properties');
      }
    });
  }

  Future _getUserProfile() async {
    _prefUserFN = await _sharedPreferenceQS.getSharedPrefs(String, 'userFN');
    setState(() {
      _prefUserFN = _prefUserFN;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSavedProperties();
    _getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    final appBar = AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: Container(
        padding: EdgeInsets.all(8),
        child: ClipOval(
          child: Material(
            color: appTextColorPrimary2, // button color
            child: InkWell(
              splashColor: Colors.orange[100], // inkwell color
              child: Image.asset(
                'assets/images/person.png',
                color: appSecondaryColor,
                height: 24.0,
                width: 24.0,
              ),
              onTap: () {
                Navigator.pushNamed(context, profileRoute);
              },
            ),
          ),
        ),
      ),
      title: RichText(
        text: TextSpan(
          text: 'Hi, ',
          style: TextStyle(fontSize: 16, color: appTextColorPrimary),
          children: <TextSpan>[
            TextSpan(
              text: '$_prefUserFN',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'My Collections',
                  style: TextStyle(
                      color: appSecondaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              saleRentButton(),
              (_propertyList != null)
                  ? Container(
                      height: (size.height - appBar.preferredSize.height) * 0.62,
                      child: CustomScrollView(
                        primary: false,
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(0),
                            sliver: SliverGrid.count(
                              crossAxisSpacing: 5,
                              childAspectRatio: (itemWidth / 270),
                              mainAxisSpacing: 1,
                              crossAxisCount: 2,
                              children: (sale)
                                  ? _propertyList
                                      .map((e) => _propertItem(
                                          _propertyList.indexOf(e)))
                                      .toList()
                                  : _propertyRentList
                                      .map((e) => _propertItem(
                                          _propertyRentList.indexOf(e)))
                                      .toList(),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Text('No Record Found'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _propertItem(index) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        splashColor: Colors.orange.withAlpha(30),
        onTap: () {
          print('Transaction tapped.');

          Navigator.pushNamed(context, collPropDetailsRoute,
              arguments:
                  (sale) ? _propertyList[index] : _propertyRentList[index]);
        },
        child: Container(
          margin: EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (sale)
                  ? Stack(alignment: Alignment.center, children: [
                      Container(child: CircularProgressIndicator()),
                      FadeInImage.memoryNetwork(
                        width: 175,
                        height: 120,
                        placeholder: kTransparentImage,
                        image: (_propertyList[index].property.photos.isNotEmpty)
                            ? _propertyList[index].property.photos[0].path
                            : 'https://picsum.photos/250?image=9',
                        fit: BoxFit.cover,
                      ),
                    ])
                  : Stack(alignment: Alignment.center, children: [
                      Container(child: CircularProgressIndicator()),
                      FadeInImage.memoryNetwork(
                        width: 175,
                        height: 123,
                        placeholder: kTransparentImage,
                        image: (_propertyRentList[index]
                                .property
                                .photos
                                .isNotEmpty)
                            ? _propertyRentList[index].property.photos[0].path
                            : 'https://picsum.photos/250?image=9',
                        fit: BoxFit.cover,
                      ),
                    ]),
              Container(
                width: 172,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                        text: '₦ ',
                        style: TextStyle(
                            fontSize: 13, color: appSecondaryColorLight),
                        children: <TextSpan>[
                          (sale)
                              ? TextSpan(
                                  text: (_propertyList[index].price != null)
                                      ? formatMoney(_propertyList[index]
                                              .price
                                              .toDouble())
                                          .withoutFractionDigits
                                      : '0',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: appTextColorPrimary,
                                  ),
                                )
                              : TextSpan(
                                  text: (_propertyRentList[index].price != null)
                                      ? formatMoney(_propertyRentList[index]
                                              .price
                                              .toDouble())
                                          .withoutFractionDigits
                                      : '0',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: appTextColorPrimary,
                                  ),
                                ),
                          TextSpan(
                            text: '.00',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: appSecondaryColorLight,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Studio Apartment',
                      style:
                          TextStyle(fontSize: 13, color: appTextColorPrimary),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 2.0),
                          child: Icon(
                            Icons.location_on,
                            size: 10,
                            color: Colors.orange,
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: Text(
                              (sale)
                                  ? _propertyList[index].property.location
                                  : _propertyRentList[index].property.location,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 17),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/bed.svg',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        Text('3 Bed',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0)),
                        const SizedBox(width: 15),
                        SvgPicture.asset(
                          'assets/icons/bath.svg',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        Text('2 Bath',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
                        style:
                            TextStyle(color: appTextColorPrimary, fontSize: 13),
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
                  color: appTextColorPrimary,
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
                              color: appTextColorPrimary2, fontSize: 15),
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
                          TextStyle(color: appTextColorPrimary, fontSize: 15),
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
                    color: appTextColorPrimary,
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
                                color: appTextColorPrimary2, fontSize: 15),
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
