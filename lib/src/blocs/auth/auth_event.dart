part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserChanged extends AuthEvent {
  final auth.User? authUser;
  final UserModel? userModel;
  const AuthUserChanged({
    required this.authUser,
    this.userModel,
  });
  @override
  List<Object?> get props => [authUser, userModel];
}

class AuthLogoutRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}

class UserUpdated extends AuthEvent {
  final UserModel userModel;

  UserUpdated(this.userModel);

  @override
  List<Object> get props => [userModel];
}

class DeleteUserRequest extends AuthEvent {
  @override
  List<Object> get props => [];
}
