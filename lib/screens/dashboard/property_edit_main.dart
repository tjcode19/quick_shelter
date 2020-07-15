import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/models/GetUserProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';

import '../../constants.dart';

class PropertyEditMain extends StatefulWidget {
  final propDetails;
  PropertyEditMain({Key key, this.propDetails}) : super(key: key);

  @override
  _PropertyEditMainState createState() => _PropertyEditMainState();
}

class _PropertyEditMainState extends State<PropertyEditMain> {
  final QuickShelterRepository repo = QuickShelterRepository();
  // final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GetUserPropData _propertyList;

  String listingType = "";
  bool sale = true;
  bool rent = false;

  String stateSelection = "";

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
                'Edit Property',
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
                itemCount: 3,
                scrollDirection: Axis.vertical,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _eventData = [
    {'icon': Icon(Icons.note, color:appTextColorPrimary2), 'text': 'Update Property Details'},
    {'icon': Icon(Icons.camera_alt, color: appTextColorPrimary2,), 'text': 'Update Property Images'},
    {'icon': Icon(Icons.description, color: appTextColorPrimary2,), 'text': 'Update Property Document'},
  ];

  Widget _buildItemsForListView(BuildContext context, int index) {
    return _propertItem(context, index);
  }

  Widget _propertItem(ctxt, index) {
    return InkWell(
      splashColor: Colors.orange.withAlpha(30),
      onTap: () {
        print(_propertyList);
        String rt;
      switch (index) {
        case 0:
          rt = editPropDetailsRoute;
          break;
        default:
      }
        Navigator.pushNamed(
          ctxt,
          rt,
          arguments: {
            'pData': _propertyList,
            'refFunc': widget.propDetails['refFunc'],
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: appTextColorPrimary2),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12.0),
            topLeft: Radius.circular(3.0),
            bottomLeft: Radius.circular(3.0),
            bottomRight: Radius.circular(3.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _eventData[index]['icon'],
                SizedBox(width: 10,),
                Text(
                  _eventData[index]['text'],
                  style: TextStyle(color: appTextColorPrimary2),
                ),
              ],
            ),
            Icon(Icons.keyboard_arrow_right, color: appTextColorPrimary2,)
          ],
        ),
      ),
    );
  }
}
