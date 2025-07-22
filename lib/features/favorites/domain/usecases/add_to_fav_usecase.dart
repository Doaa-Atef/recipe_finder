
import '../../../home/domain/entities/recipes_entity.dart';
import '../repositories/favourites_repository.dart';

class AddToFavoritesUseCase {
  final FavoritesRepository repository;

  AddToFavoritesUseCase(this.repository);

  Future<void> call(String userId, Recipe recipe) {
    return repository.addToFavorites(userId, recipe);
  }
}
