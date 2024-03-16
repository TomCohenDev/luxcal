import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:flutter/material.dart';

class CustomTextField2 extends StatelessWidget {
  final TextField textField;
  final bool isHint;

  final String? Function(String?)? validator;

  const CustomTextField2(
      {super.key,
      required this.textField,
      this.validator,
      this.isHint = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textField.textAlign,
      controller: textField.controller,
      textCapitalization: textField.textCapitalization,
      obscureText: textField.obscureText,
      decoration: InputDecoration(
        hintStyle:
            textField.decoration?.hintStyle ?? AppTypography.textFieldHint,
        hintText: textField.decoration?.hintText,
        labelText: textField.decoration?.labelText,
        labelStyle: textField.decoration?.labelStyle ??
            AppTypography.textFieldHint
                .copyWith(fontWeight: FontWeight.w300, fontSize: 14),
        filled: false,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppPalette.crayola, strokeAlign: 5)),
      ),
      style: textField.style ?? AppTypography.textFieldText,
      keyboardType: textField.keyboardType,
      validator: validator ??
          (value) {
            return null;
          },
    );
  }
}
