import 'package:either_dart/either.dart';
import '../../domain/entities/recipe_details_entity.dart';
import '../../domain/repository/recipe_details_repo.dart';
import '../data_source/recipe_details_remote_datasource.dart';
import '../models/recipe_details_model.dart';

class RecipeDetailsRepositoryImpl implements RecipeDetailsRepository {
  final RecipeDetailsRemoteDataSource remoteDataSource;

  RecipeDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, RecipeDetails>> getRecipeDetails(int id) async {
    try {
      final RecipeDetailsModel model = await remoteDataSource.getRecipeDetails(
        id,
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left("Failed to fetch recipe details");
    }
  }
}
