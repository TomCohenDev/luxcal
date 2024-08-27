import 'dart:async';

import 'package:LuxCal/src/models/user_model.dart';
import 'package:LuxCal/src/repositories/auth_repo.dart';
import 'package:LuxCal/src/repositories/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  StreamSubscription<auth.User?>? _authUserSubscription;
  StreamSubscription<UserModel?>? _userSubscription;

  AuthBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(const AuthState.unknown()) {
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<UserUpdated>(_onUserUpdated);
    on<DeleteUserRequest>(_onDeleteUserRequest);

    // Listen to auth user changes
    _initializeAuthUserListener();
  }

  void _initializeAuthUserListener() {
    _authUserSubscription = _authRepository.user.listen((authUser) async {
      if (authUser != null) {
        print("auth user: ${authUser.email}");
        _userSubscription =
            _userRepository.getUser(authUser.uid).listen((userModel) {
          add(AuthUserChanged(authUser: authUser, userModel: userModel));
        });
      } else {
        add(AuthUserChanged(authUser: null, userModel: null));
      }
    });
  }

  void _onUserUpdated(UserUpdated event, Emitter<AuthState> emit) async {
    try {
      // Update the user in the repository
      await _userRepository.updateUser(event.userModel);

      // Emit the updated authenticated state with the new userModel
      emit(AuthState.authenticated(
        authUser: auth.FirebaseAuth.instance.currentUser!,
        userModel: event.userModel,
      ));
    } catch (e) {
      print('Error updating user: $e');
      // Handle error as needed, possibly emit an error state or log it
    }
  }

  void _onAuthUserChanged(
      AuthUserChanged event, Emitter<AuthState> emit) async {
    print(
        'AuthUserChanged: authUser=${event.authUser?.email}, userModel=${event.userModel}');

    if (event.authUser != null && event.userModel != null) {
      print('AuthUserChanged: authenticated');

      emit(AuthState.authenticated(
        authUser: event.authUser!,
        userModel: event.userModel!,
      ));
    } else {
      print('AuthUserChanged: unauthenticated');
      emit(const AuthState.unauthenticated());
    }
  }

  void _onLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    print('Logout requested');

    await _authRepository.signOut();
    print('Logout completed, state set to unauthenticated');
  }

  @override
  Future<void> close() {
    _authUserSubscription?.cancel();
    _userSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onDeleteUserRequest(
      DeleteUserRequest event, Emitter<AuthState> emit) async {
    await _authRepository.deleteAuthUser();
    emit(const AuthState.unauthenticated());
  }
}
