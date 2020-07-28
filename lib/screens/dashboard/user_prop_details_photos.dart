import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quick_shelter/models/GetUserProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:quick_shelter/models/TransactionListResponse.dart';

import '../../colors.dart';
import '../../constants.dart';

class UserPropDetailsPhotos extends StatefulWidget {
  final propDetails;

  UserPropDetailsPhotos({Key key, this.propDetails}) : super(key: key);
  @override
  _UserPropDetailsPhotosState createState() => _UserPropDetailsPhotosState();
}

class _UserPropDetailsPhotosState extends State<UserPropDetailsPhotos> {
  GetUserPropData _propertyDet;
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _controller;
  FToast fToast;
  bool _isVisible = true;

  void _deletePhoto() {
    var _apiCall = repo.deletePhoto('0');

    _apiCall.then((value) {
      //print('donnned ${value.data}');
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessResponseCode) {
        print('Photo deleted');

        //_showToast(value.responseMessage);
        snackBar(value.responseMessage, _scaffoldKey, type: 'success');
        Navigator.pop(context);
      } else {
        _showToast(value.responseMessage);
        print('Failed to load properties');
      }
    });
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
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _propertyDet = widget.propDetails['pData'];

    print('Photos ${widget.propDetails['pData']}');
    fToast = FToast(context);
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appSecondaryColor,
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Property Photos',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ]),
                ),
                Container(
                  height: 600,
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 2,
                    // Generate 100 widgets that display their index in the List.
                    children:
                        List.generate(_propertyDet.photos.length, (index) {
                      return Center(
                        child:
                            // Text(
                            //   'Item $index',
                            //   style: Theme.of(context).textTheme.headline5,
                            // ),
                            _propertItem(index),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, editPropPhotosRoute, arguments: {'propID': _propertyDet.iD,
            'type':'editProp', 'refFunc': widget.propDetails['refFunc'],});
          },
          // child: Icon(
          //   Icons.add,
          //   color: Colors.white,
          // ),
          // backgroundColor: Theme.of(context).primaryColor,
          label: Text(
            'New Photo',
            style: TextStyle(fontSize: 14.0, color: Colors.white),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Property',
        ),
      ),
    );
  }

  Widget _propertItem(int index) => Card(
        elevation: 2.0,
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
              InkWell(
                splashColor: Colors.orange.withAlpha(30),
                onTap: () {
                  showPropertyTypeDialog(context, index);
                  //Navigator.pushNamed(context, propDetailsRoute,);
                },
                child: Stack(alignment: Alignment.center, children: [
                  Container(child: CircularProgressIndicator()),
                  FadeInImage.memoryNetwork(
                    width: 175,
                    height: 140,
                    placeholder: kTransparentImage,
                    image: (_propertyDet.photos.isNotEmpty)
                        ? _propertyDet.photos[index].path
                        : 'https://picsum.photos/250?image=9',
                    fit: BoxFit.cover,
                  ),
                ]),
              ),
              Container(
                width: 172,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            showDeleteDialog(context, index);
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.delete,
                                color: Colors.orange,
                              ),
                              const SizedBox(width: 5),
                              Text('Delete',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 14.0)),
                            ],
                          ),
                        ),
                        // Row(
                        //   children: <Widget>[
                        //     Icon(
                        //       Icons.visibility,
                        //       color: Colors.orange,
                        //     ),
                        //     const SizedBox(width: 5),
                        //     GestureDetector(
                        //       onTap: () {
                        //         showPropertyTypeDialog(context, index);
                        //       },
                        //       child: Text('View',
                        //           style: TextStyle(
                        //               color: Colors.black87, fontSize: 12.0)),
                        //     ),
                        //   ],
                        // ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Future showPropertyTypeDialog(BuildContext context, index) async {
    var size = MediaQuery.of(context).size;
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              (_propertyDet.title.length > 15)
                  ? '${_propertyDet.title.substring(0, 15)}...'
                  : _propertyDet.title,
              style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.normal),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ],
        ),
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(child: CircularProgressIndicator()),
            FadeInImage.memoryNetwork(
              width: size.width,
              height: size.height / 2,
              placeholder: kTransparentImage,
              image: (_propertyDet.photos.isNotEmpty)
                  ? _propertyDet.photos[index].path
                  : 'https://picsum.photos/850?image=9',
              fit: BoxFit.cover,
            ),
          ]),
        ]);

    // show the dialog
    String dialogVal = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
    setState(() {
      FocusScope.of(context).requestFocus(new FocusNode());
      // _propTypeController.text = dialogVal;
      //propertyType = dialogVal;
    });
  }

  Future showDeleteDialog(BuildContext context, index) async {
    var size = MediaQuery.of(context).size;
    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Delete this photo?',
              style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.normal),
            ),
          ],
        ),
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(child: CircularProgressIndicator()),
            FadeInImage.memoryNetwork(
              width: size.width,
              height: size.height / 2,
              placeholder: kTransparentImage,
              image: (_propertyDet.photos.isNotEmpty)
                  ? _propertyDet.photos[index].path
                  : 'https://picsum.photos/850?image=9',
              fit: BoxFit.cover,
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: Row(
                    children: <Widget>[Icon(Icons.close), Text('No')],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _deletePhoto();
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: <Widget>[Icon(Icons.check), Text('Yes')],
                  ),
                ),
              )
            ],
          )
        ]);

    // show the dialog
    String dialogVal = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
    setState(() {
      FocusScope.of(context).requestFocus(new FocusNode());
      // _propTypeController.text = dialogVal;
      //propertyType = dialogVal;
    });
  }

  _showToast(String msg) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white30,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.0,
          ),
          Text(
            msg,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM_RIGHT,
      toastDuration: Duration(seconds: 2),
    );
  }
}
