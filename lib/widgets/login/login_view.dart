import 'package:flutter/material.dart';
import 'package:LuxCal/utils/theme.dart';
import 'package:LuxCal/widgets/custom/model.dart';
import 'package:LuxCal/widgets/login/login_model.dart';

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
  void dispose() {
    _model.dispose();

    super.dispose();
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
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: CustomMainButton(
              buttonText: "Sign In",
              height: 48,
              onPressed: () async {
                if (!isFormValidated(formKey)) return;
                await signIn(
                  context,
                  _model.emailTextController.text.trim(),
                  _model.passwordTextController.text.trim(),
                );
                navigateToHomeWidget(context);
              },
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
