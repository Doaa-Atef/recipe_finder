import '../../../home/domain/entities/recipes_entity.dart';

abstract class FavoritesRepository {
  Future<void> addToFavorites(String userId, Recipe recipe);
  Future<void> removeFromFavorites(String userId, int recipeId);
  Future<List<Recipe>> getFavorites(String userId);
}
