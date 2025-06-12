import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eva_messenger_flutter/modules/auth/store/stepper/stepper_state.dart';
import 'package:eva_messenger_flutter/modules/auth/store/stepper/stepper_events.dart';

class AuthStepperBloc extends Bloc<AuthStepperEvent, AuthStepperState> {
  AuthStepperBloc() : super(const AuthStepperState(currentStep: 0)) {
    on<AuthStepperNextStepEvent>((event, emit) {
      if (state.currentStep < 1) {
        emit(state.copyWith(currentStep: state.currentStep + 1));
      }
    });

    on<AuthStepperPreviousStepEvent>((event, emit) {
      if (state.currentStep > 0) {
        emit(state.copyWith(currentStep: state.currentStep - 1));
      }
    });

    on<AuthStepperGoToStepEvent>((event, emit) {
      emit(state.copyWith(currentStep: event.step));
    });
  }
}
