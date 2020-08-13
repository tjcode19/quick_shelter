import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';
import 'package:quick_shelter/widgets/tapableText.dart';

import '../constants.dart';
import '../widgets/raised_button.dart';

class IdentityCard extends StatefulWidget {
  @override
  _IdentityCardState createState() => _IdentityCardState();
}

class _IdentityCardState extends State<IdentityCard> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _viewMore = false;
  File _image;

  void _uploadFile() {
    print('File Upload');

    if (_image == null) {
      snackBar('Please select a file to upload', _scaffoldKey);
      return;
    }
    showLoadingDialog(context, _keyLoader);

    var _apiCall = repo.uploadId(_image, 'NationalID');

    _apiCall.then((value) {
      print(value.responseCode);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if (value.responseCode == globalSuccessResponseCode) {
        Navigator.pushNamed(context, regCompletedRoute);
      } else {
        // snackBar('Registration Failed \t ${value.responseMessage}', _scaffoldKey);
        print('ID upload failed');
      }
      //snackBar(value.message, _scaffoldKey);
    }
    ,onError: (e){
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/welcome.png"),
                    fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 35, 10, 10),
                  child: IconButton(
                    color: Theme.of(context).primaryColor,
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                Container(
                  height: screeSize.height - 100,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(129, 92, 67, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Identity Card',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              tapableText('I’ll do this later. Skip', () {
                                Navigator.pushNamed(context, regCompletedRoute);
                              }),
                            ],
                          )),
                      const SizedBox(height: 20),
                      Container(
                        child: Text(
                          'Please provide a means of identification to complete registration.',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      const SizedBox(height: 40),
                      _setImageView(context),
                      const SizedBox(height: 30),
                      RaisedButtonWidget(
                        regCompletedRoute,
                        'Complete Registraton',
                        true,
                        action: _uploadFile,
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        splashColor: Colors.orange,
                        highlightColor: Colors.orange[100],
                        onTap: () {
                          setState(() {
                            _viewMore = !_viewMore;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
                          decoration: BoxDecoration(
                              color: appPrimary,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10)),
                              border: Border.all(color: appTextColorPrimary2)),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Why we need your ID?',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  Text(
                                    'view >',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  )
                                ],
                              ),
                              Visibility(
                                visible: _viewMore,
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                        color: Colors.white38, thickness: 1.0),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            'We use your ID to makesure your details are genuine and not someone else',
                                            softWrap: true,
                                            style: TextStyle(
                                                color: appTextColorPrimary2),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 12, 0, 4),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.check,
                                            color: appTextColorPrimary2,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'We use it to secure your account',
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: appTextColorPrimary2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 1),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.check,
                                            color: appTextColorPrimary2,
                                            size: 16,
                                          ),
                                          SizedBox(
                                            width: 5.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'For trust and transparency',
                                              softWrap: true,
                                              style: TextStyle(
                                                  color: appTextColorPrimary2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

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
      _image = File(pickedFile.path);
    });

    Navigator.of(context).pop();
  }

  Future _openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
     // print(pickedFile.path);
    });

    Navigator.of(context).pop();
  }

  Widget _setImageView(BuildContext context) {
    if (_image != null) {
      //return Image.file(_image, width: 500, height: 500);
      return GestureDetector(
        onTap: () => _showSelectionDialog(context),
        child: Container(
          height: 200.0,
          width: double.infinity,
          //color: appPrimary,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: FileImage(_image), fit: BoxFit.cover),
              color: appPrimary,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              border: Border.all(color: appTextColorPrimary2)),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () => _showSelectionDialog(context),
        child: Container(
          height: 150.0,
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
                    'Upload valid ID Image',
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
                    '(Intl. passport, NIN, drivers license, voters card)',
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
  }
}
