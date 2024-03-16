import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextField textField;
  final String? Function(String?)? validator;

  const CustomTextField({super.key, required this.textField, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: textField.controller,
        textCapitalization: textField.textCapitalization,
        obscureText: textField.obscureText,
        decoration: InputDecoration(
            hintText: textField.decoration?.labelText,
            hintStyle:
                textField.decoration?.labelStyle ?? AppTypography.textFieldHint,
            filled: true,
            fillColor: AppPalette.jacarta,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: textField.decoration?.prefixIcon),
        style: textField.style ?? AppTypography.textFieldText,
        keyboardType: textField.keyboardType,
        validator: validator ??
            (value) {
              return null;
            },
      ),
    );
  }
}
