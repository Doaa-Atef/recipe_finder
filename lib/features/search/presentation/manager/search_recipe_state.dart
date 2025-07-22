part of 'search_recipe_cubit.dart';

@immutable
sealed class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Recipe> recipes;
  final bool hasMore;
  final String query;

  SearchSuccess({
    required this.recipes,
    required this.hasMore,
    required this.query,
  });
}

class SearchLoadingMore extends SearchState {
  final List<Recipe> recipes;
  final bool hasMore;
  final String query;

  SearchLoadingMore({
    required this.recipes,
    required this.hasMore,
    required this.query,
  });
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);
}
