// recipe_state.dart
import 'package:tastemate_app/feature/dish/model/dish_dto.dart';
import 'package:tastemate_app/feature/dish/dish_detail/model/dish_recipe_dto.dart';

abstract class RecipeDetailState {}

class RecipeDetailInitial extends RecipeDetailState {}

class RecipeDetailLoading extends RecipeDetailState {}

class RecipeDetailLoaded extends RecipeDetailState {
  final DishWithIngredientsDTO dishWithIngredientsDTO;
  RecipeDetailLoaded(this.dishWithIngredientsDTO);
}

class RecipeDetailError extends RecipeDetailState {
  final String message;
  RecipeDetailError(this.message);
}
