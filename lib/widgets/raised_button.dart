import 'package:flutter/material.dart';

class RaisedButtonWidget extends StatelessWidget {
  final String routeName;
  final String btnLabel;
  Color btnColor;
  Color btnTextColor;
  double fnSize;
  final Function action;
  final popValue;
  final argsPushName;

  bool isBtnColorPrimary;
  bool isValidatable;
  final GlobalKey<FormState> formKey;
  

  RaisedButtonWidget(this.routeName, this.btnLabel, this.isBtnColorPrimary,
      {this.fnSize: 17, this.action, this.isValidatable:false, this.formKey, this.popValue, this.argsPushName});

  @override
  Widget build(BuildContext context) {

    if (isBtnColorPrimary) {
      btnColor = Theme.of(context).primaryColor;
      btnTextColor = Colors.white;
    } else {
      btnColor = Colors.white;
      btnTextColor = Theme.of(context).primaryColor;
    }

    return Container(
      width: double.infinity,
      child: RaisedButton(
        padding: EdgeInsets.all(8),
        highlightElevation: 5.0,
        elevation: 3.0,
        splashColor: Colors.orange[100],
        highlightColor: Colors.orange[100],
        color: btnColor,
        shape: RoundedRectangleBorder(
            //borderRadius: new BorderRadius.circular(10.0),
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(3))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
              child: Text(
                btnLabel,
                style: TextStyle(color: btnTextColor, fontSize: fnSize),
              ),
            ),
          ],
        ),
        onPressed: () {
          print('pressed');
          if (action != null) {
            if (isValidatable) {
              if (formKey.currentState.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.

                action();
              }
            }
            else{
              action();
            }
            print('pressed 1');
            
          } else if (routeName != 'pop') {
            print('pressed 2');
            if(argsPushName!=null){
              Navigator.pushNamed(context, routeName, arguments: argsPushName);
            }
            else{
              Navigator.pushNamed(context, routeName);
            }
            
          } else {
            print('pressed 3');
            Navigator.pop(context, popValue);
          }
        },
      ),
    );
  }
}
