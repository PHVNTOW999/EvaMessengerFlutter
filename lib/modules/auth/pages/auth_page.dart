import 'package:eva_messenger_flutter/modules/auth/widgets/auth_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../store/stepper/stepper_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth')),
      body: Center(
        child: BlocProvider<AuthStepperBloc>.value(
          value: GetIt.I<AuthStepperBloc>(),
          child: AuthStepper(),
        ),
      ),
    );
  }
}
