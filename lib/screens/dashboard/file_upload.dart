import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/constants.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/commonUtils.dart';

class FileUpload extends StatefulWidget {

  final String docType ;
  final int docTypeId;
  final int propertyID;
  FileUpload({Key key, this.docType, this.docTypeId, this.propertyID}): super(key:key);

  @override
  _FileUploadState createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  final QuickShelterRepository repo = QuickShelterRepository();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File _image;

  void _uploadFile(){
    print('File Upload');

    if (_image==null) {
      snackBar('Please select a file to upload', _scaffoldKey);
      return;
    }
    showLoadingDialog(context, _keyLoader);

    var _apiCall = repo.uploadPropDocs(_image, 'doc', widget.docType, widget.propertyID);

    print(_apiCall);

    _apiCall.then((value) {
      print(value.responseCode);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      if(value.responseCode == globalSuccessResponseCode){
        Navigator.of(context).pop({'id':widget.docTypeId, 'status':true});        
      }
      else{
        Navigator.of(context).pop({'id':widget.docTypeId, 'status':false});
      }
    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Please Upload Your',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  widget.docType,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ]),
              const SizedBox(height: 30),
              
              _setImageView(context),
              const SizedBox(height: 60),
              //RaisedButtonWidget('pop', 'Continue', true, popValue: {'id':widget.docTypeId, 'status':false},),
              const SizedBox(height: 20),
            ],
          ),
        ),
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

    Navigator.of(context).pop(widget.docTypeId);

    _uploadFile();
  }

  Future _openCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
      print(pickedFile.path);
    });

    print(widget.docTypeId);

    Navigator.of(context).pop(widget.docTypeId);
    _uploadFile();
  }

  Widget _setImageView(BuildContext context) {
    if (_image != null) {
      //return Image.file(_image, width: 500, height: 500);
      return GestureDetector(
        onTap: () => _showSelectionDialog(context),
        child: Container(
          height: 250.0,
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
          height: 250.0,
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
                    'Upload valid property document image',
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
                    '(C of O)',
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
