import 'package:either_dart/either.dart';

import '../../../home/domain/entities/recipes_entity.dart';
import '../../../home/domain/repositories/recipe_repository.dart';


class GetRecipesByCategory {
  final RecipeRepository repository;

  GetRecipesByCategory(this.repository);
  Future<Either<String, List<Recipe>>> call({
    required String category,
    required bool isCuisine,
     int offset=0,

  }) {
    return repository.getRecipesByCategory(category: category, isCuisine: isCuisine,offset:offset);
  }
}