import 'package:flutter/material.dart';


class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextInputType textType;
  final bool obscureText;
  final TextEditingController controller;
  final Function validator;

  TextFormFieldWidget({
    @required this.hintText,
    this.textType,
    this.obscureText = false,
    this.controller,
    @required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: textType,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white54,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
