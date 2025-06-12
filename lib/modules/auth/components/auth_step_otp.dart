import 'package:eva_messenger_flutter/modules/auth/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eva_messenger_flutter/modules/auth/store/stepper/stepper_bloc.dart';
import 'package:get_it/get_it.dart';

import '../store/auth/auth_bloc.dart';
import '../store/auth/auth_event.dart';

class AuthStepOTP {
  static Step build(BuildContext context) {
    final state = context.watch<AuthStepperBloc>().state;

    final AuthBloc _authBloc = GetIt.I<AuthBloc>();
    final AuthService _authService = GetIt.I<AuthService>();

    final _formKey = GlobalKey<FormState>();
    final _otpController = TextEditingController();

    return Step(
      isActive: state.currentStep >= 1,
      state: state.currentStep > 1 ? StepState.complete : StepState.editing,
      title: const Text('Phone Number'),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter OTP code from SMS'),
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a OTP code';
                }
                if (!RegExp(r"^\d{6}$").hasMatch(_otpController.text.trim())) {
                  return 'Please enter a valid otp number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final verificationId = _authService.verificationId;

                  if (verificationId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Verification ID not found. Try again."),
                      ),
                    );
                    return;
                  }

                  print('=== VER_ID: $verificationId ===');

                  GetIt.I<AuthBloc>().add(
                    VerifyOtpEvent(verificationId, _otpController.text.trim()),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
