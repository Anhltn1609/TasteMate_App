// recipe_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:tastemate_app/feature/dish/dish_detail/bloc/dish_detail_event.dart';
import 'package:tastemate_app/feature/dish/dish_detail/bloc/dish_detail_state.dart';
import 'package:tastemate_app/feature/dish/model/dish_dto.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/dish/dish_detail/model/dish_recipe_dto.dart';

class DishDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final ApiService _apiService;

  DishDetailBloc(this._apiService) : super(RecipeDetailInitial()) {
    on<LoadRecipesDetailEvent>(_onLoadRecipeDetailEvent);
  }

  Future<void> _onLoadRecipeDetailEvent(
    LoadRecipesDetailEvent event,
    Emitter<RecipeDetailState> emit,
  ) async {
    emit(RecipeDetailLoading());
    try {
      final DishWithIngredientsDTO? dishes =
          await _apiService.getDishesWithIngredients(event.dishId);
      if (dishes != null) {
        emit(RecipeDetailLoaded(dishes));
      } else {
        emit(RecipeDetailError("No ingredients found."));
      }
    } catch (e) {
      emit(RecipeDetailError("Failed to load recipes: $e"));
    }
  }
}
