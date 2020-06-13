import 'package:flutter/material.dart';
import 'package:quick_shelter/colors.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

class FileUpload extends StatefulWidget {
  @override
  _FileUploadState createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
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
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'Certificate of Occupancy',
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ]),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  'This is an example of the required document',
                  style: TextStyle(color: Colors.white, fontSize: 14.0, ),
                  textAlign: TextAlign.center,
                ),
              ]),
              
              const SizedBox(height: 30),
              Container(
                height: 250.0,
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
              ),
              const SizedBox(height: 60),
              RaisedButtonWidget('pop', 'Continue', true),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _setImageView(BuildContext context) {
  //   if (_image != null) {
  //     //return Image.file(_image, width: 500, height: 500);
  //     return GestureDetector(
  //       onTap: () => _showSelectionDialog(context),
  //       child: Container(
  //         height: 200.0,
  //         width: double.infinity,
  //         //color: appPrimary,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //                   image: FileImage(_image),
  //                   fit: BoxFit.cover),
  //             color: appPrimary,
  //             borderRadius: BorderRadius.all(Radius.circular(6)),
  //             border: Border.all(color: appTextColorPrimary2)),
          
  //       ),
  //     );
  //   } else {
  //     return GestureDetector(
  //       onTap: () => _showSelectionDialog(context),
  //       child: Container(
  //         height: 150.0,
  //         width: double.infinity,
  //         //color: appPrimary,
  //         decoration: BoxDecoration(
  //             color: appPrimary,
  //             borderRadius: BorderRadius.all(Radius.circular(6)),
  //             border: Border.all(color: appTextColorPrimary2)),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Icon(
  //               Icons.camera_alt,
  //               color: Colors.white,
  //             ),
  //             Center(
  //               child: Padding(
  //                 padding: const EdgeInsets.fromLTRB(30.0, 10, 30, 0),
  //                 child: Text(
  //                   'Upload valid ID Image',
  //                   style: TextStyle(color: appTextColorPrimary2),
  //                   textAlign: TextAlign.center,
  //                   softWrap: true,
  //                 ),
  //               ),
  //             ),
  //             Center(
  //               child: Padding(
  //                 padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
  //                 child: Text(
  //                   '(Intl. passport, NIN, drivers license, voters card)',
  //                   style: TextStyle(color: appTextColorPrimary2),
  //                   textAlign: TextAlign.center,
  //                   softWrap: true,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //   }
  // }
}
