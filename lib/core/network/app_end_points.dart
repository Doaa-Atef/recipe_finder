import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEndPoints {
  static const String baseUrl = "https://api.spoonacular.com/recipes/";
  static const String randomRecipes = "random";
  static const String recipeDetails = "information/";
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
