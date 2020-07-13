import 'package:flutter/material.dart';
import 'package:quick_shelter/models/GetAllProperties.dart';
import 'package:quick_shelter/repository/quick_shelter_repo.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../colors.dart';

class TransactionDetails extends StatefulWidget {
  final propertyDetails;
  const TransactionDetails({Key key, this.propertyDetails}) : super(key: key);
  @override
  _TransactionDetailsState createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  final QuickShelterRepository repo = QuickShelterRepository();
  bool rememberMe = false;
  GetAllPropData _propertyDetails;
  bool _isSaved = false;

  // List<Object> imageList = [
  //   {
  //     'thumbnail': 'assets/images/1_thumbnail.png',
  //     'big': 'assets/images/1_big.png',
  //   },
  //   {
  //     'thumbnail': 'assets/images/1_thumbnail.png',
  //     'big': 'assets/images/1_big.png',
  //   },
  //   {
  //     'thumbnail': 'assets/images/1_thumbnail.png',
  //     'big': 'assets/images/1_big.png',
  //   }
  // ];

  var ls = [
    ImageList('assets/images/1_thumbnail.png', 'assets/images/1_big.png'),
    ImageList('assets/images/2_thumbnail.png', 'assets/images/2_big.png'),
    ImageList('assets/images/3_thumbnail.png', 'assets/images/3_big.png'),
    ImageList('assets/images/3_thumbnail.png', 'assets/images/3_big.png'),
  ];

  int imageNum = 0;
  

  // _saveProperty() {
  //   if (_isSaved) {
  //     var _apiCall = repo.addSavedProperty(_propertyDetails.property.id);

  //     _apiCall.then((value) async {
  //       print('donnned');
  //       if (value.code == '200') {
  //         // Navigator.pushNamed(context, dashboardRoute);
  //       } else {
  //         //showInSnackBar(value.message);
  //         print('Saving property failed');
  //       }
  //     });
  //   } else {}
  // }

  @override
  void initState() {
    super.initState();

    //_propertyDetails = widget.propertyDetails;
  }

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Image.asset(
                    'assets/images/1_big.png',
                  ),
                  Image.asset(
                    'assets/images/1_big.png',
                    color: Color.fromRGBO(98, 98, 98, 0.7),
                  ),
                  Positioned(
                    top: 40.0,
                    left: 10.0,
                    child: Container(
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon:Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 130.0,
                    left: 130.0,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Property Sold',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25.0),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                  border: Border.all(color:Colors.white)
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'View property images',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13),
                                ),
                                Icon(Icons.keyboard_arrow_right, color: Colors.white,),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(13.0),
                color: appColorSecondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'View property documents',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Transaction Details',
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(215, 247, 223, 1),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text(
                            'Sucess',
                            style: TextStyle(
                                color: Color.fromRGBO(1, 157, 50, 1),
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    detailsRow('Property Owner', 'Oluwatosin Yadeka'),
                    const SizedBox(height: 16),
                    detailsRow('Customer', 'Yadeka Oluwatosin'),
                    const SizedBox(height: 16),
                    detailsRow('Price', 'N55,000,000'),
                    const SizedBox(height: 16),
                    detailsRow('Payment ID', '995799930020'),
                    const SizedBox(height: 16),
                    detailsRow('Date', '20th May, 2020'),
                    const SizedBox(height: 30),
                    RaisedButtonWidget(
                      '',
                      'Share Receipt',
                      true,
                    ),
                    const SizedBox(height: 10),
                    RaisedButtonWidget(
                      '',
                      'Download Receipt',
                      false,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      // Stack(
      //         alignment: Alignment.center,
      //         children: [
      //         Container(
      //           child: CircularProgressIndicator()),
      //         FadeInImage.memoryNetwork(
      //           width: 175,
      //           height: 123,
      //           placeholder: kTransparentImage,
      //           image:  'https://picsum.photos/250?image=9',
      //           fit: BoxFit.cover,
      //         ),
      //       ]),

      // IndexedStack(
      //   index: _currentPosition,
      //   children: ls
      //       .map(
      //         (e) => Container(
      //           height: screeSize.height / 2 + 50,
      //           constraints: BoxConstraints.loose(Size.infinite),
      //           child:
      //               FadeInImage.memoryNetwork(
      //             placeholder: kTransparentImage,
      //             image:  'https://picsum.photos/250?image=9',
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       )
      //       .toList(),
      // ),
      // Container(
      //   margin: EdgeInsets.fromLTRB(0, 20, 10, 10),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       Container(
      //         child: IconButton(
      //           color: Theme.of(context).primaryColor,
      //           iconSize: 30.0,
      //           onPressed: () {
      //             Navigator.pop(context);
      //           },
      //           icon: Icon(
      //             Icons.arrow_back,
      //             color: appColorSecondary,
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

      // Container(
      //   color: appColorSecondary,
      //   width: double.infinity,
      //   margin: EdgeInsets.fromLTRB(10, screeSize.height / 3 + 40, 10, 10),
      //   child: SingleChildScrollView(
      //     scrollDirection: Axis.horizontal,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [Text('View property documents', style: TextStyle(fontSize: 18.0),)]
      //     ),
      //   ),
      // ),
      // Positioned(
      //   right: 0.0,
      //   bottom: 0.0,
      //   child: Container(
      //     padding: EdgeInsets.all(20),
      //     decoration: BoxDecoration(
      //       color: Color.fromRGBO(129, 92, 67, 1),
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(20),
      //           topRight: Radius.circular(20)),
      //     ),
      //     width: screeSize.width,
      //     height: screeSize.height / 2,
      //     child: SingleChildScrollView(
      //       scrollDirection: Axis.vertical,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: <Widget>[
      //           Container(
      //               margin: EdgeInsets.only(top: 10),
      //               child: Text(
      //                 'Studio Apartment, Fully Furnished',
      //                 style: TextStyle(
      //                     color: Colors.white,
      //                     fontSize: 20.0,
      //                     fontWeight: FontWeight.bold),
      //               )),
      //           const SizedBox(height: 10),
      //           Container(
      //             child: RichText(
      //               text: TextSpan(
      //                 text: '₦',
      //                 style: TextStyle(
      //                     fontSize: 22, color: appTextColorPrimary2),
      //                 children: <TextSpan>[
      //                   TextSpan(
      //                     text: '6767',
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 30,
      //                       color: Colors.white,
      //                     ),
      //                   ),
      //                   TextSpan(
      //                     text: '.00',
      //                     style: TextStyle(
      //                       fontWeight: FontWeight.w800,
      //                       fontSize: 22,
      //                       color: appTextColorPrimary2,
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 20),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: <Widget>[
      //               Column(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: <Widget>[
      //                   Text('ui',
      //                     style:
      //                         TextStyle(color: Colors.white, fontSize: 15),
      //                   ),
      //                   SizedBox(
      //                     height: 5.0,
      //                   ),
      //                   Row(
      //                     children: <Widget>[
      //                       SvgPicture.asset(
      //                         'assets/icons/bed.svg',
      //                         color: Colors.white,
      //                         width: 25,
      //                       ),
      //                       SizedBox(
      //                         width: 5.0,
      //                       ),
      //                       Text(
      //                         'Bedrooms',
      //                         style: TextStyle(
      //                             color: Colors.white, fontSize: 13),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               // SizedBox(width: 20.0),
      //               Column(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: <Widget>[
      //                   Text(
      //                     '2',
      //                     style:
      //                         TextStyle(color: Colors.white, fontSize: 15),
      //                   ),
      //                   SizedBox(height: 5.0),
      //                   Row(
      //                     children: <Widget>[
      //                       SvgPicture.asset(
      //                         'assets/icons/bath.svg',
      //                         color: Colors.white,
      //                         width: 25,
      //                       ),
      //                       SizedBox(
      //                         width: 5.0,
      //                       ),
      //                       Text(
      //                         'Bathroom',
      //                         style: TextStyle(
      //                             color: Colors.white, fontSize: 13),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //               Column(
      //                 children: <Widget>[
      //                   ClipOval(
      //                     child: Material(
      //                       color: (_isSaved)?appColorSecondary: Colors.grey, // button color
      //                       child: InkWell(
      //                         splashColor: Colors.orange, // inkwell color
      //                         child: Padding(
      //                           padding: const EdgeInsets.all(8.0),
      //                           child: Icon(Icons.favorite,
      //                               size: 25, color: Colors.white),
      //                         ),
      //                         onTap: () {
      //                           // Navigator.pushNamed(context, profileRoute);
      //                           setState(() {
      //                             _isSaved =! _isSaved;
      //                             _saveProperty();
      //                           });
      //                         },
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               )
      //             ],
      //           ),
      //           const SizedBox(height: 25),
      //           Container(
      //             child: Text(
      //               'Property Details',
      //               style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 18.0,
      //                   fontWeight: FontWeight.bold),
      //             ),
      //           ),
      //           const SizedBox(height: 10),
      //           _rowCont('Location',' _propertyDetails.property.location',
      //               Icons.location_on),
      //           Divider(color: Colors.white38, thickness: 1.0),
      //           _rowCont('State', 'Lagos State', Icons.pin_drop),
      //           Divider(color: Colors.white38, thickness: 1.0),
      //           _rowCont('Land Area', '77km', Icons.landscape),
      //           Divider(color: Colors.white38, thickness: 1.0),
      //           _rowCont(
      //               'Available date', '20th May, 2020', Icons.date_range),
      //           Divider(color: Colors.white38, thickness: 1.0),
      //           const SizedBox(height: 20),
      //           RaisedButtonWidget(dashboardRoute, 'Buy Property', true),
      //           const SizedBox(height: 20),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      //   ],
      // ),
    );
  }

  Widget detailsRow(String tag, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            tag,
            style: TextStyle(
                fontSize: 18, color: Color.fromRGBO(112, 112, 112, 0.7)),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      );

  _rowCont(String title, String subTitle, iconNew) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(children: [
            Icon(
              iconNew,
              color: appTextColorPrimary2,
              size: 16.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              title,
              style: TextStyle(color: appTextColorPrimary2),
            ),
          ]),
          Container(
            width: 170.0,
            child: Text(
              subTitle,
              softWrap: true,
              style: TextStyle(color: appTextColorPrimary2),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageList {
  ImageList(this.thumbnail, this.bigPix);
  final String thumbnail;
  final String bigPix;
}
