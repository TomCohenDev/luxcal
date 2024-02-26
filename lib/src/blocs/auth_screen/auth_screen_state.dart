part of 'auth_screen_cubit.dart';

enum AuthScreenStatus { initial, submitting, success, error }

class AuthScreenState extends Equatable {
  final String email;
  final String password;
  final String? confirmPassword;
  final AuthScreenStatus status;
  final auth.User? authUser;
  final UserModel? userModel;
  final bool isLoginMode;
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  const AuthScreenState({
    required this.email,
    required this.password,
    this.confirmPassword,
    required this.status,
    this.authUser,
    this.userModel,
    this.isLoginMode = true,
    this.obscureConfirmPassword = true,
    this.obscurePassword = true,
  });

  factory AuthScreenState.initial() {
    return  AuthScreenState(
      email: '',
      password: '',
      confirmPassword: '',
      status: AuthScreenStatus.initial,
      authUser: null,
      userModel: UserModel(),
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        status,
        authUser,
        userModel,
        isLoginMode,
        obscurePassword,
        obscureConfirmPassword
      ];

  AuthScreenState copyWith(
      {String? email,
      String? password,
      String? confirmPassword,
      AuthScreenStatus? status,
      auth.User? authUser,
      UserModel? userModel,
      bool? isLoginMode,
      bool? obscurePassword,
      bool? obscureConfirmPassword}) {
    return AuthScreenState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      authUser: authUser ?? this.authUser,
      userModel: userModel ?? this.userModel,
      isLoginMode: isLoginMode ?? this.isLoginMode,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }
}
