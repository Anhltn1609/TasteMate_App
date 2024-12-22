import 'package:equatable/equatable.dart';

abstract class IngredientEvent extends Equatable {
  const IngredientEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategoryDetailEvent extends IngredientEvent {
  final String categoryId;

  const LoadCategoryDetailEvent(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class LoadAllIngredientEvent extends IngredientEvent {
  @override
  List<Object?> get props => [];
}
