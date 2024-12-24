import 'package:equatable/equatable.dart';
import 'package:tastemate_app/feature/nutrition_history/model/nutrition_history_dto.dart';

abstract class NutritionHistoryState extends Equatable {
  const NutritionHistoryState();

  @override
  List<Object?> get props => [];
}

class NutritionHistoryInitial extends NutritionHistoryState {}

class NutritionHistoryLoading extends NutritionHistoryState {}

class NutritionHistoryLoaded extends NutritionHistoryState {
  final List<NutritionHistoryDTO> nutritionHistory;

  const NutritionHistoryLoaded(this.nutritionHistory);

  @override
  List<Object?> get props => [nutritionHistory];
}

class NutritionHistoryEmpty extends NutritionHistoryState {}

class NutritionHistoryError extends NutritionHistoryState {
  final String message;

  const NutritionHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
