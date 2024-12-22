// recipe_state.dart
import 'package:tastemate_app/feature/dish/model/dish_dto.dart';

abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeLoaded extends RecipeState {
  final List<DishDTO> dishes;
  RecipeLoaded(this.dishes);
}

class RecipeError extends RecipeState {
  final String message;
  RecipeError(this.message);
}
