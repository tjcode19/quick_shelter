import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../colors.dart';
import '../../constants.dart';

class SearchResult extends StatefulWidget {
  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Search results',
                      style:
                          TextStyle(color: appSecondaryColor, fontSize: 20.0),
                    ),
                    Text(
                      '10 results',
                      style:
                          TextStyle(color: appColorSecondary, fontSize: 17.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: OutlineButton(
                        padding: EdgeInsets.all(6),
                        color: Colors.white,
                        highlightedBorderColor: Colors.white,
                        borderSide: BorderSide(color: appColorSecondary),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15))),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 3, 4, 4),
                          child: Text(
                            'For Rent',
                            style: TextStyle(
                                color: appColorSecondary, fontSize: 13),
                          ),
                        ),
                        onPressed: () {
                          //showSnackBar("OutlineButton with Shape");
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: CircleAvatar(
                          backgroundColor: appSecondaryColor,
                          child: Icon(
                            Icons.tune,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 400,
                child: CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(0),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 5,
                        childAspectRatio: ((itemWidth + 10) / (itemHeight)),
                        mainAxisSpacing: 1,
                        crossAxisCount: 2,
                        children: <Widget>[
                          _propertItem(context),
                          _propertItem(context),
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
    );
  }

  Widget _propertItem(ctxt) {
    return Card(
      elevation: 2.0,
      child: InkWell(
        splashColor: Colors.orange.withAlpha(30),
        onTap: () {
          print('Card tapped.');
          Navigator.pushNamed(ctxt, collPropDetailsRoute);
        },
        child: Container(
          margin: EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'assets/images/prop.png',
                width: 175,
                height: 123,
                fit: BoxFit.cover,
              ),
              Container(
                width: 172,
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 10),
                    Text(
                      'N55,000,000',
                      style:
                          TextStyle(fontSize: 15, color: appTextColorPrimary),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Studio Apartment',
                      style:
                          TextStyle(fontSize: 13, color: appTextColorPrimary),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 2.0),
                          child: Icon(
                            Icons.location_on,
                            size: 10,
                            color: Colors.orange,
                          ),
                        ),
                        Container(
                          child: Expanded(
                            child: Text(
                              '23 Cross, HRBR layout, bangalore',
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.black87),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/icons/bed.svg',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        Text('3 Bed',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0)),
                        const SizedBox(width: 15),
                        SvgPicture.asset(
                          'assets/icons/bath.svg',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 5),
                        Text('2 Bath',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 12.0)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
