part of 'recipe_details_cubit.dart';

@immutable
sealed class RecipeDetailsState {}

 class RecipeDetailsInitial extends RecipeDetailsState {}

class RecipeDetailsLoading extends RecipeDetailsState {}

class RecipeDetailsLoaded extends RecipeDetailsState {
  final RecipeDetails recipeDetails;

   RecipeDetailsLoaded(this.recipeDetails);

  List<Object> get props => [recipeDetails];
}

class RecipeDetailsError extends RecipeDetailsState {
  final String message;

   RecipeDetailsError(this.message);

  List<Object> get props => [message];
}

