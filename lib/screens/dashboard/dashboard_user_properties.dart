import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_shelter/models/GetUserProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../colors.dart';
import '../../constants.dart';

class DashboardUserProperties extends StatefulWidget {
  final userPropListing;

  DashboardUserProperties({Key key, this.userPropListing}) : super(key: key);

  @override
  _DashboardUserPropertiesState createState() =>
      _DashboardUserPropertiesState();
}

class _DashboardUserPropertiesState extends State<DashboardUserProperties> {
  final QuickShelterRepository repo = QuickShelterRepository();
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  String message = "";
  List<GetUserPropData> _propertyList = List<GetUserPropData>();
  List<GetUserProperties> _propertyRentList = List<GetUserProperties>();
  ScrollController _controller;
  String listingType = "";
  bool sale = true;
  bool rent = false;
  String _prefUserFN;
  bool _isVisible = true;

  refresh() {
    print('refresh');
    // setState(() {
    _getUserProperties();
    //});
  }

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
        _prefUserFN = _prefUserFN;
      });
    }
  }

  void _getUserProperties() async {
    print('Get User Properties');
    //showLoadingDialog(context, _keyLoader);
    var _apiCall = repo.getUserProperties();

    await _apiCall.then((value) {
      print('DONE Get User Prop ${value.responseCode}');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        value.dataVal..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        setState(() => {
              _propertyList = value.dataVal,
              // print(_propertyList[0])
            });
      } else {
        //showInSnackBar(value.message);
        print('Failed to load properties');
      }
    },
    onError: (e){

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
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _getUserProperties();
    _getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
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
        actions: <Widget>[
          // Container(
          //     margin: EdgeInsets.symmetric(horizontal: 5),
          //     alignment: Alignment.center,
          //     child: Text(
          //       'Edit',
          //       style: TextStyle(color: appColorSecondary),
          //     ))
        ],
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
      ),
      body: SingleChildScrollView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'My Properties',
                  style: TextStyle(
                      color: appSecondaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              // saleRentButton(),
              Container(
                height: size.height,
                child: (_propertyList.length > 0)
                    ? CustomScrollView(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        slivers: <Widget>[
                          SliverPadding(
                            padding: const EdgeInsets.all(0),
                            sliver: SliverGrid.count(
                              crossAxisSpacing: 5,
                              childAspectRatio: ((itemWidth) / (itemHeight)),
                              mainAxisSpacing: 1,
                              crossAxisCount: 2,
                              children: _propertyList
                                  .map((e) =>
                                      _propertItem(_propertyList.indexOf(e)))
                                  .toList(),
//                        <Widget>[
//                          _propertItem(context),
//                          _propertItem(context),
//                        ],
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'You are yet to add any properties',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: AnimatedOpacity(
      //   opacity: _isVisible ? 1.0 : 0.0,
      //   duration: Duration(milliseconds: 500),
      //   child: FloatingActionButton.extended(
      //     onPressed: () {
      //       Navigator.pushNamed(context, addPropertyRoute);
      //     },
      //     // child: Icon(
      //     //   Icons.add,
      //     //   color: Colors.white,
      //     // ),
      //     // backgroundColor: Theme.of(context).primaryColor,
      //     label: Text(
      //       'New Property',
      //       style: TextStyle(fontSize: 14.0, color: Colors.white),
      //     ),
      //     icon: Icon(
      //       Icons.add,
      //       color: Colors.white,
      //     ),
      //     backgroundColor: Theme.of(context).primaryColor,
      //     tooltip: 'Propertyu',
      //   ),
      // ),
    );
  }

  Widget _propertItem(index) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        splashColor: Colors.orange.withAlpha(30),
        onTap: () {
          Navigator.pushNamed(
            context,
            userPropertyDetailsRoute,
            arguments: {'data': _propertyList[index], 'refFunc': refresh},
          );
        },
        child: Container(
          margin: EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(alignment: Alignment.center, children: [
                Container(child: CircularProgressIndicator()),
                FadeInImage.memoryNetwork(
                  width: 175,
                  height: 128,
                  placeholder: kTransparentImage,
                  image: (_propertyList[index].photos.isNotEmpty)
                      ? _propertyList[index].photos[0].path
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
                    Text(
                      (_propertyList[index].title != null)
                          ? _propertyList[index].title
                          : 'NA',
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
                              _propertyList[index].location,
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/bed.svg',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        Text(
                            '${_propertyList[index].specifications.nOOFROOMS} Bed',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0)),
                        const SizedBox(width: 15),
                        SvgPicture.asset(
                          'assets/icons/bath.svg',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        Text(
                            '${_propertyList[index].specifications.nOOFBATHROOMS} Bath',
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
