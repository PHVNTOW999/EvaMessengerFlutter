class AuthStepperState {
  final int currentStep;
  const AuthStepperState({required this.currentStep});

  AuthStepperState copyWith({int? currentStep}) {
    return AuthStepperState(
      currentStep: currentStep ?? this.currentStep,
    );
  }
}
