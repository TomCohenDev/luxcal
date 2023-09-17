import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextField textField;
  final String? Function(String?)? validator;

  CustomTextField({required this.textField, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: textField.controller,
        textCapitalization: textField.textCapitalization,
        obscureText: textField.obscureText,
        decoration: InputDecoration(
          labelText: textField.decoration?.labelText,
          labelStyle: textField.decoration?.labelStyle,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
          fillColor: textField.decoration?.fillColor,
        ),
        style: textField.style,
        keyboardType: textField.keyboardType,
        validator: validator ?? (value) {},
      ),
    );
  }
}
