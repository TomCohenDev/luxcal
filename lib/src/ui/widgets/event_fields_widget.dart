import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:flutter/material.dart';

class EventFieldsTextfield extends StatelessWidget {
  final TextField textField;
  final String? Function(String?)? validator;

  const EventFieldsTextfield(
      {super.key, required this.textField, this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( 
        borderRadius: BorderRadius.circular(20.0),
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
        enabled: textField.enabled,
        readOnly: textField.readOnly,
        maxLines: textField.maxLines,
        minLines: textField.minLines,
        expands: textField.expands,
        controller: textField.controller,
        textCapitalization: textField.textCapitalization,
        obscureText: textField.obscureText,
        decoration: InputDecoration(
            suffix: textField.decoration?.suffix,
            suffixIcon: textField.decoration?.suffixIcon,
            hintText: textField.decoration?.labelText,
            hintStyle: textField.decoration?.labelStyle ??
                AppTypography.textFieldText.copyWith(fontSize: 16),
            filled: true,
            fillColor: textField.decoration?.fillColor ?? AppPalette.jacarta,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: textField.decoration?.prefixIcon),
        style: textField.style ??
            AppTypography.textFieldText.copyWith(fontSize: 16),
        keyboardType: textField.keyboardType,
        validator: validator ??
            (value) {
              return null;
            },
      ),
    );
  }
}
