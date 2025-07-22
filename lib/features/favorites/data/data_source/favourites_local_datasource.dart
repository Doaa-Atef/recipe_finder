import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../home/domain/entities/recipes_entity.dart';

abstract class FavoritesLocalDataSource {
  Future<void> saveFavorites(String userId, List<Recipe> recipes);
  Future<List<Recipe>> getFavorites(String userId);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final SharedPreferences sharedPreferences;

  FavoritesLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveFavorites(String userId, List<Recipe> recipes) async {
    final listJson = recipes.map((e) => e.toJson()).toList();
    await sharedPreferences.setString(userId, jsonEncode(listJson));
  }

  @override
  Future<List<Recipe>> getFavorites(String userId) async {
    final jsonString = sharedPreferences.getString(userId);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => Recipe.fromJson(e)).toList();
    }
    return [];
  }
}
