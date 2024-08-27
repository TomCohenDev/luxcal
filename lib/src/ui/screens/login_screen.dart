import 'package:LuxCal/core/theme/pallette.dart';
import 'package:LuxCal/core/theme/typography.dart';
import 'package:LuxCal/src/blocs/auth_screen/auth_screen_cubit.dart';
import 'package:LuxCal/src/models/user_model.dart';
import 'package:LuxCal/src/ui/widgets/custom_scaffold.dart';
import 'package:LuxCal/src/ui/widgets/elevated_container_card.dart';
import 'package:LuxCal/src/ui/widgets/spacer.dart';
import 'package:LuxCal/src/ui/widgets/splash_icon.dart';
import 'package:LuxCal/src/utils/screen_size.dart';
import 'package:LuxCal/src/utils/validators.dart';
import 'package:LuxCal/src/ui/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final isDev = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthScreenCubit, AuthScreenState>(
      listener: (context, state) {
        if (state.status == AuthScreenStatus.success) {
          context.go('/splash');
        }
        if (state.status == AuthScreenStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid email or password'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                SizedBox(
                  height: context.height,
                  width: context.width,
                ),
                ..._backgroundCircles(),
                _body(),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _backgroundCircles() {
    return [
      Positioned(
        top: -60,
        left: -60,
        child: CircleAvatar(
          backgroundColor: Color(0xff1C9FE9),
          radius: 90,
        ),
      ),
      Positioned(
        bottom: 135,
        right: -50,
        child: CircleAvatar(
          backgroundColor: Color(0xff86D8CA),
          radius: 45,
        ),
      ),
      Positioned(
        bottom: -35,
        right: 350,
        child: CircleAvatar(
          backgroundColor: Color(0xffFCB833),
          radius: 40,
        ),
      ),
    ];
  }

  Widget _body() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          spacer(50),
          _luxIcon(),
          if (isDev) _devLogin(),
          spacer(20),
          _header(),
          spacer(20),
          _form(),
          _forgotPass(),
          spacer(20),
          _button(context),
          spacer(20),
          _signUp(),
        ],
      ),
    );
  }

  Widget _devLogin() {
    return ElevatedContainerCard(
      child: Column(children: [
        ElevatedButton(
          onPressed: () {
            emailController.text = 'admin@luxcal.com';
            passwordController.text = 'luxcaladmin';
            context
                .read<AuthScreenCubit>()
                .passwordChanged(passwordController.text);
            context
                .read<AuthScreenCubit>()
                .userChanged(UserModel(email: emailController.text.trim()));

            context.read<AuthScreenCubit>().logInWithCredentials();
          },
          child: Text('Login as Admin'),
        ),
        ElevatedButton(
          onPressed: () {
            emailController.text = 'tom.cohen99@gmail.com';
            passwordController.text = '123456';
            context
                .read<AuthScreenCubit>()
                .passwordChanged(passwordController.text);
            context
                .read<AuthScreenCubit>()
                .userChanged(UserModel(email: emailController.text.trim()));

            context.read<AuthScreenCubit>().logInWithCredentials();
          },
          child: Text('Login as Tom'),
        ),
      ]),
    );
  }

  Widget _button(BuildContext context) {
    return Container(
      width: context.width * 0.7,
      child: ElevatedButton(
        child: Text(
          'Sign In',
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
          context
              .read<AuthScreenCubit>()
              .passwordChanged(passwordController.text);
          context
              .read<AuthScreenCubit>()
              .userChanged(UserModel(email: emailController.text.trim()));
          final isValid = _formKey.currentState!.validate();
          if (!isValid) return;

          context.read<AuthScreenCubit>().logInWithCredentials();
        },
      ),
    );
  }

  Text _header() {
    return Text('Login',
        style: GoogleFonts.getFont("Poppins",
            fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold));
  }

  Align _forgotPass() {
    return Align(
      alignment: const Alignment(0.8, 0),
      child: TextButton(
        child: Text(
          'Forgot Password?',
          style: AppTypography.forgotPassTxt,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _signUp() {
    return TextButton(
      child: Text(
        'Click to Create an account',
        style: AppTypography.forgotPassTxt,
      ),
      onPressed: () {
        context.push('/register');
      },
    );
  }

  Widget _luxIcon() {
    return Image.asset(
      'assets/icons/icon.png',
      scale: 0.65,
    );
  }

  Widget _form() => Form(
      key: _formKey,
      child: Column(
        children: [
          _emailFromField(),
          spacer(20),
          _passwordFormField(),
        ],
      ));

  Widget _emailFromField() => CustomTextField(
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
        validator: (value) => Validators.nameValidator(value),
      );

  Widget _passwordFormField() => CustomTextField(
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
}
