import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_shelter/constants.dart';
import 'package:quick_shelter/models/GetAllProperties.dart';
import 'package:quick_shelter/models/GetPublicProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/utils/commonFunctions.dart';
import 'package:quick_shelter/utils/sharedPreference.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../colors.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  SharedPreferenceQS _sharedPreferenceQS = SharedPreferenceQS();
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController _controller;
  String message = "";
  bool _isVisible = true;
  String _prefUserFN;
  List<PropLandingData> _propertyList = List<PropLandingData>();
  bool _isPropLoaded = false;

  int limit = 2;

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

  Future _getUserProfile() async {
    _prefUserFN = await _sharedPreferenceQS.getSharedPrefs(String, 'userFN');

    print('Where are you: $_prefUserFN');

    setState(() {
      _prefUserFN = _prefUserFN;
    });
  }

  void _getAllProperties() {
    print('Get Properties');
    //showLoadingDialog(context, _keyLoader);
    DateTime sDate = DateTime.now();
    String sDateC = sDate.toString();
    var _apiCall = repo.getAllPropLanding(
        '0', '100', '2020-01-01', formatDate(sDateC, pattern: 'yyyy-MM-dd'));

    _apiCall.then((value) {
      //print('donnned ${value.data}');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        value.data..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        setState(() => {_propertyList = value.data, _isPropLoaded = true});
      } else {
        //showInSnackBar(value.message);
        print('Failed to load properties');
      }
    });
  }

  Future<Null> _refresh() {
    // return getUser().then((_user) {
    //   setState(() => user = _user);
    // });
    DateTime sDate = DateTime.now();
    String sDateC = sDate.toString();
    var _apiCall = repo.getAllPropLanding(
        '0', '100', '2020-01-01', formatDate(sDateC, pattern: 'yyyy-MM-dd'));

    return _apiCall.then((value) {
      //print('donnned ${value.data}');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        value.data..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        setState(() => {_propertyList = value.data, _isPropLoaded = true});
      } else {
        //showInSnackBar(value.message);
        print('Failed to load properties');
      }
    });
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _getUserProfile();
    if (!_isPropLoaded) {
      _getAllProperties();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    final appBar = AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      // leading: Container(
      //   padding: EdgeInsets.all(8),
      //   child: ClipOval(
      //     child: Material(
      //       color: appTextColorPrimary2, // button color
      //       child: InkWell(
      //         splashColor: Colors.orange[100], // inkwell color
      //         child: Image.asset(
      //           'assets/images/person.png',
      //           color: appSecondaryColor,
      //           height: 24.0,
      //           width: 24.0,
      //         ),
      //         onTap: () {
      //           Navigator.pushNamed(context, profileRoute);
      //         },
      //       ),
      //     ),
      //   ),
      // ),
      title: RichText(
        text: TextSpan(
          text: 'Quick, ',
          style: TextStyle(fontSize: 16, color: appTextColorPrimary),
          children: <TextSpan>[
            TextSpan(
              text: 'Shelter',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CircleAvatar(
            backgroundColor: appTextColorPrimary,
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, searchPropPubRoute);
              },
            ),
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          //physics: const AlwaysScrollableScrollPhysics(),
          controller: _controller,
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sponsored Properties',
                      style:
                          TextStyle(color: appSecondaryColor, fontSize: 15.0),
                    )),
                _isPropLoaded
                    ? Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: 260.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _propertyList.length,
                          itemBuilder: _buildItemsForSponsored,
                        ),
                      )
                    : Container(
                        height: 260.0,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Available Properties',
                    style: TextStyle(color: appSecondaryColor, fontSize: 15.0),
                  ),
                ),
                const SizedBox(height: 10),
                _isPropLoaded
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height) *
                            0.6,
                        child: CustomScrollView(
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          primary: true,
                          slivers: <Widget>[
                            SliverPadding(
                              padding: const EdgeInsets.all(5),
                              sliver: SliverGrid.count(
                                crossAxisSpacing: 5,
                                childAspectRatio: (itemWidth / 300),
                                mainAxisSpacing: 1,
                                crossAxisCount: 2,
                                children: _propertyList
                                    .map((item) => _propertItem(
                                        _propertyList.indexOf(item)))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 260.0,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: AnimatedOpacity(
      //   opacity: _isVisible ? 1.0 : 0.0,
      //   duration: Duration(milliseconds: 500),
      //   child: FloatingActionButton.extended(
      //     heroTag: "dashHome",
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
      //     tooltip: 'Property',
      //   ),
      // ),
    );
  }

  Widget _propertItem(int index) => Card(
        elevation: 2.0,
        child: InkWell(
          splashColor: Colors.orange.withAlpha(30),
          onTap: () {
            print('Card tapped.');
            Navigator.pushNamed(context, propDetailsPublicRoute,
                arguments: _propertyList[index]);
          },
          child: Container(
            margin: EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Image.asset(
                //   'assets/images/prop.png',
                //   width: 175,
                //   height: 123,
                //   fit: BoxFit.cover,
                // ),
                Stack(alignment: Alignment.center, children: [
                  Container(child: CircularProgressIndicator()),
                  FadeInImage.memoryNetwork(
                    width: 175,
                    height: 123,
                    placeholder: kTransparentImage,
                    image: (_propertyList[index].property.photos.isNotEmpty)
                        ? _propertyList[index].property.photos[0].path
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
                      const SizedBox(height: 5),
                      // Text(
                      //   'NGN ${_formatMoney(_propertyList[index].price.toDouble()).withoutFractionDigits}',
                      //   style:
                      //       TextStyle(fontSize: 15, color: appTextColorPrimary),
                      // ),
                      RichText(
                        text: TextSpan(
                          text: '₦ ',
                          style: TextStyle(
                              fontSize: 13, color: appSecondaryColorLight),
                          children: <TextSpan>[
                            TextSpan(
                              text: (_propertyList[index].price != null)
                                  ? formatMoney(
                                          _propertyList[index].price.toDouble())
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
                      FittedBox(
                        child: Text(
                          (_propertyList[index].property.title != null)
                              ? (_propertyList[index].property.title.length >
                                      30)
                                  ? '${_propertyList[index].property.title.substring(0, 30)}...'
                                  : _propertyList[index].property.title
                              : 'NA',
                          style: TextStyle(
                              fontSize: 13, color: appTextColorPrimary),
                        ),
                      ),

                      const SizedBox(height: 5),
                      Container(
                        height: 30.0,
                        child: Row(
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
                                  _propertyList[index].property.location,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.black87),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/bed.svg',
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            ((_propertyList[index]
                                            .property
                                            .specifications
                                            .nOOFBEDROOMS ==
                                        null)
                                    ? 'NA'
                                    : '${_propertyList[index].property.specifications.nOOFBEDROOMS} Beds')
                                .toString(),
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0),
                          ),
                          const SizedBox(width: 15),
                          SvgPicture.asset(
                            'assets/icons/bath.svg',
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 5),
                          Text(
                              ((_propertyList[index]
                                              .property
                                              .specifications
                                              .nOOFBATHROOMS ==
                                          null)
                                      ? 'NA'
                                      : '${_propertyList[index].property.specifications.nOOFBATHROOMS} Baths')
                                  .toString(),
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

  Widget _buildItemsForSponsored(BuildContext context, int index) {
    return _propertItemSponsored(index);
  }

  Widget _propertItemSponsored(int index) => Container(
        child: Card(
          elevation: 2.0,
          child: InkWell(
            splashColor: Colors.orange.withAlpha(30),
            onTap: () {
              print('Card tapped.');
              Navigator.pushNamed(context, propDetailsPublicRoute,
                  arguments: _propertyList[index]);
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
                      height: 120,
                      placeholder: kTransparentImage,
                      image: (_propertyList[index].property.photos.isNotEmpty)
                          ? _propertyList[index].property.photos[0].path
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
                        const SizedBox(height: 5),
                        // Text(
                        //   'NGN ${_formatMoney(_propertyList[index].price.toDouble()).withoutFractionDigits}',
                        //   style:
                        //       TextStyle(fontSize: 15, color: appTextColorPrimary),
                        // ),
                        RichText(
                          text: TextSpan(
                            text: '₦ ',
                            style: TextStyle(
                                fontSize: 13, color: appSecondaryColorLight),
                            children: <TextSpan>[
                              TextSpan(
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
                        const SizedBox(height: 2),
                        Text(
                          (_propertyList[index].property.title != null)
                              ? (_propertyList[index].property.title.length >
                                      30)
                                  ? '${_propertyList[index].property.title.substring(0, 30)}...'
                                  : _propertyList[index].property.title
                              : 'NA',
                          style: TextStyle(
                              fontSize: 13, color: appTextColorPrimary),
                        ),

                        const SizedBox(height: 5),
                        Container(
                          // height: 30.0,
                          child: Row(
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
                                    _propertyList[index].property.location,
                                    softWrap: true,
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black87),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/icons/bed.svg',
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              ((_propertyList[index]
                                              .property
                                              .specifications
                                              .nOOFBEDROOMS ==
                                          null)
                                      ? 'NA'
                                      : '${_propertyList[index].property.specifications.nOOFBEDROOMS} Beds')
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 12.0),
                            ),
                            const SizedBox(width: 15),
                            SvgPicture.asset(
                              'assets/icons/bath.svg',
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 5),
                            Text(
                                ((_propertyList[index]
                                                .property
                                                .specifications
                                                .nOOFBATHROOMS ==
                                            null)
                                        ? 'NA'
                                        : '${_propertyList[index].property.specifications.nOOFBATHROOMS} Baths')
                                    .toString(),
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
        ),
      );
}
