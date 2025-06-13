import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _firebaseAuthService;
  StreamSubscription<User?>? _userSubscription;

  AuthBloc(this._firebaseAuthService) : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<AuthUserChanged>(_onAuthUserChanged);
    on<LogoutEvent>(_onLogout);

    _userSubscription = _firebaseAuthService.user.listen((user) {
      add(AuthUserChanged(user?.uid));
    });
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuthService.sendOtp(
        phoneNumber: event.phoneNumber,
        codeSent: (verificationId, resendToken) {
          emit(CodeSentSuccess(verificationId));
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthFailure(e.message ?? 'Error when sending OTP'));
        },
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onVerifyOtp(VerifyOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      User? user = await _firebaseAuthService.verifyOtp(
        verificationId: event.verificationId,
        otp: event.otp,
      );
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(const AuthFailure('Invalid OTP or another error.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Error while verifying OTP'));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    final currentUser = _firebaseAuthService.getCurrentUser();
    if (currentUser != null) {
      emit(AuthSuccess(currentUser));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _firebaseAuthService.signOut();
    emit(Unauthenticated());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}