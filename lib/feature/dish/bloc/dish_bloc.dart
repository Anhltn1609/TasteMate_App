// recipe_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_event.dart';
import 'package:tastemate_app/feature/dish/bloc/dish_state.dart';
import 'package:tastemate_app/feature/dish/model/dish_dto.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final ApiService _apiService;

  RecipeBloc(this._apiService) : super(RecipeInitial()) {
    on<LoadRecipesEvent>(_onLoadRecipesEvent);
  }

  Future<void> _onLoadRecipesEvent(
    LoadRecipesEvent event,
    Emitter<RecipeState> emit,
  ) async {
    emit(RecipeLoading());
    try {
      final List<DishDTO>? dishes = await _apiService.getDishes(1);
      if (dishes != null) {
        emit(RecipeLoaded(dishes));
      } else {
        emit(RecipeError("No ingredients found."));
      }
    } catch (e) {
      emit(RecipeError("Failed to load recipes: $e"));
    }
  }
}
