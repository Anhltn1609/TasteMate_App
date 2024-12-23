import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/discovery/model/ingredient_dto.dart';

// State Classes
abstract class IngredientDetailState extends Equatable {
  const IngredientDetailState();

  @override
  List<Object?> get props => [];
}

class IngredientLoading extends IngredientDetailState {}

class IngredientFailure extends IngredientDetailState {
  final String error;

  const IngredientFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class IngredientDetailLoaded extends IngredientDetailState {
  final IngredientDTO ingredient;

  const IngredientDetailLoaded(this.ingredient);

  @override
  List<Object?> get props => [ingredient];
}

// Event Classes

// Bloc Class
