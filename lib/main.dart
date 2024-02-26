import 'package:LuxCal/navigation/navigation.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:LuxCal/utils/utils.dart';
import 'package:LuxCal/pages/first_screen/first_screen_page.dart';
import 'package:LuxCal/pages/home/home_view.dart';
import 'package:LuxCal/pages/login/login_page.dart';
import 'package:LuxCal/pages/nickname/nickname_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepository(userRepository: getIt<UserRepository>()));
  getIt.registerLazySingleton<SizesRepository>(() => SizesRepository());

  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(
        authRepository: getIt<AuthRepository>(),
        userRepository: getIt<UserRepository>(),
      ));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await Notifications().initNotifications();
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

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
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: Utils.messengerKey,
            home: !storage.read('display_first_screen')
                ? (currentUser != null && currentUser!.loggedIn)
                    ? NavigationWidget()
                    : LoginWidget()
                : FirstScreenWidget(),
          ),
        ),
      ),
    );
  }
}
