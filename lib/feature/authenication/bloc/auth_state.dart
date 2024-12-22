import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/authenication/model/user_dto.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserDTO user;

  AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UserCreated extends AuthState {
  UserCreated();
}

class AuthSuccessOtpSent extends AuthState {
  AuthSuccessOtpSent();

  @override
  List<Object?> get props => [];
}

// New states for ResetPasswordEvent and VerifyOtpEvent
class OtpVerified extends AuthState {
  OtpVerified();

  @override
  List<Object?> get props => [];
}

class ResetPasswordSuccess extends AuthState {
  ResetPasswordSuccess();

  @override
  List<Object?> get props => [];
}

