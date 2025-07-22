import 'package:either_dart/either.dart';

import '../entities/recipes_entity.dart';

abstract class RecipeRepository {
  Future<Either<String, List<Recipe>>> getRandomRecipes({required int offset});
  Future<Either<String, List<Recipe>>> getRecipesByCategory({
    required String category,
    required bool isCuisine,
    required int offset,
  });
  Future<Either<String, List<Recipe>>> searchRecipes({
    required String query,
    int offset,
  });
}
