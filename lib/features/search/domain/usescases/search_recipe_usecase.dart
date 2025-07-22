import 'package:either_dart/either.dart';
import '../../../home/domain/entities/recipes_entity.dart';
import '../../../home/domain/repositories/recipe_repository.dart';

class SearchRecipesUseCase {
  final RecipeRepository repository;

  SearchRecipesUseCase(this.repository);

  Future<Either<String, List<Recipe>>> call({
    required String query,
    int offset = 0,
  }) {
    return repository.searchRecipes(query: query, offset: offset);
  }
}
