import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/domain/entities/recipes_entity.dart';
import '../../domain/usecases/category_usecase.dart';
part 'category_recipe_state.dart';

class CategoryRecipesCubit extends Cubit<CategoryRecipeState> {
  final GetRecipesByCategory getRecipesByCategory;
  List<Recipe> _recipes = [];
  int _offset = 0;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  CategoryRecipesCubit(this.getRecipesByCategory)
    : super(CategoryRecipeInitial());

  Future<void> fetchRecipes(String category, bool isCuisine) async {
    emit(CategoryRecipesLoading());
    _offset = 0;
    _hasMore = true;
    _recipes.clear();

    final result = await getRecipesByCategory(
      category: category,
      isCuisine: isCuisine,
      offset: _offset,
    );

    result.fold((error) => emit(CategoryRecipesError(error)), (recipes) {
      _recipes.addAll(recipes);
      _hasMore = recipes.length >= 10;
      emit(CategoryRecipesLoaded(_recipes, hasMore: _hasMore));
    });
  }

  Future<void> loadMoreRecipes(String category, bool isCuisine) async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;
    _offset += 10;

    emit(CategoryRecipesLoadingMore(_recipes, hasMore: _hasMore));

    final result = await getRecipesByCategory(
      category: category,
      isCuisine: isCuisine,
      offset: _offset,
    );

    result.fold(
      (error) {
        _isLoadingMore = false;
        emit(CategoryRecipesError(error));
      },
      (recipes) {
        _recipes.addAll(recipes);
        _hasMore = recipes.length >= 10;
        _isLoadingMore = false;
        emit(CategoryRecipesLoaded(_recipes, hasMore: _hasMore));
      },
    );
  }
}
