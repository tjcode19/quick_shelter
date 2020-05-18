import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../colors.dart';

class DashboardHome extends StatefulWidget {
  @override
  _DashboardHomeState createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          child: IconButton(
            icon: Icon(
              Icons.person,
            ),
            onPressed: () {},
          ),
        ),
        title: RichText(
          text: TextSpan(
            text: 'Hi, ',
            style: TextStyle(fontSize: 16),
            children: <TextSpan>[
              TextSpan(
                text: 'Tolulope',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.teal[100],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text('Featured Properties')),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: 280.0,
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Card(
                      child: InkWell(
                        splashColor: Colors.orange.withAlpha(30),
                        onTap: () {
                          print('Card tapped.');
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
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
                                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'N55,000,000',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: appTextColorPrimary),
                                    ),
                                    Text(
                                      'Studio Apartment',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: appTextColorPrimary),
                                    ),
                                    const SizedBox(height: 15),
                                    RichText(
                                      text: TextSpan(
                                        text: '',
                                        
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 10.0),
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.location_on,
                                              size: 14,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          TextSpan(text: '23 Cross, HRBR layout, bangalore',
                                          children: []),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Row(
                                      children: <Widget>[
                                        SvgPicture.asset('assets/icons/bed.svg', color: Colors.orange,),
                                        const SizedBox(width: 5),
                                        Text('3 Bed',style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12.0)),
                                        const SizedBox(width: 15),
                                        SvgPicture.asset('assets/icons/bath.svg', color: Colors.orange,),
                                        const SizedBox(width: 5),
                                        Text('2 Bath',style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12.0)),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 160.0,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 160.0,
                      color: Colors.green,
                    ),
                    Container(
                      width: 160.0,
                      color: Colors.yellow,
                    ),
                    Container(
                      width: 160.0,
                      color: Colors.orange,
                    ),
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
