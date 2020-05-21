import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_shelter/constants.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: Container(
                    child: SvgPicture.asset(
                  'assets/images/svg_payment_card.svg',
                  color: Colors.amber,
                  height: 24.0,
                  width: 24.0,
                )),
                title: Text(
                  'My Card & Setting',
                  style: TextStyle(),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  //Navigator.pushNamed(context, routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
