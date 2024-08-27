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
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        print('SplashScreen: AuthState changed: ${state.status}');
        if (state.status == AuthStatus.authenticated) {
          print(state.userModel?.nickName);
          if (state.userModel?.nickName != null ||
              state.userModel?.email == 'admin@luxcal.com') {
            context.push('/calendar');
          } else {
            print('SplashScreen: No nickname found');
            context.push('/nickname');
          }
        } else if (state.status == AuthStatus.unauthenticated) {
          context.push('/login');
        }
      },
      child: Container(
          color: context.theme.scaffoldBackgroundColor,
          child: const SplashIcon()),
    );
  }
}
