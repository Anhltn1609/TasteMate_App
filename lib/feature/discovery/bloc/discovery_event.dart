import 'package:equatable/equatable.dart';

abstract class DiscoveryEvent extends Equatable {
  const DiscoveryEvent();

  @override
  List<Object?> get props => [];
}

class LoadIngredientsEvent extends DiscoveryEvent {}

class LoadCategoryEvent extends DiscoveryEvent {}
