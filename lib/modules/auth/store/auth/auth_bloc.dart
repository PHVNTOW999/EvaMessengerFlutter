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
          print('verID $verificationId');
          emit(CodeSentSuccess(verificationId));
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthFailure(e.message ?? 'Ошибка при отправке OTP'));
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
        print('=== USER AUTHED $user ===');
        emit(AuthSuccess(user));
      } else {
        emit(const AuthFailure('Неверный OTP или произошла ошибка.'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Ошибка при верификации OTP'));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.uid != null) {
      // Если пользователь уже вошел в систему, можно получить его данные
      // или просто перевести в AuthSuccess с текущим пользователем.
      final currentUser = _firebaseAuthService.getCurrentUser();
      if (currentUser != null) {
        print('=== USER AUTHED ===');
        emit(AuthSuccess(currentUser));
      } else {
        emit(Unauthenticated());
      }
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