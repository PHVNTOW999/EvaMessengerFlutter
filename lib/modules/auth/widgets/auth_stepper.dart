import 'package:eva_messenger_flutter/core/widgets/loader.dart';
import 'package:eva_messenger_flutter/modules/auth/components/auth_step_otp.dart';
import 'package:eva_messenger_flutter/modules/auth/store/auth/auth_state.dart';
import 'package:eva_messenger_flutter/modules/auth/store/stepper/stepper_bloc.dart';
import 'package:eva_messenger_flutter/modules/auth/store/stepper/stepper_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/auth_step_phone.dart';

/// A custom stepper widget to indicate the current step in the authentication flow.
class AuthStepper extends StatelessWidget {
  const AuthStepper({super.key});

  @override
  Widget build(BuildContext context) {
    final authStepperBloc = context.read<AuthStepperBloc>();

    return BlocBuilder<AuthStepperBloc, AuthStepperState>(
      bloc: authStepperBloc,
      builder: (context, state) {
        if (state is AuthLoading) {
          return Loading();
        } else {
          return Stepper(
            type: StepperType.horizontal,
            currentStep: state.currentStep,
            controlsBuilder: (context, details) => SizedBox.shrink(),
            steps: [AuthStepPhone.build(context), AuthStepOTP.build(context)],
          );
        }
      },
    );
  }
}
