import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/blocs/auth/auth_bloc.dart';
import 'package:LuxCal/src/models/user_model.dart';
import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/ui/widgets/textfield2.dart';
import 'package:LuxCal/src/utils/auth_utils.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:LuxCal/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class NicknameScreen extends StatefulWidget {
  const NicknameScreen({super.key});

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> {
  final formKey = GlobalKey<FormState>();
  // Controllers
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController colorHexController = TextEditingController();
  Color selectedColor = Colors.red;

  @override
  void dispose() {
    final formKey = GlobalKey<FormState>();
    nicknameController.dispose();
    colorHexController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: SizedBox(
            height: context.height,
            width: context.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _luxText(),
                spacer(20),
                _nickname(),
                spacer(30),
                _colorPicker(),
                spacer(20),
                _button(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedContainerCard _colorPicker() {
    return ElevatedContainerCard(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 16, left: 16, right: 16),
      child: Column(
        children: [
          Text(
            "Choose a color for your nickname",
            style: AppTypography.textFieldHint,
            textAlign: TextAlign.center,
          ),
          spacer(20),
          MaterialColorPicker(
            allowShades: false,
            selectedColor: selectedColor,
            spacing: 15,
            onMainColorChange: (colorSwatch) {
              final int colorValue = colorSwatch!.value;
              setState(() => selectedColor = Color(colorValue));
              AuthUtils.currentUser.nickNameColor = Color(colorValue);
            },
          )
        ],
      ),
    ));
  }

  ElevatedContainerCard _nickname() {
    return ElevatedContainerCard(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 30, top: 16, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Create your nickname", style: AppTypography.textFieldHint),
          CustomTextField2(
            textField: TextField(
              textAlign: TextAlign.center,
              controller: nicknameController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(),
            ),
            validator: (value) => Validators.emailValidator(value),
          )
        ],
      ),
    ));
  }

  Widget _luxText() {
    return Text(
      'LuxCal',
      style: GoogleFonts.poiretOne(fontSize: 50, color: Colors.white),
    );
  }

  Widget _button(BuildContext context) {
    return Container(
      width: context.width * 0.7,
      child: ElevatedButton(
        child: Text(
          'Continue',
          style: AppTypography.buttonText,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        onPressed: () {
          AuthUtils.currentUser.nickName = nicknameController.text;
          context.read<AuthBloc>().add(UserUpdated(AuthUtils.currentUser));
          context.go('/calendar');
        },
      ),
    );
  }
}
