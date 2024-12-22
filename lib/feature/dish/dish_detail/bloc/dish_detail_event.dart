// recipe_event.dart
abstract class RecipeDetailEvent {
  const RecipeDetailEvent();

  @override
  List<Object?> get props => [];
}

class LoadRecipesDetailEvent extends RecipeDetailEvent {
  final String dishId;

  const LoadRecipesDetailEvent(this.dishId);

  @override
  List<Object?> get props => [dishId];
}
