import '../../../home/domain/entities/recipes_entity.dart';
import '../repositories/favourites_repository.dart';


class GetFavoritesUseCase {
  final FavoritesRepository repository;

  GetFavoritesUseCase(this.repository);

  Future<List<Recipe>> call(String userId) {
    return repository.getFavorites(userId);
  }
}
