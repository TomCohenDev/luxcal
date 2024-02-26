// auth_utils.dart
import 'package:get_it/get_it.dart';
import 'package:revampedai/aaasrc/blocs/auth/auth_bloc.dart';
import 'package:revampedai/aaasrc/models/user_model.dart';

class AuthUtils {
  static UserModel get currentUser {
    final AuthBloc authBloc = GetIt.instance<AuthBloc>();
    if (authBloc.state.status == AuthStatus.authenticated) {
      UserModel? userModel = authBloc.state.userModel;
      if (userModel != null) {
        return authBloc.state.userModel!;
      } else {
        print(
            "User model is null. The user might not be fully authenticated or the user data is not available.");
      }
    } else {
      print("User is not authenticated. Cannot access user model.");
    }

    return UserModel();
  }

  static String get currentUserId {
    return (currentUser.uid)!;
  }
}
