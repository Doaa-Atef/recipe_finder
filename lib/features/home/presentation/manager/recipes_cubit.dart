import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/recipes_entity.dart';
import '../../domain/usecases/random_recipes_usecase.dart';
part 'recipes_state.dart';

class RecipeCubit extends Cubit<RecipesState> {
  final GetRandomRecipes getRandomRecipesUseCase;

  List<Recipe> _allRecipes = [];
  int _offset = 0;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  RecipeCubit(this.getRandomRecipesUseCase) : super(RecipesInitial());

  Future<void> fetchRandomRecipes() async {
    emit(RecipeLoading());
    _offset = 0;
    _hasMore = true;
    _allRecipes.clear();
    final result = await getRandomRecipesUseCase(offset: _offset);

    result.fold((error) => emit(RecipeError(error)), (recipes) {
      _allRecipes.addAll(recipes);
      _hasMore = recipes.length >= 10;
      emit(RecipeLoaded(List.from(_allRecipes), hasMore: _hasMore));
    });
  }

  Future<void> loadMoreRecipes() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    _offset += 10;
    emit(RecipeLoadingMore(recipes: List.from(_allRecipes), hasMore: _hasMore));

    final result = await getRandomRecipesUseCase(offset: _offset);
    result.fold(
      (error) {
        _isLoadingMore = false;
        emit(RecipeError(error));
      },
      (recipes) {
        _allRecipes.addAll(recipes);
        _hasMore = recipes.length >= 10;
        _isLoadingMore = false;

        emit(RecipeLoaded(List.from(_allRecipes), hasMore: _hasMore));
      },
    );

    _isLoadingMore = false;
  }
}
