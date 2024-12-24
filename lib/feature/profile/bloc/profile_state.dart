import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/authenication/model/user_dto.dart';
import 'package:tastemate_app/feature/profile/model/address_dto.dart';

abstract class UserInforState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Initial state
class UserInforInitial extends UserInforState {}

// Loading state
class UserInforLoading extends UserInforState {}

// Loaded state
class UserInforLoaded extends UserInforState {
  final UserDTO user;
  final AddressDTO addressDTO;

  UserInforLoaded(this.user, this.addressDTO);

  @override
  List<Object?> get props => [user, addressDTO];
}

class UserInforUpdateSuccess extends UserInforState {
  final UserDTO user;
  final AddressDTO addressDTO;

  UserInforUpdateSuccess(this.user, this.addressDTO);

  @override
  List<Object?> get props => [user, addressDTO];
}

// Updating state
class UserInforUpdating extends UserInforState {}

// Failure state
class UserInforFailure extends UserInforState {
  final String error;

  UserInforFailure(this.error);

  @override
  List<Object?> get props => [error];
}
