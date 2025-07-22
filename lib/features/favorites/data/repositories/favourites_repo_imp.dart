
import '../../../home/domain/entities/recipes_entity.dart';
import '../../domain/repositories/favourites_repository.dart';
import '../data_source/favourites_local_datasource.dart';


class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;

  FavoritesRepositoryImpl(this.localDataSource);

  @override
  Future<void> addToFavorites(String userId, Recipe recipe) async {
    final current = await localDataSource.getFavorites(userId);
    final updated = [...current, recipe];
    await localDataSource.saveFavorites(userId, updated);
  }

  @override
  Future<void> removeFromFavorites(String userId, int recipeId) async {
    final current = await localDataSource.getFavorites(userId);
    final updated = current.where((r) => r.id != recipeId).toList();
    await localDataSource.saveFavorites(userId, updated);
  }

  @override
  Future<List<Recipe>> getFavorites(String userId) {
    return localDataSource.getFavorites(userId);
  }
}
