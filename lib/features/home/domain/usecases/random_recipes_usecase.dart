import 'package:either_dart/either.dart';
import '../entities/recipes_entity.dart';
import '../repositories/recipe_repository.dart';

class GetRandomRecipes {
  final RecipeRepository repository;

  GetRandomRecipes(this.repository);

  Future<Either<String, List<Recipe>>> call({int offset = 0}) {
    return repository.getRandomRecipes(offset: offset);
  }
}
