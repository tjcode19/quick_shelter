import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../constants.dart';

class AddPropStep2 extends StatefulWidget {
  final propertyData;

  const AddPropStep2({Key key, this.propertyData}) : super(key: key);

  @override
  _AddPropStep2State createState() => _AddPropStep2State();
}

class _AddPropStep2State extends State<AddPropStep2> {
  final QuickShelterRepository repo = QuickShelterRepository();
  // final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File _image;
  bool fileUploaded = false;
  List<dynamic> _images = [];
  List<dynamic> _isLoading = [];

  _uploadFile(File image, int index) async {
    setState(() {
      _isLoading[index] = true;
    });

    // final int propertyID =  await _sharedPreferenceQS.getSharedPrefs(String, 'propertyID');

    if (_images.isEmpty) {
      snackBar('Please select a file to upload', _scaffoldKey);
      return;
    }

    var _apiCall = repo.uploadPropPictures(
        image, '', 'Sitting Area', widget.propertyData['propID']);

    print(_apiCall);

    await _apiCall.then((value) {
      print(value.responseCode);
      if (value.responseCode == globalSuccessResponseCode) {
        setState(() {
          _isLoading[index] = false;
        });

        print("Done");
      } else {
        print("Failed");
      }
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    });
  }

  // Future to run
  Future<bool> myTypedFuture(int id, int duration) async {
    await Future.delayed(Duration(seconds: duration));
    print('Delay complete for Future $id');
    return true;
  }

// Running multiple futures
  runMultipleFutures() async {
    // Create list of multiple futures
    var futures = List<Future>();
    for (int i = 0; i < _images.length; i++) {
      futures.add(_uploadFile(_images[i], i));
    } // Waif for all futures to complete
    await Future.wait(futures); // We're done with all futures execution
    print('All the futures has completed');
    fileUploaded = true;
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
                        'Add Property Images',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Visibility(
                        visible:
                            true, //(widget.propertyData['type'] == 'newProp'),
                        child: Text(
                          'Step 3 of 5',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 14.0),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ]),

                const SizedBox(height: 20),

                (_images.length < 1)
                    ? Container(
                        height: 150.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(color: appTextColorPrimary2)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        height: 350.0,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: _images.length,
                          itemBuilder: _buildItemsForListView,
                        ),
                      ),
                const SizedBox(height: 8),
                // Container(
                //   height: 150.0,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //       color: Colors.transparent,
                //       borderRadius: BorderRadius.all(Radius.circular(6)),
                //       border: Border.all(color: appTextColorPrimary2)),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: <Widget>[
                //       Icon(
                //         Icons.camera_alt,
                //         color: Colors.white,
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 8),
                _setImageView(context),
                const SizedBox(height: 40),
                (fileUploaded)
                    ? (widget.propertyData['type'] != 'newProp')
                        ? Container(
                            width: MediaQuery.of(context).size.width - 30,
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
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                                    child: Text(
                                      'Dismiss',
                                      style: TextStyle(
                                          color: appTextColorPrimary2,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                // _settingModalBottomSheet(context);
                                //widget.propDetails['refFunc']();
                                int count = 0;
                                Navigator.popUntil(context, (route) {
                                  return count++ == 4;
                                });
                              },
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 40,
                                child: OutlineButton(
                                  padding: EdgeInsets.all(10),
                                  color: Colors.white,
                                  highlightedBorderColor: Colors.white,
                                  borderSide:
                                      BorderSide(color: appTextColorPrimary2),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 4, 4, 4),
                                        child: Text(
                                          'Skip',
                                          style: TextStyle(
                                              color: appTextColorPrimary2,
                                              fontSize: 15),
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
                                width:
                                    MediaQuery.of(context).size.width / 2 - 40,
                                child: RaisedButtonWidget(
                                  addPropStep3Route,
                                  'Add Listing',
                                  true,                                  
                                  argsPushName: widget.propertyData['propID'],
                                ),
                              ),
                            ],
                          )
                    : RaisedButtonWidget(
                        addPropertyStep4Route,
                        'Upload',
                        true,
                        action: runMultipleFutures,
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
          // final result = await Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => FileUpload(
          //       docType: _propertyListingReq[index].name,
          //       docTypeId: index,
          //       propertyID: widget.propertyID,
          //     ),
          //   ),
          // );

          // setState(() {
          //   _propertyListingReq[result['id']].status = result['status'];

          //   print('Hello ${result['status']}');
          // });
        },
        child: Column(
          children: <Widget>[
            Stack(alignment: Alignment.center, children: [
              Container(
                height: 200.0,
                width: double.infinity,
                //color: appPrimary,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(_images[index]), fit: BoxFit.cover),
                    color: appPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    border: Border.all(color: appTextColorPrimary2)),
              ),
              ((!_isLoading[index] && fileUploaded)
                  ? Icon(
                      Icons.check_circle,
                      size: 25,
                      color: Colors.green,
                    )
                  : (_isLoading[index] && !fileUploaded)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Icon(
                          Icons.file_upload,
                          size: 25,
                          color: appColorSecondary,
                        )),
            ]),
            const SizedBox(height: 8),
          ],
        ),
      );

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "Select from?",
                style: TextStyle(
                    color: appSecondaryColor,
                    fontStyle: FontStyle.normal,
                    fontSize: 25.0),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  final picker = ImagePicker();

  Future _openGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      //if(_images.isNotEmpty)
      _image = File(pickedFile.path);
      _images.add(_image);
      _isLoading.add(false);

      // int indexNew = _images.indexOf(_image);

      print(_images);
    });

    Navigator.of(context).pop(widget.propertyData['propID']);

    //_uploadFile();
  }

  Future _openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      // if(_images.isNotEmpty)
      _image = File(pickedFile.path);
      _images.add(_image);
      _isLoading.add(false);
      print(pickedFile.path);
    });

    Navigator.of(context).pop(widget.propertyData['propID']);
    //_uploadFile();
  }

  Widget _setImageView(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSelectionDialog(context),
      child: Container(
        height: 100.0,
        width: double.infinity,
        //color: appPrimary,
        decoration: BoxDecoration(
            color: appPrimary,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            border: Border.all(color: appTextColorPrimary2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.camera_alt,
              color: Colors.white,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
                child: Text(
                  'Upload image for your property',
                  style: TextStyle(color: appTextColorPrimary2),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
                child: Text(
                  '(Livingroom, kitchen, bathroom, etc)',
                  style: TextStyle(color: appTextColorPrimary2),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
