

import '../repositories/favourites_repository.dart';

class RemoveFromFavoritesUseCase {
  final FavoritesRepository repository;

  RemoveFromFavoritesUseCase(this.repository);

  Future<void> call(String userId, int recipeId) {
    return repository.removeFromFavorites(userId, recipeId);
  }
}
