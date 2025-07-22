import 'package:either_dart/either.dart';
import '../../domain/entities/recipes_entity.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../data_source/recipe_remote_datasource.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;

  RecipeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<Recipe>>> getRandomRecipes({
    int offset = 0,
  }) async {
    try {
      final models = await remoteDataSource.getRandomRecipes(offset: offset);
      final recipes = models.map((e) => e.toEntity()).toList();
      return Right(recipes);
    } catch (e) {
      print("ERROR: $e");
      return Left("Failed to fetch random recipes");
    }
  }

  @override
  Future<Either<String, List<Recipe>>> getRecipesByCategory({
    required String category,
    required bool isCuisine,
    required int offset,
  }) async {
    try {
      final models = await remoteDataSource.getRecipesByCategory(
        category: category,
        isCuisine: isCuisine,
        offset: offset,
      );
      final recipes = models.map((e) => e.toEntity()).toList();
      return Right(recipes);
    } catch (e) {
      print("ERROR: $e");
      return Left("Failed to fetch recipes for $category");
    }
  }

  @override
  Future<Either<String, List<Recipe>>> searchRecipes({
    required String query,
    int offset = 0,
  }) async {
    try {
      final models = await remoteDataSource.searchRecipes(
        query,
        offset: offset,
      );
      final recipes = models.map((e) => e.toEntity()).toList();
      return Right(recipes);
    } catch (e) {
      print("ERROR in search: $e");
      return Left("Failed to search recipes");
    }
  }
}
