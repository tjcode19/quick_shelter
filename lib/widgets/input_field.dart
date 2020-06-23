import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final String label;
  final TextInputType keyType;
  final bool isPasswordField;
  final TextCapitalization capitalizationType;
  final TextEditingController controller;
  final Color color;
  final String errorMsg;
  final bool enableField;
  final String cPassword;
  final Function onChange;

  InputFieldWidget(this.label, this.keyType, this.isPasswordField,
      {this.capitalizationType: TextCapitalization.words,
      this.controller,
      this.color: Colors.white,
      this.errorMsg,
      this.enableField: true,
      this.cPassword, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onChanged: onChange,
        enabled: enableField,
        controller: controller,
        textCapitalization: capitalizationType,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
        obscureText: isPasswordField,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(4)),
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
          if (val.isEmpty) {
            return errorMsg;
          } else {
            if (cPassword!=null) {
              print(cPassword);
              print(val);
              if (cPassword != val) {
                return errorMsg;
              } else
                return null;
            }
            return null;
          }
        },
        keyboardType: keyType,
      ),
    );
  }
}
