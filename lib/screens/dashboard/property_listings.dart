import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/models/GetUserProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';

import '../../constants.dart';

class PropertyListings extends StatefulWidget {
  final propDetails;
  PropertyListings({Key key, this.propDetails}) : super(key: key);

  @override
  _PropertyListingsState createState() => _PropertyListingsState();
}

class _PropertyListingsState extends State<PropertyListings> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ScrollController _controller;

  GetUserPropData _propertyList;

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

  @override
  void initState() {
    super.initState();
    _propertyList = widget.propDetails['data'];
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Listing',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ]),
            const SizedBox(height: 30),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemBuilder: _buildItemsForListView,
                itemCount: _propertyList.listings.length,
                scrollDirection: Axis.vertical,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(
              context,
              addPropertyListingRoute,
              arguments: {'dataLoad': _propertyList, 'type': 'new', 'refFunc':widget.propDetails['refFunc']},
            );
          },
          // child: Icon(
          //   Icons.add,
          //   color: Colors.white,
          // ),
          // backgroundColor: Theme.of(context).primaryColor,
          label: Text(
            'Add Listing',
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Listing',
        ),
      ),
    );
  }

  Widget _buildItemsForListView(BuildContext context, int index) {
    return _propertItem(context, index);
  }

  Widget _propertItem(ctxt, index) {
    return InkWell(
      splashColor: Colors.orange.withAlpha(30),
      onTap: () {
        print('Property Listing tapped');
        Navigator.pushNamed(
          ctxt,
          propertyListingDetailsRoute,
          arguments: {'data':_propertyList.listings[index], 'refFunc':widget.propDetails['refFunc']},
        );
      },
      child: Container(
        height: 80,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.0),
            topLeft: Radius.circular(3.0),
            bottomLeft: Radius.circular(3.0),
            bottomRight: Radius.circular(3.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _propertyList.listings[index].listingType,
              style: TextStyle(color: Colors.white54),
            ),
            Text(
              (_propertyList.listings[index].iSAVAILABLE)
                  ? 'Available'
                  : 'Taken',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
