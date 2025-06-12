abstract class AuthStepperEvent {}

class AuthStepperNextStepEvent extends AuthStepperEvent {}

class AuthStepperPreviousStepEvent extends AuthStepperEvent {}

class AuthStepperGoToStepEvent extends AuthStepperEvent {
  final int step;
  AuthStepperGoToStepEvent(this.step);
}
