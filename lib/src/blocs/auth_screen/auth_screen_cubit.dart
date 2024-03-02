import 'package:LuxCal/src/models/user_model.dart';
import 'package:LuxCal/src/repositories/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

part 'auth_screen_state.dart';

class AuthScreenCubit extends Cubit<AuthScreenState> {
  final AuthRepository _authRepository;
  AuthScreenCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthScreenState.initial());

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
