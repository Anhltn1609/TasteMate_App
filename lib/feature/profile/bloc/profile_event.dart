import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/profile/model/address_dto.dart';
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
  final AddressDTO address;

  ChangeUserProfileEvent({
    required this.userUpdateDTO,
    required this.address,
  });

  @override
  List<Object?> get props => [];
}
