import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/models/GetAllProperties.dart';
import 'package:quick_shelter/models/GetUserProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/screens/dashboard/dashboard_collections.dart';
import 'package:quick_shelter/screens/dashboard/dashboard_listings.dart';
import 'package:quick_shelter/screens/get_started.dart';

import 'dashboard_home.dart';
import 'dashboard_transactions.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final QuickShelterRepository repo = QuickShelterRepository();
  static GetUserPropertiesM _propertyList; //= List<GetUserPropertiesM>();
  int _selectedIndex = 0;
  

  void _getUserProperties() async {
    print('Get User Properties');
    //showLoadingDialog(context, _keyLoader);
    var _apiCall = repo.getUserProperties();

    await _apiCall.then((value) {
      print('donnned $value');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value != null) {
        setState(() => {_propertyList = value});
        
        // _isPropLoaded = true;
      } else {
        //showInSnackBar(value.message);
        print('Failed to load properties');
      }
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
          DashboardHome(),
          DashboardListings(
            userPropListing: _propertyList,
          ),
          DashboardCollections(),
          DashboardTransactions(),
        ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onBackPressed() {
    if (_selectedIndex == 0) {
      return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text(
                'Logout!',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    color: appColorSecondary),
              ),
              content: new Text('Are you sure you want to logout?'),
              actions: <Widget>[
                new GestureDetector(
                  onTap: () => Navigator.of(context).pop(false),
                  child: Text("NO"),
                ),
                SizedBox(height: 16),
                new GestureDetector(
                  onTap: () => {
                    //SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop'),
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => GetStarted())),
                  },
                  child: Text("YES"),
                ),
              ],
            ),
          ) ??
          false;
    } else {
      _onItemTapped(0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_getUserProperties();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.hospitalBuilding),
              title: Text('Listing'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favourites'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('Transactions'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Color.fromRGBO(112, 112, 112, 1),
          onTap: _onItemTapped,
          backgroundColor: Color.fromRGBO(247, 247, 247, 1),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
