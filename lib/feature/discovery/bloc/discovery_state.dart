import 'package:tastemate_app/feature/discovery/model/category_dto.dart';
import 'package:tastemate_app/feature/discovery/model/ingredient_dto.dart';
import 'package:tastemate_app/feature/discovery/model/supplier_dto.dart';

abstract class DiscoveryState {}

class DiscoveryInitial extends DiscoveryState {}

class DiscoveryLoading extends DiscoveryState {}

class IngredientsLoaded extends DiscoveryState {
  final List<IngredientDTO> ingredients;
  IngredientsLoaded(this.ingredients);
}

class CategoriesLoaded extends DiscoveryState {
  final List<CategoryDTO> categories;
  final List<SupplierDTO> suppliers;
  CategoriesLoaded(this.categories, this.suppliers);
}

class DiscoveryFailure extends DiscoveryState {
  final String message;
  DiscoveryFailure(this.message);
}
