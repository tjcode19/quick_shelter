import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/models/GetPropertyListingReq.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/screens/dashboard/file_upload.dart';

import '../../constants.dart';

class AddPropStep4 extends StatefulWidget {
  final propertyData;

  const AddPropStep4({Key key, this.propertyData}) : super(key: key);

  @override
  _AddPropStep4State createState() => _AddPropStep4State();
}

class _AddPropStep4State extends State<AddPropStep4> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  var _propertyListingReq = List<Data>();
  // Iterable list;

  int selectedItemId;
  int propertyID;

  Future _getPropertListingReq() async {
    print('Get Properties Listing Req ${widget.propertyData['listingType']}');

    var _apiCall =
        repo.getPropertyListingReq(widget.propertyData['listingType']);

    await _apiCall.then((value) {
      print('donnned ${value.responseCode}');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessGetResponseCode) {
        setState(() => {
              _propertyListingReq = value.data,
            });
      } else {
        //showInSnackBar(value.message);
      }
    });
    print(_propertyListingReq);
  }

  @override
  void initState() {
    super.initState();
    _getPropertListingReq();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, dashboardRoute);
        return false;
      },
      child: Scaffold(
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
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upload Documents (Optional)',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Step 5 of 5',
                        style: TextStyle(color: Colors.white70, fontSize: 14.0),
                        textAlign: TextAlign.center,
                      )
                    ]),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 4,
                        ),
                        child: Text(
                          'Legal Required Documents',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Divider(color: Colors.white38, thickness: 1.0),
                // _rowCont('Certificate of occupancy', 'Approved', Icons.check),
                // Divider(color: Colors.white38, thickness: 1.0),
                // _rowCont('Deed of assignment', 'Approved', Icons.check),
                // Divider(color: Colors.white54, thickness: 1.0),
                // _rowCont('Deed of lease', 'Approved', Icons.check),
                // Divider(color: Colors.white54, thickness: 1.0),
                // _rowCont('Deed of Sublease', 'Approved', Icons.clear),
                // Divider(color: Colors.white54, thickness: 1.0),
                // _rowCont('Land Certificate', 'Approved', Icons.remove),
                // Divider(color: Colors.white54, thickness: 1.0),
                // _rowCont('Deed of Mortgate', 'Approved', Icons.remove),
                // Divider(color: Colors.white54, thickness: 1.0),
                // _rowCont('Survey Plans', 'Approved', Icons.remove),
                // Divider(color: Colors.white54, thickness: 1.0),

                //             [for (MapEntry entry in _propertyListingReq.asMap().entries)
                //   _rowCont(entry.key, entry.value.toString(), Icons.remove)
                // ],
                //           ),
                // ListView.builder(
                //     scrollDirection: Axis.vertical,
                //     itemCount: _propertyListingReq.length,
                //     itemBuilder: _buildItemsForListView,)

                //     // for (var item in _propertyListingReq)
                //     // //Text(item.name)
                //     //   _rowCont(item.name, item.description, Icons.remove)
                //   ,
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  height: MediaQuery.of(context).size.height - 250,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: _propertyListingReq.length,
                    itemBuilder: _buildItemsForListView,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 40,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: OutlineButton(
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        highlightedBorderColor: Colors.white,
                        borderSide: BorderSide(color: appTextColorPrimary2),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                    color: appTextColorPrimary2, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          _settingModalBottomSheet(context);
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 30,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: RaisedButton(
                        padding: EdgeInsets.all(10),
                        highlightElevation: 5.0,
                        elevation: 3.0,
                        splashColor: Colors.orange[100],
                        highlightColor: Colors.orange[100],
                        color: appColorSecondary,
                        shape: RoundedRectangleBorder(
                            //borderRadius: new BorderRadius.circular(10.0),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                              child: Text(
                                'Add Document',
                                style: TextStyle(
                                    color: appTextColorPrimary2, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          //_addProperty();
                          _settingModalBottomSheet(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemsForListView(BuildContext context, int index) {
    return _rowCont(index);
  }

  Widget _rowCont(int index) => InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FileUpload(
                docType: _propertyListingReq[index].name,
                docTypeId: index,
                propertyID: widget.propertyData['propID'],
              ),
            ),
          );

          setState(() {
            _propertyListingReq[result['id']].status = result['status'];

            print('Hello ${result['status']}');
          });
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _propertyListingReq[index].name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _propertyListingReq[index].description,
                      style: TextStyle(color: appTextColorPrimary2),
                      softWrap: true,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Icon(
                (_propertyListingReq[index].status) ? Icons.check : Icons.close,
                color: appTextColorPrimary2,
              ),
            ],
          ),
        ),
      );

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          margin: EdgeInsets.only(right: 0, left: 0),
          decoration: BoxDecoration(
              color: appSecondaryColor,
              //borderRadius: BorderRadius.all(Radius.circular(15)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(blurRadius: 5, color: Colors.white, spreadRadius: 1)
              ]),
          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle_outline,
                size: 100,
                color: appTextColorPrimary2,
              ),
              const SizedBox(
                  height:
                      10), //You have successfully added a new property to your collections.
              Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(
                    'Yay! New property Added',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 10),
              Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    'You have successfully added a new property to your collections.',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: OutlineButton(
                      padding: EdgeInsets.all(10),
                      color: Colors.white,
                      highlightedBorderColor: Colors.white,
                      borderSide: BorderSide(color: appTextColorPrimary2),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(15))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                            child: Text(
                              'Dismiss',
                              style: TextStyle(
                                  color: appTextColorPrimary2, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, dashboardRoute);
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    margin: EdgeInsets.fromLTRB(15, 0, 15, 10),
                    child: RaisedButton(
                      padding: EdgeInsets.all(10),
                      highlightElevation: 5.0,
                      elevation: 3.0,
                      splashColor: Colors.orange[100],
                      highlightColor: Colors.orange[100],
                      color: appColorSecondary,
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
                              'View property',
                              style: TextStyle(
                                  color: appTextColorPrimary2, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        // _settingModalBottomSheet(context);
                        Navigator.pushNamed(context, dashboardRoute);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
