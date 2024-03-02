import 'package:LuxCal/core/theme/theme.dart';
import 'package:LuxCal/src/blocs/auth/auth_bloc.dart';
import 'package:LuxCal/src/ui/widgets/splash_icon.dart';
import 'package:LuxCal/src/utils/auth_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      // listenWhen: (previous, current) => previous.authUser != current.authUser,
      listener: (context, state) {
        if (context.read<AuthBloc>().state.authUser != null) {
          if (AuthUtils.currentUser.nickName != null) {
            context.go('/calendar');
          } else {
            context.go('/nickname');
          }
        } else {
          context.go('/login');
        }
      },
      child: Container(
          color: context.theme.scaffoldBackgroundColor,
          child: const SplashIcon()),
    );
  }
}
