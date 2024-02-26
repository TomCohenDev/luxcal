import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:revampedai/aaacore/theme/pallette.dart';
import 'package:revampedai/aaacore/theme/theme.dart';
import 'package:revampedai/aaacore/theme/typography.dart';
import 'package:revampedai/aaasrc/blocs/auth_screen/auth_screen_cubit.dart';

import 'package:revampedai/aaasrc/ui/dialogs/forgot_password_dialog.dart';
import 'package:revampedai/aaasrc/ui/widgets/custom_scaffolds.dart';
import 'package:revampedai/aaasrc/ui/widgets/custom_textfield.dart';
import 'package:revampedai/aaasrc/ui/widgets/floating_circle_button.dart';
import 'package:revampedai/aaasrc/ui/widgets/main_button.dart';
import 'package:revampedai/aaasrc/ui/widgets/revamped_logo.dart';
import 'package:revampedai/aaasrc/ui/widgets/spacer.dart';

import 'package:revampedai/aaasrc/utils/screen_size.dart';
import 'package:revampedai/aaasrc/utils/validators.dart';
import 'package:revampedai/backend/firebase_analytics/analytics.dart';

class AuthScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthScreenCubit, AuthScreenState>(
      listener: (context, state) {
        if (state.status == AuthScreenStatus.success) {
          context.go('/emailVerification');
        }
      },
      child: CustomScaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              spacer(30),
              Center(child: RevampedLogo(scale: 1.1)),
              spacer(50),
              _form(),
              spacer(50),
              _authButton(),
              spacer(20),
              _forgotPassword(context),
              spacer(30),
              loginProvidersDivider(context),
              spacer(15),
              loginProvidersLine(),
              spacer(20),
              _authTriggerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _authButton() => BlocBuilder<AuthScreenCubit, AuthScreenState>(
        builder: (context, state) {
          final isLoginMode = context.read<AuthScreenCubit>().state.isLoginMode;
          return MainButton(
              buttonText: isLoginMode ? "Log In" : "Sign Up",
              onPressed: () {
                final isValid = formKey.currentState!.validate();
                if (!isValid) return;
                isLoginMode
                    ? context.read<AuthScreenCubit>().logInWithCredentials()
                    : context.read<AuthScreenCubit>().signUpWithCredentials();
              });
        },
      );

  Widget _authTriggerButton(context) => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 3.0, 0.0),
            child: Text('Don\'t have an account?', style: AppTypography.body18),
          ),
          BlocBuilder<AuthScreenCubit, AuthScreenState>(
            builder: (context, state) {
              final isLoginMode =
                  context.read<AuthScreenCubit>().state.isLoginMode;
              return InkWell(
                  enableFeedback: false,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    logFirebaseEvent('login_page',
                        parameters: {'navigation': 'register'});
                    context
                        .read<AuthScreenCubit>()
                        .authFromModeChanged(isLoginMode);
                  },
                  child: Text(!isLoginMode ? "Log In" : "Sign Up",
                      style: AppTypography.link));
            },
          ),
        ],
      );

  Widget _form() => Form(
      key: formKey,
      child: Column(
        children: [
          _emailFromField(),
          spacer(20),
          _passwordFormField(),
          spacer(20),
          _confirmPasswordFormField(),
        ],
      ));

  Widget _emailFromField() => BlocBuilder<AuthScreenCubit, AuthScreenState>(
        builder: (context, state) {
          return CustomTextField(
            textField: TextField(
              onChanged: (email) => context
                  .read<AuthScreenCubit>()
                  .userChanged(state.userModel!.copyWith(email: email)),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: "Email"),
            ),
            validator: (value) => Validators.emailValidator(value),
          );
        },
      );

  Widget _passwordFormField() => BlocBuilder<AuthScreenCubit, AuthScreenState>(
        builder: (context, state) {
          final obscurePassword =
              context.read<AuthScreenCubit>().state.obscurePassword;

          return CustomTextField(
            textField: TextField(
              onChanged: (password) =>
                  context.read<AuthScreenCubit>().passwordChanged(password),
              obscureText: obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: InkWell(
                  onTap: () => context
                      .read<AuthScreenCubit>()
                      .obscurePasswordToggle(obscurePassword),
                  child: Icon(
                    obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: context.theme.colorScheme.onSecondary,
                    size: 24.0,
                  ),
                ),
              ),
            ),
            validator: (value) => Validators.passwordValidator(value),
          );
        },
      );

  Widget _confirmPasswordFormField() =>
      BlocBuilder<AuthScreenCubit, AuthScreenState>(
        builder: (context, state) {
          final obscureConfirmPassword =
              context.read<AuthScreenCubit>().state.obscureConfirmPassword;
          final isLoginMode = context.read<AuthScreenCubit>().state.isLoginMode;
          return !isLoginMode
              ? CustomTextField(
                  textField: TextField(
                    obscureText: obscureConfirmPassword,
                    decoration: InputDecoration(
                      labelText: "Confirm password",
                      suffixIcon: InkWell(
                        onTap: () => context
                            .read<AuthScreenCubit>()
                            .obscureConfirmPasswordToggle(
                                obscureConfirmPassword),
                        child: Icon(
                          obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: context.theme.colorScheme.onSecondary,
                          size: 24.0,
                        ),
                      ),
                    ),
                  ),
                  validator: (value) => Validators.ConfirmPasswordValidator(
                      context.read<AuthScreenCubit>().state.password, value),
                )
              : Container();
        },
      );

  Widget loginProvidersLine() => BlocBuilder<AuthScreenCubit, AuthScreenState>(
        builder: (context, state) {
          final blocProvider = context.read<AuthScreenCubit>();
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FloatingCircleButton(
                onPressed: () => blocProvider.logInWithFacebook(),
                icon: FontAwesomeIcons.facebookF,
              ),
              FloatingCircleButton(
                onPressed: () => blocProvider.logInWithApple(),
                icon: FontAwesomeIcons.apple,
              ),
              FloatingCircleButton(
                onPressed: () => blocProvider.logInWithGoogle(),
                icon: FontAwesomeIcons.google,
              ),
            ],
          );
        },
      );

  Widget _line(context) => Expanded(
        child: Container(
          height: 2,
          width: ScreenInfo(context).width * 0.1,
          color: Colors.grey,
        ),
      );

  Widget loginProvidersDivider(context) => Row(
        children: [
          _line(context),
          Container(
            width: 140.0,
            decoration: BoxDecoration(),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Text('or Log In with',
                textAlign: TextAlign.center, style: AppTypography.body18),
          ),
          _line(context),
        ],
      );

  Widget _forgotPassword(context) => InkWell(
        onTap: () async {
          logFirebaseEvent('login_page', parameters: {
            'action': 'forgot_password',
            'navigation': 'forgot_password'
          });
          forgotPasswordDialog(context);
        },
        child: Text('Forgot Password?', style: AppTypography.link),
      );
}
