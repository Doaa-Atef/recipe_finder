import 'package:either_dart/either.dart';
import '../entities/recipe_details_entity.dart';

abstract class RecipeDetailsRepository {
  Future<Either<String, RecipeDetails>> getRecipeDetails(int id);
}
