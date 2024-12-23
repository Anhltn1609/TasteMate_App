import 'package:equatable/equatable.dart';

abstract class IngredientDetailEvent extends Equatable {
  const IngredientDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadIngredientDetailEvent extends IngredientDetailEvent {
  final String ingredientId;

  LoadIngredientDetailEvent(this.ingredientId);

  @override
  List<Object?> get props => [ingredientId];
}

class LoadAllIngredientEvent extends IngredientDetailEvent {
  @override
  List<Object?> get props => [];
}
