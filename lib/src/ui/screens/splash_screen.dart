import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:revampedai/aaacore/theme/theme.dart';
import 'package:revampedai/aaasrc/blocs/auth/auth_bloc.dart';
import 'package:revampedai/aaasrc/ui/screens/temp.dart';
import 'package:revampedai/aaasrc/ui/widgets/splash_icon.dart';
import 'package:revampedai/aaasrc/utils/auth_utils.dart';

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
          // context.read<AuthBloc>().add(AuthLogoutRequested());
          if (context.read<AuthBloc>().state.authUser != null) {
            if (AuthUtils.currentUser.onboarding_complete) {
              context.go('/mainLoadingScreen');
            } else {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => TempScreem(),
              //     ));

              context.go('/terms');
            }
          } else {
            context.go('/auth');
          }
        },
        child: SplashIcon());
  }
}
