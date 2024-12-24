import 'package:equatable/equatable.dart';

abstract class NutritionHistoryEvent extends Equatable {
  const NutritionHistoryEvent();

  @override
  List<Object?> get props => [];
}

class LoadNutritionHistoryEvent extends NutritionHistoryEvent {
  final String userId;

  const LoadNutritionHistoryEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
