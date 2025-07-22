part of 'category_recipe_cubit.dart';

@immutable
sealed class CategoryRecipeState {}

final class CategoryRecipeInitial extends CategoryRecipeState {}

class CategoryRecipesLoading extends CategoryRecipeState {}

class CategoryRecipesLoaded extends CategoryRecipeState {
  final List<Recipe> recipes;
  final bool hasMore;

  CategoryRecipesLoaded(this.recipes, {required this.hasMore});
}

class CategoryRecipesLoadingMore extends CategoryRecipeState {
  final List<Recipe> recipes;
  final bool hasMore;

  CategoryRecipesLoadingMore(this.recipes, {required this.hasMore});
}

class CategoryRecipesError extends CategoryRecipeState {
  final String message;

  CategoryRecipesError(this.message);
}
