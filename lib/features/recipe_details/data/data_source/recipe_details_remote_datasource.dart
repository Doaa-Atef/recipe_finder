import 'package:recipe_finder/core/network/app_end_points.dart';
import '../../../../core/network/network_services.dart';
import '../models/recipe_details_model.dart';

abstract class RecipeDetailsRemoteDataSource {
  Future<RecipeDetailsModel> getRecipeDetails(int id);
}

class RecipeDetailsRemoteDataSourceImpl
    implements RecipeDetailsRemoteDataSource {
  @override
  Future<RecipeDetailsModel> getRecipeDetails(int id) async {
    final response = await NetworkServices.getData(
      endPoint: "$id/information",
      queryParameters: {
        'includeNutrition': true,
        'apiKey': AppEndPoints.apiKey,
      },
    );

    return response.fold(
      (error) {
        throw Exception(error);
      },
      (data) {
        return RecipeDetailsModel.fromJson(data);
      },
    );
  }
}
