import 'package:flutter/material.dart';
import 'package:LuxCal/utils/theme.dart';
import 'package:LuxCal/widgets/custom/model.dart';
import 'package:LuxCal/pages/login/login_model.dart';

import '../../utils/screen_sizes.dart';
import '../../widgets/custom/banner.dart';
import '../../widgets/custom/button.dart';
import '../../../../lib/src/ui/widgets/textfield.dart';
import 'login_logic.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
      body: SizedBox(
        height: ScreenInfo(context).screenHeight,
        width: ScreenInfo(context).screenWidth,
        child: Stack(children: [
          BannerWidget(
            title: "LuxCal",
            backGroundColor: AppColors.bannerColor,
            ringColor: AppColors.bannerLightColor,
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
      key: _model.formKey,
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
                labelStyle: AppTypography.textfieldHintText,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
                fillColor: AppColors.cardColor,
              ),
              style: AppTypography.textfieldText,
              keyboardType: TextInputType.emailAddress,
            ),
            validator: _model.emailTextControllerValidator,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 50),
            child: CustomTextField(
              textField: TextField(
                controller: _model.passwordTextController,
                textCapitalization: TextCapitalization.none,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: AppTypography.textfieldHintText,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: AppColors.cardColor,
                ),
                style: AppTypography.textfieldText,
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
                await signIn(context, _model);
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
                  style: AppTypography.textfieldText.copyWith(fontSize: 16),
                )),
          ),
          Flexible(child: Container()),
        ],
      ),
    );
  }
}
