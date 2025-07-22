import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/recipe_details_entity.dart';
import '../../domain/usecase/recipe_details_usecase.dart';

part 'recipe_details_state.dart';

class RecipeDetailsCubit extends Cubit<RecipeDetailsState> {
  final GetRecipeDetailsUseCase getRecipeDetailsUseCase;

  RecipeDetailsCubit(this.getRecipeDetailsUseCase)
    : super(RecipeDetailsInitial());

  Future<void> getRecipeDetails(int id) async {
    emit(RecipeDetailsLoading());
    final result = await getRecipeDetailsUseCase(id);
    result.fold(
      (failure) => emit(RecipeDetailsError("Failed to load recipe details")),
      (recipeDetails) => emit(RecipeDetailsLoaded(recipeDetails)),
    );
  }
}
