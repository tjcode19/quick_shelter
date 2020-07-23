import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:quick_shelter/models/TransactionListResponse.dart';

import '../../colors.dart';

class TransDetailsPhotos extends StatefulWidget {
  final propDetails;

  TransDetailsPhotos({Key key, this.propDetails}) : super(key: key);
  @override
  _TransDetailsPhotosState createState() => _TransDetailsPhotosState();
}

class _TransDetailsPhotosState extends State<TransDetailsPhotos> {
  Data _propertyDetails;

  @override
  void initState() {
    super.initState();
    _propertyDetails = widget.propDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  icon: Icon(Icons.arrow_back),
                  color: appColorSecondary,
                ),
                Container(
                  height: 600,
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 2,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(
                        _propertyDetails.listing.property.photos.length,
                        (index) {
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
                    height: 175,
                    placeholder: kTransparentImage,
                    image: (_propertyDetails.listing.property.photos.isNotEmpty)
                        ? _propertyDetails.listing.property.photos[index].path
                        : 'https://picsum.photos/250?image=9',
                    fit: BoxFit.cover,
                  ),
                ]),
              ),

              // Container(
              //   width: 172,
              //   padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       const SizedBox(height: 15),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: <Widget>[
              //           GestureDetector(
              //             onTap: () {
              //               showDeleteDialog(context, index);
              //             },
              //             child: Row(
              //               children: <Widget>[
              //                 Icon(
              //                   Icons.delete,
              //                   color: Colors.orange,
              //                 ),
              //                 const SizedBox(width: 5),
              //                 Text('View',
              //                     style: TextStyle(
              //                         color: Colors.black87, fontSize: 12.0)),
              //               ],
              //             ),
              //           ),
              //           const SizedBox(width: 15),
              //           Row(
              //             children: <Widget>[
              //               Icon(
              //                 Icons.visibility,
              //                 color: Colors.orange,
              //               ),
              //               const SizedBox(width: 5),
              //               GestureDetector(
              //                 onTap: () {
              //                   showPropertyTypeDialog(context, index);
              //                 },
              //                 child: Text('View',
              //                     style: TextStyle(
              //                         color: Colors.black87, fontSize: 12.0)),
              //               ),
              //             ],
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // )
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
              (_propertyDetails.listing.property.title.length > 15)
                  ? '${_propertyDetails.listing.property.title.substring(0, 15)}...'
                  : _propertyDetails.listing.property.title,
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
              image: (_propertyDetails.listing.property.photos.isNotEmpty)
                  ? _propertyDetails.listing.property.photos[index].path
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
              image: (_propertyDetails.listing.property.photos.isNotEmpty)
                  ? _propertyDetails.listing.property.photos[index].path
                  : 'https://picsum.photos/850?image=9',
              fit: BoxFit.cover,
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[Icon(Icons.close), Text('No')],
                ),
              ),
              Container(
                margin: EdgeInsets.only(right:20.0),
                child: Row(
                  children: <Widget>[Icon(Icons.check), Text('Yes')],
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
}
