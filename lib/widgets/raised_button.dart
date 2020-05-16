import 'package:flutter/material.dart';

class RaisedButtonWidget extends StatelessWidget {
  final String routeName;
  final String btnLabel;
  final Color btnColor;
  final Color btnTextColor;

  RaisedButtonWidget(this.routeName, this.btnLabel, this.btnColor, this.btnTextColor);



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(16),
        highlightElevation: 5.0,
        elevation: 3.0,
        splashColor: Colors.teal[300],
        highlightColor: Colors.teal[300],
        color: btnColor,
        shape: RoundedRectangleBorder(
            //borderRadius: new BorderRadius.circular(10.0),
            borderRadius: BorderRadius.only(topRight: Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
              child: Text(
                btnLabel,
                style: TextStyle(color: btnTextColor),
              ),
            ),
          ],
        ),
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
      ),
    );
  }
}
