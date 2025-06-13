import 'package:eva_messenger_flutter/modules/auth/store/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eva_messenger_flutter/modules/auth/store/stepper/stepper_bloc.dart';
import 'package:eva_messenger_flutter/modules/auth/store/stepper/stepper_events.dart';
import 'package:get_it/get_it.dart';

import '../store/auth/auth_bloc.dart';

class AuthStepPhone {
  static Step build(BuildContext context) {
    final bloc = context.read<AuthStepperBloc>();
    final state = context.watch<AuthStepperBloc>().state;

    final _formKey = GlobalKey<FormState>();
    final _phoneController = TextEditingController();

    return Step(
      isActive: state.currentStep >= 0,
      state: state.currentStep > 0 ? StepState.complete : StepState.editing,
      title: const Text('Phone Number'),
      content: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Enter Phone Number'),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                if (!RegExp(r'^(\+|00)?[0-9]+$').hasMatch(_phoneController.text.trim())) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  GetIt.I<AuthBloc>().add(SendOtpEvent(_phoneController.text.trim()));
                  bloc.add(AuthStepperNextStepEvent());
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
