import 'package:flutter/material.dart';

class InputFieldMultiLineWidget extends StatelessWidget {
  final String label;
  final int lines;

  InputFieldMultiLineWidget(this.label, this.lines);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        maxLines: lines,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),        
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.only(topRight: Radius.circular(20)),
            borderSide: new BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.only(topRight: Radius.circular(20)),
            borderSide: new BorderSide(
                color: Color.fromRGBO(226, 208, 195, 1), width: 2.0),
          ),
          fillColor: Colors.transparent,
          filled: true,
          labelText: label,
        ),
        validator: (val) {
          if (val.length == 0) {
            return "Description can't be empty";
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.text,
      ),
    );
  }
}
