import 'package:flutter/material.dart';
import 'package:LuxCal/utils/theme.dart';
import 'package:LuxCal/widgets/custom/model.dart';
import 'package:LuxCal/pages/login/login_model.dart';

import '../../utils/screen_sizes.dart';
import '../../widgets/custom/banner.dart';
import '../../widgets/custom/button.dart';
import '../../widgets/custom/quarter_circle.dart';
import '../../widgets/custom/ring.dart';
import '../../widgets/custom/textfield.dart';
import 'register_logic.dart';
import 'register_model.dart';

class RegisterWidget extends StatefulWidget {

  RegisterWidget({super.key})
;

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final formKey = GlobalKey<FormState>();
  late RegisterModel _model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = createModel(context, () => RegisterModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: ScreenInfo(context).screenHeight,
          width: ScreenInfo(context).screenWidth,
          child: Stack(children: [
            BannerWidget(
              title: "LuxCal",
              showBackButton: true,
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
                child: registerForm(),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget registerForm() {
    double padding = 35;
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: Container()),
          CustomTextField(
            textField: TextField(
              controller: _model.nameTextController,
              textCapitalization: TextCapitalization.none,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Name',
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
            validator: _model.nameTextControllerValidator,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: padding),
            child: CustomTextField(
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
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: padding),
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
              validator: _model.passwordTextControllerValidator,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: padding),
            child: CustomTextField(
              textField: TextField(
                controller: _model.confirmPasswordController,
                textCapitalization: TextCapitalization.none,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
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
              validator: _model.confirmPasswordControllerValidator,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: CustomMainButton(
              buttonText: "Sign Up",
              height: 48,
              onPressed: () async {
                if (!isFormValidated(formKey)) return;
                await signUp(
                    context,
                    _model.emailTextController!.text,
                    _model.passwordTextController!.text,
                    _model.nameTextController!.text);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Already have an account? click here to sign in",
                  style: AppTypography.textfieldText.copyWith(fontSize: 16),
                )),
          ),
          Flexible(child: Container()),
        ],
      ),
    );
  }
}
