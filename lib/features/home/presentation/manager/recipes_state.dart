part of 'recipes_cubit.dart';

@immutable
sealed class RecipesState {}

final class RecipesInitial extends RecipesState {}

class RecipeLoading extends RecipesState {}

class RecipeLoaded extends RecipesState {
  final List<Recipe> recipes;
  final bool hasMore;
  RecipeLoaded(this.recipes, {this.hasMore = true});

  List<Object?> get props => [recipes, hasMore];
}

class RecipeError extends RecipesState {
  final String message;

  RecipeError(this.message);

  List<Object?> get props => [message];
}

final class RecipeLoadingMore extends RecipesState {
  final List<Recipe> recipes;
  final bool hasMore;
  RecipeLoadingMore({required this.recipes, required this.hasMore});
}
