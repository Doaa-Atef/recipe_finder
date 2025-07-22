import '../../domain/entities/recipe_details_entity.dart';

class RecipeDetailsModel extends RecipeDetails {
  RecipeDetailsModel({
    required super.id,
    required super.title,
    required super.image,
    required super.readyInMinutes,
    required super.servings,
    required super.sourceUrl,
    required super.dishTypes,
    required super.diets,
    required super.cuisines,
    required super.instructions,
    required super.calories,
    required super.protein,
    required super.fiber,
    required super.sugar,
    required super.ingredients,
  });

  factory RecipeDetailsModel.fromJson(Map<String, dynamic> json) {
    List<String> extractInstructions() {
      final analyzed = json['analyzedInstructions'];
      if (analyzed is List && analyzed.isNotEmpty) {
        final steps = (analyzed[0]['steps'] ?? []) as List;
        return steps
            .map((step) => step['step']?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList();
      }

      final raw = json['instructions'];
      if (raw is String && raw.isNotEmpty) {
        return raw
            .split(RegExp(r'[\n•\-]+'))
            .map((line) => line.trim())
            .where((line) => line.isNotEmpty)
            .toList();
      }

      return [];
    }

    return RecipeDetailsModel(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      sourceUrl: json['sourceUrl'],
      dishTypes: List<String>.from(json['dishTypes'] ?? []),
      diets: List<String>.from(json['diets'] ?? []),
      cuisines: List<String>.from(json['cuisines'] ?? []),
      instructions: extractInstructions(),
      calories: _extractNutrient(json['nutrition']?['nutrients'], 'Calories'),
      protein: _extractNutrient(json['nutrition']?['nutrients'], 'Protein'),
      fiber: _extractNutrient(json['nutrition']?['nutrients'], 'Fiber'),
      sugar: _extractNutrient(json['nutrition']?['nutrients'], 'Sugar'),
      ingredients: List<String>.from(
        (json['extendedIngredients'] ?? []).map((i) => i['original']),
      ),
    );
  }

  RecipeDetails toEntity() {
    return RecipeDetails(
      id: id,
      title: title,
      image: image,
      readyInMinutes: readyInMinutes,
      servings: servings,
      sourceUrl: sourceUrl,
      dishTypes: dishTypes,
      diets: diets,
      cuisines: cuisines,
      instructions: instructions,
      calories: calories,
      protein: protein,
      fiber: fiber,
      sugar: sugar,
      ingredients: ingredients,
    );
  }

  static double _extractNutrient(List? nutrients, String name) {
    if (nutrients == null) return 0.0;
    try {
      final nutrient = nutrients.firstWhere(
        (n) => n['name'] == name,
        orElse: () => {'amount': 0.0},
      );
      return (nutrient['amount'] as num).toDouble();
    } catch (e) {
      return 0.0;
    }
  }
}
