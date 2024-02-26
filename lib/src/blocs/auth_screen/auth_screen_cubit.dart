import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:revampedai/aaasrc/models/user_model.dart';
import 'package:revampedai/aaasrc/repositories/auth_repo.dart';

part 'auth_screen_state.dart';

class AuthScreenCubit extends Cubit<AuthScreenState> {
  final AuthRepository _authRepository;
  AuthScreenCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthScreenState.initial());

  Future<void> logInWithGoogle() async {
    if (state.status == AuthScreenStatus.submitting) return;
    emit(state.copyWith(status: AuthScreenStatus.submitting));
    try {
      await _authRepository.logInWithGoogle();
      emit(state.copyWith(status: AuthScreenStatus.success));
    } catch (e) {
      print(e);
    }
  }

  Future<void> logInWithApple() async {
    if (state.status == AuthScreenStatus.submitting) return;
    emit(state.copyWith(status: AuthScreenStatus.submitting));
    try {
      await _authRepository.logInWithApple();
      emit(state.copyWith(status: AuthScreenStatus.success));
    } catch (e) {
      print(e);
    }
  }

  Future<void> logInWithFacebook() async {
    if (state.status == AuthScreenStatus.submitting) return;
    emit(state.copyWith(status: AuthScreenStatus.submitting));
    try {
      await _authRepository.logInWithFacebook();
      emit(state.copyWith(status: AuthScreenStatus.success));
    } catch (e) {
      print(e);
    }
  }

  Future<void> logInWithCredentials() async {
    if (state.status == AuthScreenStatus.submitting) return;
    emit(state.copyWith(status: AuthScreenStatus.submitting));
    try {
      print(state.email);
      print(state.password);

      await _authRepository.logInWithEmail(
          email: state.userModel!.email!, password: state.password);
      emit(state.copyWith(status: AuthScreenStatus.success));
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUpWithCredentials() async {
    if (state.status == AuthScreenStatus.submitting) return;
    emit(state.copyWith(status: AuthScreenStatus.submitting));

    try {
      var authUser = await _authRepository.signUpWithEmail(
          userModel: state.userModel!, password: state.password);
      emit(
          state.copyWith(status: AuthScreenStatus.success, authUser: authUser));
    } catch (e) {
      print(e);
    }
  }

  void userChanged(UserModel userModel) {
    print(userModel.email);
    emit(state.copyWith(
      userModel: userModel,
      status: AuthScreenStatus.initial,
    ));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(
      password: password,
      status: AuthScreenStatus.initial,
    ));
  }

  void confrimPasswordChanged(String confirmPassword) {
    emit(state.copyWith(
      confirmPassword: confirmPassword,
      status: AuthScreenStatus.initial,
    ));
  }

  void authFromModeChanged(bool isLoginMode) {
    emit(state.copyWith(
      isLoginMode: !isLoginMode,
      status: AuthScreenStatus.initial,
    ));
  }

  void obscurePasswordToggle(bool obscurePassword) {
    emit(state.copyWith(
      obscurePassword: !obscurePassword,
      status: AuthScreenStatus.initial,
    ));
  }

  void obscureConfirmPasswordToggle(bool obscureConfirmPassword) {
    emit(state.copyWith(
      obscureConfirmPassword: !obscureConfirmPassword,
      status: AuthScreenStatus.initial,
    ));
  }
}
