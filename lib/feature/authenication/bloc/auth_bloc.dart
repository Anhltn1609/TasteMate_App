import 'package:bloc/bloc.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/authenication/model/authentication_dto.dart';
import 'package:tastemate_app/feature/authenication/model/user_create_dto.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService _apiService;

  AuthBloc(this._apiService) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<SendOtpEvent>(_onSendOtpEvent);
    on<VerifyOtpEvent>(_onVerifyOtpEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<AuthLogout>(_onAuthLogout);
  }

  Future<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final dto = AuthenticationDTO(
        email: event.email,
        password: event.password,
      );
      final user = await _apiService.login(dto);
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("Login failed. Please try again."));
      }
    } catch (e) {
      emit(AuthFailure("Error: $e"));
    }
  }

  Future<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final dto = UserCreateDTO(
        email: event.email,
        fullname: event.fullname,
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      final rs = await _apiService.register(dto);
      if (rs) {
        emit(UserCreated());
      } else {
        emit(AuthFailure("Account creation failed."));
      }
    } catch (e) {
      emit(AuthFailure("Error: $e"));
    }
  }

  Future<void> _onSendOtpEvent(
    SendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _apiService.forgotPassword(event.email);
      if (result) {
        emit(AuthSuccessOtpSent());
      } else {
        emit(AuthFailure("Failed to send OTP. Please try again."));
      }
    } catch (e) {
      emit(AuthFailure("Error: $e"));
    }
  }

  Future<void> _onVerifyOtpEvent(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _apiService.verifyOtp(event.verifyOtpDTO);
      if (result) {
        emit(OtpVerified());
      } else {
        emit(AuthFailure(
            "OTP verification failed. Please check the OTP and try again."));
      }
    } catch (e) {
      emit(AuthFailure("Error: $e"));
    }
  }

  Future<void> _onResetPasswordEvent(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final result = await _apiService.resetPassword(event.authenticationDTO);
      if (result) {
        emit(ResetPasswordSuccess());
      } else {
        emit(AuthFailure("Password reset failed. Please try again."));
      }
    } catch (e) {
      emit(AuthFailure("Error: $e"));
    }
  }

  Future<void> _onAuthLogout(
    AuthLogout event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      ApiService.accessToken = '';
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure("Logout failed. Please try again."));
    }
  }
}
