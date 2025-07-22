import 'package:either_dart/either.dart';
import '../entities/recipe_details_entity.dart';
import '../repository/recipe_details_repo.dart';

class GetRecipeDetailsUseCase {
  final RecipeDetailsRepository repository;

  GetRecipeDetailsUseCase(this.repository);

  Future<Either<String, RecipeDetails>> call(int id) async {
    return await repository.getRecipeDetails(id);
  }
}
