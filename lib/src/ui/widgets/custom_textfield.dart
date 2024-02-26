import 'package:flutter/material.dart';
import 'package:revampedai/aaacore/theme/pallette.dart';
import 'package:revampedai/aaacore/theme/theme.dart';
import 'package:revampedai/aaacore/theme/typography.dart';
import 'package:revampedai/aaasrc/ui/widgets/elevated_container_card.dart';
import 'package:revampedai/aaasrc/utils/screen_size.dart';
import 'package:revampedai/custom/flutter_flow_theme.dart';

class CustomTextField extends StatefulWidget {
  final TextField textField;
  final String? Function(String?)? validator;

  CustomTextField({required this.textField, this.validator});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isFocused = false;
  final FocusNode _focusNode = FocusNode();
  @override
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus != isFocused) {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        _backgroundCard(context),
        _textField(context),
      ],
    );
  }

  Widget _textField(BuildContext context) {
    return Container(
      width: ScreenInfo(context).width * 0.9,
      child: Padding(
        padding: const EdgeInsets.only(top: 2, right: 3, left: 3),
        child: TextFormField(
          focusNode: _focusNode,
          onChanged: widget.textField.onChanged,
          controller: widget.textField.controller,
          textCapitalization: widget.textField.textCapitalization,
          obscureText: widget.textField.obscureText,
          decoration: InputDecoration(
              hintText: widget.textField.decoration?.labelText ?? "Label",
              hintStyle: widget.textField.decoration?.labelStyle ??
                  AppTypography.textFieldLabel,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none,
              ),
              fillColor: widget.textField.decoration?.fillColor ??
                  context.theme.colorScheme.surface,
              suffixIcon: widget.textField.decoration?.suffixIcon),
          style: widget.textField.style ?? AppTypography.textFieldText,
          keyboardType: widget.textField.keyboardType,
          validator: widget.validator ?? (value) {},
        ),
      ),
    );
  }

  Widget _backgroundCard(BuildContext context) {
    return Container(
      width: ScreenInfo(context).width * 0.9,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: context.theme.colorScheme.onBackground.withOpacity(0.25),
              spreadRadius: 3,
              blurRadius: 8,
              offset: Offset(0, 6), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(30),
          gradient: isFocused
              ? AppPalette.gradients.main
              : AppPalette.gradients.transparent),
      child: TextFormField(
        enabled: false,
        decoration: InputDecoration(
            hintText: widget.textField.decoration?.labelText ?? "Label",
            hintStyle: widget.textField.decoration?.labelStyle ??
                AppTypography.textFieldLabel,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            fillColor: widget.textField.decoration?.fillColor ??
                context.theme.colorScheme.surface,
            suffixIcon: widget.textField.decoration?.suffixIcon),
        style: widget.textField.style ?? AppTypography.textFieldText,
        keyboardType: widget.textField.keyboardType,
      ),
    );
  }
}
