import 'package:LuxCal/core/config/app_router.dart';
import 'package:LuxCal/core/theme/theme.dart';
import 'package:LuxCal/src/blocs/auth/auth_bloc.dart';
import 'package:LuxCal/src/blocs/auth_screen/auth_screen_cubit.dart';
import 'package:LuxCal/src/repositories/auth_repo.dart';
import 'package:LuxCal/src/repositories/user_repo.dart';
import 'package:LuxCal/temp/utils/utils.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

final GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(userRepository: getIt<UserRepository>()));

  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(
        authRepository: getIt<AuthRepository>(),
        userRepository: getIt<UserRepository>(),
      ));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  // await Notifications().initNotifications();
  setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: getIt<UserRepository>()),
        RepositoryProvider.value(value: getIt<AuthRepository>()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => getIt<AuthBloc>(),
          ),
          BlocProvider<AuthScreenCubit>(
            create: (context) => AuthScreenCubit(
              authRepository: getIt<AuthRepository>(),
            ),
          ),
        ],
        child: CalendarControllerProvider(
          controller: EventController(),
          child: MaterialApp.router(
            scaffoldMessengerKey: Utils.messengerKey,
            debugShowCheckedModeBanner: false,
            title: 'LuxCal',
            theme: AppTheme.mainTheme,
            routerConfig: router,
          ),
        ),
      ),
    );
  }
}
