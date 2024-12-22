import 'package:bloc/bloc.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/profile/bloc/profile_event.dart';
import 'package:tastemate_app/feature/profile/bloc/profile_state.dart';

class UserInforBloc extends Bloc<UserInforEvent, UserInforState> {
  final ApiService _apiService;

  UserInforBloc(this._apiService) : super(UserInforInitial()) {
    on<LoadUserInforEvent>(_onLoadUserInforEvent);
    on<ChangeUserProfileEvent>(_onChangeUserProfileEvent);
  }

  Future<void> _onLoadUserInforEvent(
    LoadUserInforEvent event,
    Emitter<UserInforState> emit,
  ) async {
    emit(UserInforLoading());
    try {
      final user = ApiService.user;
      if (user != null) {
        emit(UserInforLoaded(user));
      } else {
        emit(UserInforFailure("Failed to load user information."));
      }
    } catch (e) {
      emit(UserInforFailure("Error: $e"));
    }
  }

  Future<void> _onChangeUserProfileEvent(
    ChangeUserProfileEvent event,
    Emitter<UserInforState> emit,
  ) async {
    emit(UserInforUpdating());
    try {
      final updatedUser = await _apiService.changeProfile(event.userUpdateDTO);
      if (updatedUser != null) {
        emit(UserInforLoaded(updatedUser));
      } else {
        emit(UserInforFailure("Failed to load user information."));
      }
    } catch (e) {
      emit(UserInforFailure("Failed to update profile: $e"));
    }
  }
}
