import 'package:bloc/bloc.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/discovery/bloc/discovery_event.dart';
import 'package:tastemate_app/feature/discovery/bloc/discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  final ApiService _apiService;

  DiscoveryBloc(this._apiService) : super(DiscoveryInitial()) {
    on<LoadIngredientsEvent>(_onLoadIngredientsEvent);
    on<LoadCategoryEvent>(_onLoadCategoryEvent);
  }

  Future<void> _onLoadIngredientsEvent(
    LoadIngredientsEvent event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    try {
      final ingredients = await _apiService.getIngredients(1);
      if (ingredients != null) {
        emit(IngredientsLoaded(ingredients));
      } else {
        emit(DiscoveryFailure("No ingredients found."));
      }
    } catch (e) {
      emit(DiscoveryFailure("Lỗi hệ thống hãy thử lại sau"));
    }
  }

  Future<void> _onLoadCategoryEvent(
    LoadCategoryEvent event,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    try {
      final categories = await _apiService.getCategories(1);
      final suppliers = await _apiService.getSuppliers(1);
      if (categories != null && suppliers != null) {
        emit(CategoriesLoaded(categories, suppliers));
        print(categories);
        print(suppliers);
      } else {
        emit(DiscoveryFailure("No Category found."));
      }
    } catch (e) {
      emit(DiscoveryFailure("Lỗi hệ thống hãy thử lại sau"));
    }
  }
}
