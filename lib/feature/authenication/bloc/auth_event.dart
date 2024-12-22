import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/authenication/model/authentication_dto.dart';
import 'package:tastemate_app/feature/authenication/model/verify_otp_dto.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String fullname;
  final String phoneNumber;
  final String password;

  RegisterEvent({
    required this.email,
    required this.fullname,
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [email, fullname, phoneNumber, password];
}

class SendOtpEvent extends AuthEvent {
  final String email;

  SendOtpEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class VerifyOtpEvent extends AuthEvent {
  final VerifyOtpDTO verifyOtpDTO;

  VerifyOtpEvent({required this.verifyOtpDTO});

  @override
  List<Object?> get props => [verifyOtpDTO];
}

class ResetPasswordEvent extends AuthEvent {
  final AuthenticationDTO authenticationDTO;

  ResetPasswordEvent({required this.authenticationDTO});

  @override
  List<Object?> get props => [authenticationDTO];
}

class AuthLogout extends AuthEvent {}
