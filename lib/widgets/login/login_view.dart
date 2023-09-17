import 'package:flutter/material.dart';
import 'package:luxcal_app/utils/theme.dart';
import 'package:luxcal_app/widgets/custom/model.dart';
import 'package:luxcal_app/widgets/login/login_model.dart';

import '../../utils/screen_sizes.dart';
import '../custom/banner.dart';
import '../custom/button.dart';
import '../custom/quarter_circle.dart';
import '../custom/ring.dart';
import '../custom/textfield.dart';
import 'login_logic.dart';

class LoginWidget extends StatefulWidget {
  final AppTheme theme;
  final AppThemeTypography typography;
  LoginWidget({super.key})
      : theme = AppTheme.lightMode,
        typography = AppThemeTypography(AppTheme.lightMode);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  late LoginModel _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = createModel(context, () => LoginModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: ScreenInfo(context).screenHeight,
        width: ScreenInfo(context).screenWidth,
        child: Stack(children: [
          BannerWidget(
            title: "LuxCal",
            backGroundColor: widget.theme.bannerColor,
            ringColor: widget.theme.bannerLightColor,
            height: ScreenInfo(context).screenHeight * 0.15,
          ),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenInfo(context).screenHeight * 0.15,
                right: 20,
                left: 20),
            child: Container(
              alignment: Alignment.center,
              child: loginForm(),
            ),
          ),
        ]),
      ),
    );
  }

  Widget loginForm() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: Container()),
          CustomTextField(
            textField: TextField(
              controller: _model.emailTextController,
              textCapitalization: TextCapitalization.none,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: widget.typography.textfieldHintText,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: widget.theme.cardColor,
              ),
              style: widget.typography.textfieldText,
              keyboardType: TextInputType.emailAddress,
            ),
            validator: _model.emailTextControllerValidator,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 50),
            child: CustomTextField(
              textField: TextField(
                controller: _model.passwordTextController,
                textCapitalization: TextCapitalization.none,
                obscureText: !_model.passwordVisibility,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: widget.typography.textfieldHintText,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: InkWell(
                    onTap: () => setState(
                      () => _model.passwordVisibility =
                          !_model.passwordVisibility,
                    ),
                    focusNode: FocusNode(skipTraversal: true),
                    child: Icon(
                      _model.passwordVisibility
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: widget.theme.textFieldTextColor,
                      size: 24.0,
                    ),
                  ),
                  fillColor: widget.theme.cardColor,
                ),
                style: widget.typography.textfieldText,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: CustomMainButton(
              buttonText: "Sign In",
              height: 48,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: InkWell(
                onTap: () {
                  navigateToRegisterWidget(context);
                },
                child: Text(
                  "New here? click here to register",
                  style: widget.typography.textfieldText.copyWith(fontSize: 16),
                )),
          ),
          Flexible(child: Container()),
        ],
      ),
    );
  }
}
