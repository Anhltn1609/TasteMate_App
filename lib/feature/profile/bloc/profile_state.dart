import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/authenication/model/user_dto.dart';

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

  UserInforLoaded(this.user);

  @override
  List<Object?> get props => [user];
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
