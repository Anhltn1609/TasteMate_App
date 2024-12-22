import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/discovery/model/ingredient_dto.dart';

// State Classes
abstract class IngredientState extends Equatable {
  const IngredientState();

  @override
  List<Object?> get props => [];
}

class IngredientLoading extends IngredientState {}

class IngredientFailure extends IngredientState {
  final String error;

  const IngredientFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class CategoryDetailLoaded extends IngredientState {
  final List<IngredientDTO> ingredients;

  const CategoryDetailLoaded(this.ingredients);

  @override
  List<Object?> get props => [ingredients];
}

// Event Classes

// Bloc Class
