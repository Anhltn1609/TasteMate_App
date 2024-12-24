import 'package:bloc/bloc.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/nutrition_history/bloc/nutrition_event.dart';
import 'package:tastemate_app/feature/nutrition_history/bloc/nutrition_state.dart';

class NutritionHistoryBloc
    extends Bloc<NutritionHistoryEvent, NutritionHistoryState> {
  final ApiService _apiService;

  NutritionHistoryBloc(this._apiService) : super(NutritionHistoryInitial()) {
    on<LoadNutritionHistoryEvent>(_onLoadNutritionHistoryEvent);
  }

  Future<void> _onLoadNutritionHistoryEvent(
    LoadNutritionHistoryEvent event,
    Emitter<NutritionHistoryState> emit,
  ) async {
    emit(NutritionHistoryLoading());
    try {
      final response = await _apiService.getNutritionHistory();

      if (response != null && response.isNotEmpty) {
        emit(NutritionHistoryLoaded(response));
      } else {
        emit(NutritionHistoryEmpty());
      }
    } catch (e) {
      emit(NutritionHistoryError(
          "Failed to load nutrition history. Please try again later."));
    }
  }
}
