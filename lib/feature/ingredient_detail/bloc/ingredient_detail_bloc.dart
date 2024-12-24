import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/ingredient/bloc/ingredient_event.dart';
import 'package:tastemate_app/feature/ingredient_detail/bloc/ingredient_detail_event.dart';
import 'package:tastemate_app/feature/ingredient_detail/bloc/ingredient_detail_state.dart';

class IngredientDetailBloc
    extends Bloc<IngredientDetailEvent, IngredientDetailState> {
  final ApiService _apiService;

  IngredientDetailBloc(this._apiService) : super(IngredientLoading()) {
    on<LoadIngredientDetailEvent>(_onLoadIngredientDetailEvent);
  }

  Future<void> _onLoadIngredientDetailEvent(
    LoadIngredientDetailEvent event,
    Emitter<IngredientDetailState> emit,
  ) async {
    emit(IngredientLoading());
    try {
      final ingredientDetail =
          await _apiService.getIngredientById(event.ingredientId);
      if (ingredientDetail != null) {
        emit(IngredientDetailLoaded(ingredientDetail));
      } else {
        emit(IngredientFailure(
            "No Ingredient found for category ID: ${event.ingredientId}."));
      }
    } catch (e) {
      emit(IngredientFailure("Lỗi hệ thống hãy thử lại sau"));
    }
  }
}
