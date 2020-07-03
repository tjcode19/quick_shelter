import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_shelter/models/GetSavedProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';

import '../../colors.dart';
import '../../constants.dart';

class DashboardCollections extends StatefulWidget {
  @override
  _DashboardCollectionsState createState() => _DashboardCollectionsState();
}

class _DashboardCollectionsState extends State<DashboardCollections> {
  final QuickShelterRepository repo = QuickShelterRepository();
  List<GetSavedProperties> _propertyList = List<GetSavedProperties>();
  String listingType = "";
  bool sale = true;
  bool rent = false;
  
  ScrollController _controller;
  String message = "";
  bool _isVisible = true;
  String _prefUserFN;
  
  bool _isPropLoaded = false;

  void _getSavedProperties() async {
    print('Get User Properties');
    //showLoadingDialog(context, _keyLoader);
    var _apiCall = repo.getSavedProperties('0','10');

    await _apiCall.then((value) {
      print('donnned $value');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value != null) {
        setState(() => {
          _propertyList = value.getSavedProps,
          print(_propertyList[0].listingType)
        });
      } else {
        //showInSnackBar(value.message);
        print('Failed to load properties');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSavedProperties();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
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
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              child: Text(
                'Edit',
                style: TextStyle(color: appColorSecondary),
              ))
        ],
        title: RichText(
          text: TextSpan(
            text: 'Hi, ',
            style: TextStyle(fontSize: 16, color: appTextColorPrimary),
            children: <TextSpan>[
              TextSpan(
                text: 'Tolulope',
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
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'My Collections',
                  style: TextStyle(color: appSecondaryColor, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              saleRentButton(),
              
              Container(
                height: 400,
                child: CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(0),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 5,
                        childAspectRatio: ((itemWidth) / (itemHeight)),
                        mainAxisSpacing: 1,
                        crossAxisCount: 2,
                        children: 
                        _propertyList.map((e) => _propertItem(context)).toList(),
                        // <Widget>[
                        //   _propertItem(context),
                        //   _propertItem(context),
                        // ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _propertItem(ctxt) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        splashColor: Colors.orange.withAlpha(30),
        onTap: () {
          print('Card tapped.');
          Navigator.pushNamed(ctxt, collPropDetailsRoute);
        },
        child: Container(
          margin: EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/prop.png',
                width: 175,
                height: 123,
                fit: BoxFit.cover,
              ),
              Container(
                width: 172,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Text(
                      'N55,000,000',
                      style:
                          TextStyle(fontSize: 15, color: appTextColorPrimary),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Studio Apartment',
                      style:
                          TextStyle(fontSize: 13, color: appTextColorPrimary),
                    ),
                    const SizedBox(height: 10),
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
                              '23 Cross, HRBR layout, bangalore',
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
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
