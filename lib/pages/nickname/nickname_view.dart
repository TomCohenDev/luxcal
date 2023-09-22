import 'package:flutter/material.dart';
import 'package:LuxCal/utils/theme.dart';
import 'package:LuxCal/widgets/custom/model.dart';
import 'package:LuxCal/pages/login/login_model.dart';

import '../../utils/screen_sizes.dart';
import '../../utils/utils.dart';
import '../../widgets/custom/banner.dart';
import '../../widgets/custom/button.dart';
import '../../widgets/custom/quarter_circle.dart';
import '../../widgets/custom/ring.dart';
import '../../widgets/custom/textfield.dart';
import 'nickname_model.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'nickname_logic.dart';

class NicknameWidget extends StatefulWidget {
  NicknameWidget({super.key});

  @override
  State<NicknameWidget> createState() => _NicknameWidgetState();
}

class _NicknameWidgetState extends State<NicknameWidget> {
  final formKey = GlobalKey<FormState>();
  late NicknameModel _model;

  void changeColor(Color color) {
    setState(() {
      _model.currentColor = color;
      _model.currentColorText = Utils().getColorString(color.toString());
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _model = createModel(context, () => NicknameModel());
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
      body: SingleChildScrollView(
        child: Container(
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
                child: nicknameForm(),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget nicknameForm() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(child: Container()),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: InkWell(
                onTap: () {
                  // navigateToRegisterWidget(context);
                },
                child: Text(
                  "Choose a friendly nickname and a color to distinguish yourself :)",
                  style: AppTypography.textfieldText,
                  textAlign: TextAlign.center,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: CustomTextField(
              textField: TextField(
                controller: _model.nicknameTextController,
                textCapitalization: TextCapitalization.none,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Nickname',
                  labelStyle: AppTypography.textfieldHintText,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: AppColors.cardColor,
                ),
                style: AppTypography.textfieldText.copyWith(
                    color: _model.currentColor ??
                        AppTypography.textfieldHintText.color),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 50),
            child: InkWell(
              onTap: () {
                colorPicker();
              },
              child: IgnorePointer(
                child: CustomTextField(
                  textField: TextField(
                    enabled: false,
                    // controller: _model.colorTextController,
                    textCapitalization: TextCapitalization.none,
                    // obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Color',
                      labelStyle: AppTypography.textfieldHintText,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: _model.currentColor ?? AppColors.cardColor,
                    ),
                    style: AppTypography.textfieldText,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomMainButton(
                  buttonColor: Colors.white,
                  buttonTextColor: Color(0xFF7d54cd),
                  buttonText: "Skip",
                  height: 48,
                  width: 120,
                  onPressed: () {
                    navigateToHomeWidget(context);
                  },
                ),
                CustomMainButton(
                  buttonText: "Confirm",
                  height: 48,
                  width: 120,
                  onPressed: () {
                    Utils.showSnackBar(
                        "Please make sure you have selected a Nickname and a Color");
                    if (!isValidated(_model.nicknameTextController.text,
                        _model.currentColorText)) return;
                    updateNickname(_model.nicknameTextController.text,
                        _model.currentColorText!);
                    navigateToHomeWidget(context);
                  },
                ),
              ],
            ),
          ),
          Flexible(child: Container()),
        ],
      ),
    );
  }

  Future<dynamic> colorPicker() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _model.currentColor ?? Colors.white,
            onColorChanged: changeColor,
          ),
        ),
      ),
    );
  }
}
