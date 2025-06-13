import 'package:eva_messenger_flutter/modules/auth/pages/auth_page.dart';
import 'package:eva_messenger_flutter/modules/auth/service/auth_service.dart';
import 'package:eva_messenger_flutter/modules/auth/store/auth/auth_bloc.dart';
import 'package:eva_messenger_flutter/modules/auth/store/stepper/stepper_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

export '../auth/store/auth/auth_bloc.dart';
export '../auth/store/auth/auth_state.dart';
export '../auth/store/auth/auth_event.dart';

final getIt = GetIt.instance;

// Defines the public interface and routes for the authentication module.
class AuthModule {
  // List of GoRouter routes defined within the Auth module.
  static final List<GoRoute> routes = [
    GoRoute(path: '/auth', builder: (context, state) => AuthPage()),
  ];

  // Setup Auth Dependencies
  void setupAuthDI() async {
    print('=== Setting up dependencies... ===');

    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    getIt.registerLazySingleton<AuthService>(() => AuthService());
    getIt.registerSingleton<AuthBloc>(AuthBloc(getIt<AuthService>()));
    getIt.registerFactory<AuthStepperBloc>(() => AuthStepperBloc());

    print('=== AuthBloc registered: ${getIt.isRegistered<AuthBloc>()} ===');
  }
}
