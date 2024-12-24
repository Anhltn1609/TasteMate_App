import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tastemate_app/core/services/api/api_services.dart';
import 'package:tastemate_app/feature/ingredient/bloc/ingredient_event.dart';
import 'package:tastemate_app/feature/ingredient/bloc/ingredient_state.dart';

class IngredientBloc extends Bloc<IngredientEvent, IngredientState> {
  final ApiService _apiService;

  IngredientBloc(this._apiService) : super(IngredientLoading()) {
    on<LoadCategoryDetailEvent>(_onLoadCategoryDetailEvent);
    on<LoadSupplierIngredientEvent>(_onLoadSupplierIngredientEvent);
  }

  Future<void> _onLoadCategoryDetailEvent(
    LoadCategoryDetailEvent event,
    Emitter<IngredientState> emit,
  ) async {
    emit(IngredientLoading());
    try {
      final categoryDetail =
          await _apiService.getIngredientByCategoryId(event.categoryId);
      if (categoryDetail != null && categoryDetail.isNotEmpty) {
        emit(CategoryDetailLoaded(categoryDetail));
      } else {
        emit(IngredientFailure(
            "No Ingredient found for category ID: ${event.categoryId}."));
      }
    } catch (e) {
      emit(IngredientFailure("Lỗi hệ thống hãy thử lại sau"));
    }
  }

  Future<void> _onLoadSupplierIngredientEvent(
    LoadSupplierIngredientEvent event,
    Emitter<IngredientState> emit,
  ) async {
    emit(IngredientLoading());
    try {
      final supplierDetail =
          await _apiService.getIngredientBySupplierId(event.supplierId);
      if (supplierDetail != null && supplierDetail.isNotEmpty) {
        emit(CategoryDetailLoaded(supplierDetail));
      } else {
        emit(IngredientFailure(
            "No Ingredient found for category ID: ${event.supplierId}."));
      }
    } catch (e) {
      emit(IngredientFailure("Lỗi hệ thống hãy thử lại sau"));
    }
  }
}
