import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/profile/model/user_update_dto.dart';

abstract class UserInforEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Load user information
class LoadUserInforEvent extends UserInforEvent {}

// Change profile information
class ChangeUserProfileEvent extends UserInforEvent {
  final UserUpdateDTO userUpdateDTO;

  ChangeUserProfileEvent({
    required this.userUpdateDTO,
  });

  @override
  List<Object?> get props => [];
}
