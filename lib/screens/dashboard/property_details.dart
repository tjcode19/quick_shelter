import 'package:flutter/material.dart';
import 'package:quick_shelter/widgets/input_field.dart';
import 'package:quick_shelter/widgets/raised_button.dart';

import '../../colors.dart';
import '../../constants.dart';

class PropertyDetails extends StatefulWidget {
  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  bool rememberMe = false;

  List<Object> imageList = [
    {
      'thumbnail': 'assets/images/1_thumbnail.png',
      'big': 'assets/images/1_big.png',
    },
    {
      'thumbnail': 'assets/images/1_thumbnail.png',
      'big': 'assets/images/1_big.png',
    },
    {
      'thumbnail': 'assets/images/1_thumbnail.png',
      'big': 'assets/images/1_big.png',
    }
  ];

  var ls = [
    ImageList('assets/images/1_thumbnail.png', 'assets/images/1_big.png'),
    ImageList('assets/images/2_thumbnail.png', 'assets/images/2_big.png'),
    ImageList('assets/images/3_thumbnail.png', 'assets/images/3_big.png'),
    ImageList('assets/images/3_thumbnail.png', 'assets/images/3_big.png'),
    ImageList('assets/images/3_thumbnail.png', 'assets/images/3_big.png'),
    ImageList('assets/images/3_thumbnail.png', 'assets/images/3_big.png'),
    ImageList('assets/images/3_thumbnail.png', 'assets/images/3_big.png'),
    ImageList('assets/images/3_thumbnail.png', 'assets/images/3_big.png'),
  ];

  int imageNum = 0;
  int _currentPosition = 0;

  void _toggleFavorite(pos, action, eventY) {
    setState(() {
      print('SetState: $_currentPosition');
      if (eventY == 'addSub') {
        if (action == 'add') {
          _currentPosition += 1;
        } else {
          _currentPosition -= 1;
        }
      } else {
        _currentPosition = pos;
      }
      print('SetStateLater: $_currentPosition');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screeSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          IndexedStack(
            index: _currentPosition,
            children:
                // ls.map((item) => new Text(item.bigPix)).toList(),

                ls
                    .map(
                      (e) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(e.bigPix),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: IconButton(
                    color: Theme.of(context).primaryColor,
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: appColorSecondary,
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Text('For Sale')),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, screeSize.height / 3 - 50, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Visibility(
                  visible: (_currentPosition != 0 ? true : false),
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: appColorSecondary,
                          ),
                        ),
                        onTap: () {
                          print(_currentPosition);
                          _toggleFavorite(0, 'sub', 'addSub');
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: (_currentPosition < (ls.length - 1) ? true : false),
                  child: ClipOval(
                    child: Material(
                      color: Colors.white, // button color
                      child: InkWell(
                        splashColor: Colors.white, // inkwell color
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward,
                            color: appColorSecondary,
                          ),
                        ),
                        onTap: () {
                          print(_currentPosition);
                          _toggleFavorite(0, 'add', 'addSub');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, screeSize.height / 3 + 40, 10, 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: ls.map((e) {
                  int indexL = ls.indexOf(e);
                  return GestureDetector(
                    
                    onTap: () {
                      print(indexL);
                      _toggleFavorite(indexL, 'click', 'clicking');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5.0),
                      decoration: (indexL == _currentPosition)
                          ? BoxDecoration(
                              border: Border.all(
                                  width: 2, color: appColorSecondary),
                            )
                          : null,
                      child: Image.asset(e.thumbnail),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            top: screeSize.height / 2,
            left: 0.0,
            right: 0.0,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(129, 92, 67, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Studio Apartment, Fully Furnished',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            )),
                        const SizedBox(height: 10),
                        Container(
                          child: Text(
                            'N55,000,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 21.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 120),
                        Container(
                          child: Text(
                            'Property Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Divider(color: Colors.white38, thickness: 1.0),
                        _rowCont('Location', 'Lagos State', Icons.check),
                        Divider(color: Colors.white38, thickness: 1.0),
                        _rowCont('State', 'Lagos State', Icons.check),
                        Divider(color: Colors.white38, thickness: 1.0),
                        _rowCont('Land Area', '77km', Icons.check),
                        Divider(color: Colors.white54, thickness: 1.0),
                        const SizedBox(height: 20),
                        Divider(color: Colors.white38, thickness: 1.0),
                        _rowCont('Location', 'Lagos State', Icons.check),
                        Divider(color: Colors.white38, thickness: 1.0),
                        _rowCont('State', 'Lagos State', Icons.check),
                        Divider(color: Colors.white38, thickness: 1.0),
                        _rowCont('Land Area', '77km', Icons.check),
                        Divider(color: Colors.white54, thickness: 1.0),
                        const SizedBox(height: 20),
                        Divider(color: Colors.white38, thickness: 1.0),
                        _rowCont('Location', 'Lagos State', Icons.check),
                        Divider(color: Colors.white38, thickness: 1.0),
                        _rowCont('State', 'Lagos State', Icons.check),
                        Divider(color: Colors.white38, thickness: 1.0),
                        _rowCont('Land Area', '77km', Icons.check),
                        Divider(color: Colors.white54, thickness: 1.0),
                        _rowCont('Available Date', '20 May, 2020', Icons.check),
                        const SizedBox(height: 20),
                        RaisedButtonWidget(
                            dashboardRoute, 'Buy Property', true),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
            ),
            Text(
              title,
              style: TextStyle(color: appTextColorPrimary2),
            ),
          ]),
          Text(
            subTitle,
            style: TextStyle(color: appTextColorPrimary2),
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
