import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  const SendOtpEvent(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String otp;

  const VerifyOtpEvent(this.verificationId, this.otp);

  @override
  List<Object> get props => [verificationId, otp];
}

class AuthUserChanged extends AuthEvent {
  final String? uid;

  const AuthUserChanged(this.uid);

  @override
  List<Object> get props => [uid ?? ''];
}

class LogoutEvent extends AuthEvent {}