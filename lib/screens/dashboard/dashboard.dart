import 'package:flutter/material.dart';
import 'package:quick_shelter/screens/dashboard/dashboard_collections.dart';
import 'package:quick_shelter/screens/get_started.dart';

import 'dashboard_home.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
     DashboardHome(),
     DashboardCollections(),
    // DashboardLoanHistory(),
    // DashboardAccount(),
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
              title: new Text('Logout!'),
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => GetStarted())),
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
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(       
        body:  IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
          
        
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.account_balance_wallet),
            //   title: Text('Add Property'),
            // ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Collections'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              title: Text('History'),
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