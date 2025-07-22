import 'package:recipe_finder/core/network/app_end_points.dart';
import '../../../../core/network/network_services.dart';
import '../model/random_recipes_model.dart';

abstract class RecipeRemoteDataSource {
  Future<List<RecipeModel>> getRandomRecipes({required int offset});
  Future<List<RecipeModel>> getRecipesByCategory({
    required String category,
    required bool isCuisine,
    required int offset,
  });
  Future<List<RecipeModel>> searchRecipes(String query, {int offset = 0});
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  Future<List<RecipeModel>> _handleRecipeRequest({
    required String endPoint,
    required Map<String, dynamic> queryParameters,
    required String dataKey,
  }) async {
    final result = await NetworkServices.getData(
      endPoint: endPoint,
      queryParameters: queryParameters,
    );

    return result.fold((error) => throw Exception(error), (data) {
      final list = data[dataKey] as List;
      return list.map((e) => RecipeModel.fromJson(e)).toList();
    });
  }

  @override
  Future<List<RecipeModel>> getRandomRecipes({int offset = 0}) {
    return _handleRecipeRequest(
      endPoint: "random",
      queryParameters: {
        "number": 10,
        "offset": offset,
        "apiKey": AppEndPoints.apiKey,
      },
      dataKey: 'recipes',
    );
  }

  @override
  Future<List<RecipeModel>> getRecipesByCategory({
    required String category,
    required bool isCuisine,
    int offset = 0,
  }) {
    final queryKey = isCuisine ? "cuisine" : "type";

    return _handleRecipeRequest(
      endPoint: "complexSearch",
      queryParameters: {
        queryKey: category.toLowerCase(),
        "number": 10,
        "addRecipeInformation": true,
        "offset": offset,
        "apiKey": AppEndPoints.apiKey,
      },
      dataKey: 'results',
    );
  }

  @override
  Future<List<RecipeModel>> searchRecipes(String query, {int offset = 0}) {
    return _handleRecipeRequest(
      endPoint: "complexSearch",
      queryParameters: {
        "query": query,
        "offset": offset,
        "number": 10,

        "addRecipeInformation": true,
        "apiKey": AppEndPoints.apiKey,
      },
      dataKey: 'results',
    );
  }
}
