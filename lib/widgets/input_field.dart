import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final String label;
  final TextInputType keyType;
  final bool isPasswordField;

  InputFieldWidget(this.label, this.keyType, this.isPasswordField);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        obscureText: isPasswordField,
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
          fillColor: Color.fromRGBO(226, 208, 195, 0.3),
          filled: true,
          labelText: label,
        ),
        validator: (val) {
          if (val.length == 0) {
            return "Amount cannot be empty";
          } else {
            return null;
          }
        },
        keyboardType: keyType,
      ),
    );
  }
}
