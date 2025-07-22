import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../home/domain/entities/recipes_entity.dart';
import '../../domain/usescases/search_recipe_usecase.dart';

part 'search_recipe_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRecipesUseCase searchRecipesUseCase;

  List<Recipe> _recipes = [];
  int _offset = 0;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  String _currentQuery = '';

  SearchCubit(this.searchRecipesUseCase) : super(SearchInitial());

  Future<void> search(String query) async {
    emit(SearchLoading());

    _currentQuery = query;
    _offset = 0;
    _hasMore = true;
    _recipes.clear();

    final result = await searchRecipesUseCase(query: query, offset: _offset);

    result.fold((error) => emit(SearchError(error)), (recipes) {
      _recipes = recipes;
      _hasMore = recipes.length >= 10;
      emit(
        SearchSuccess(
          recipes: List.from(_recipes),
          hasMore: _hasMore,
          query: _currentQuery,
          // totalResults: null,
        ),
      );
    });
  }

  Future<void> loadMoreResults() async {
    if (_isLoadingMore || !_hasMore || _currentQuery.isEmpty) return;

    _isLoadingMore = true;
    _offset += 10;

    emit(
      SearchLoadingMore(
        recipes: List.from(_recipes),
        hasMore: _hasMore,
        query: _currentQuery,
      ),
    );

    final result = await searchRecipesUseCase(
      query: _currentQuery,
      offset: _offset,
    );

    result.fold(
      (error) {
        _isLoadingMore = false;
        emit(SearchError(error));
      },
      (recipes) {
        _recipes.addAll(recipes);
        _hasMore = recipes.length >= 10;
        _isLoadingMore = false;

        emit(
          SearchSuccess(
            recipes: List.from(_recipes),
            hasMore: _hasMore,
            query: _currentQuery,
          ),
        );
      },
    );
  }
}
