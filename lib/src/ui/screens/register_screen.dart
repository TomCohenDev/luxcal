import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/blocs/auth/auth_bloc.dart';
import 'package:LuxCal/src/blocs/auth_screen/auth_screen_cubit.dart';
import 'package:LuxCal/src/models/user_model.dart';
import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/ui/widgets/textfield2.dart';
import 'package:LuxCal/src/utils/extensions.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:LuxCal/src/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed.
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthScreenCubit, AuthScreenState>(
      listener: (context, state) {
        if (state.status == AuthScreenStatus.success) {
          context.go('/splash');
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SafeArea(
              child: CustomScaffold(
                body: SingleChildScrollView(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: context.height,
                        width: context.width,
                      ),
                      ..._backgroundCircles(),
                      _body(context),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<Widget> _backgroundCircles() {
    return [
      Positioned(
        top: -80,
        right: -50,
        child: CircleAvatar(
          backgroundColor: Color(0xff008080),
          radius: 90,
        ),
      ),
      Positioned(
        bottom: 270,
        right: 370,
        child: CircleAvatar(
          backgroundColor: Color(0xff875FC0),
          radius: 90,
        ),
      ),
      Positioned(
        bottom: -20,
        right: -40,
        child: CircleAvatar(
          backgroundColor: Color(0xffFF8FBB),
          radius: 40,
        ),
      ),
    ];
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _luxText(),
          spacer(30),
          _header(),
          spacer(20),
          _form(),
          spacer(30),
          _button(context),
          spacer(10),
          _login(),
        ],
      ),
    );
  }

  Widget _button(BuildContext context) {
    return SizedBox(
      width: context.width * 0.7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        onPressed: () {
          final isValid = _formKey.currentState!.validate();
          if (!isValid) return;

          UserModel userModel = UserModel(
            email: emailController.text.trim(),
            fullName: nameController.text.trim(),
            phoneNumber: phoneNumberController.text.trim(),
          );

          context
              .read<AuthScreenCubit>()
              .signUpWithCredentials(userModel, passwordController.text);
        },
        child: Text(
          'Create Account',
          style: AppTypography.buttonText,
        ),
      ),
    );
  }

  Text _header() {
    return Text('Create Account',
        style: GoogleFonts.getFont("Poppins",
            fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold));
  }

  Widget _login() {
    return TextButton(
      child: Text(
        'Click to get back to Login screen',
        style: AppTypography.forgotPassTxt,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _luxText() {
    return Text(
      'LuxCal',
      style: GoogleFonts.poiretOne(fontSize: 50, color: Colors.white),
    );
  }

  Widget _form() => Form(
      key: _formKey,
      child: Column(
        children: [
          _nameFromField(),
          spacer(20),
          _emailFromField(),
          spacer(20),
          _passwordFormField(),
          spacer(20),
          _confirmPasswordFormField(),
          spacer(20),
          _phoneNumberFormField(),
        ],
      ));

  Widget _nameFromField() => CustomTextField2(
        textField: TextField(
          controller: nameController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Full Name",
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Image.asset('assets/icons/mail.png'),
            ),
          ),
        ),
        validator: (value) => Validators.nameValidator(value),
      );

  Widget _emailFromField() => CustomTextField2(
        textField: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Email",
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Image.asset('assets/icons/mail.png'),
            ),
          ),
        ),
        validator: (value) => Validators.emailValidator(value),
      );

  Widget _passwordFormField() => CustomTextField2(
        textField: TextField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 5),
                child: Image.asset('assets/icons/key.png')),
          ),
        ),
        validator: (value) => Validators.passwordValidator(value),
      );

  Widget _confirmPasswordFormField() => CustomTextField2(
        textField: TextField(
          controller: confirmPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Confirm Password",
            prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 5),
                child: Image.asset('assets/icons/key.png')),
          ),
        ),
        validator: (value) =>
            Validators.ConfirmPasswordValidator(passwordController.text, value),
      );

  Widget _phoneNumberFormField() => CustomTextField2(
        textField: TextField(
          controller: phoneNumberController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Phone Number",
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Image.asset('assets/icons/mail.png'),
            ),
          ),
        ),
        validator: (value) => Validators.phoneValidator(value),
      );
}
