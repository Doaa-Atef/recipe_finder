import '../../../home/domain/entities/recipes_entity.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

class FavoritesLoading extends FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Recipe> favorites;

  FavoritesLoaded(this.favorites);
}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError(this.message);
}
