import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../colors.dart';
import '../../constants.dart';

class DashboardCollections extends StatefulWidget {
  @override
  _DashboardCollectionsState createState() => _DashboardCollectionsState();
}

class _DashboardCollectionsState extends State<DashboardCollections> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Container(
          padding: EdgeInsets.all(8),
          child: ClipOval(
            child: Material(
              color: appTextColorPrimary2, // button color
              child: InkWell(
                splashColor: Colors.orange[100], // inkwell color
                child: Image.asset(
                  'assets/images/person.png',
                  color: appSecondaryColor,
                  height: 24.0,
                  width: 24.0,
                ),
                onTap: () {
                  Navigator.pushNamed(context, profileRoute);
                },
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              child: Text('Edit'))
        ],
        title: RichText(
          text: TextSpan(
            text: 'Hi, ',
            style: TextStyle(fontSize: 16, color: appTextColorPrimary),
            children: <TextSpan>[
              TextSpan(
                text: 'Tolulope',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10.0),
                child: Text(
                  'My Collections',
                  style: TextStyle(color: appSecondaryColor, fontSize: 18.0),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 580.0,
                child: CustomScrollView(
                  primary: false,
                  slivers: <Widget>[
                    SliverPadding(
                      padding: const EdgeInsets.all(5),
                      sliver: SliverGrid.count(
                        crossAxisSpacing: 5,
                        childAspectRatio: (itemWidth / itemHeight),
                        mainAxisSpacing: 1,
                        crossAxisCount: 2,
                        children: <Widget>[
                          _propertItem,
                          _propertItem,
                          _propertItem,
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

  Widget _propertItem = Card(
    elevation: 2.0,
    child: InkWell(
      splashColor: Colors.orange.withAlpha(30),
      onTap: () {
        print('Card tapped.');
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
                    style: TextStyle(fontSize: 15, color: appTextColorPrimary),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Studio Apartment',
                    style: TextStyle(fontSize: 13, color: appTextColorPrimary),
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
                            style:
                                TextStyle(fontSize: 10, color: Colors.black87),
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
                          style:
                              TextStyle(color: Colors.black87, fontSize: 12.0)),
                      const SizedBox(width: 15),
                      SvgPicture.asset(
                        'assets/icons/bath.svg',
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 5),
                      Text('2 Bath',
                          style:
                              TextStyle(color: Colors.black87, fontSize: 12.0)),
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
