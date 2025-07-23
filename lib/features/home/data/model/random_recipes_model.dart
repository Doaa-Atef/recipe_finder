import '../../domain/entities/recipes_entity.dart';

class RecipeModel {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final int servings;
  final String sourceUrl;
  final List<String> dishTypes;
  final List<String> diets;
  final List<String> cuisines;
  final String instructions;

  RecipeModel({
    required this.id,
    required this.title,
    required this.image,
    required this.readyInMinutes,
    required this.servings,
    required this.sourceUrl,
    required this.dishTypes,
    required this.diets,
    required this.cuisines,
    required this.instructions,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    print("Incoming JSON: $json");
    return RecipeModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No title',
      image: (json['image'] as String?)?.isNotEmpty == true
          ? json['image']
          :  'https://images.unsplash.com/photo-1639856571053-9d5b39b2362b?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',

      readyInMinutes: json['readyInMinutes'] ?? 0,
      servings: json['servings'] ?? 0,
      sourceUrl: json['sourceUrl'] ?? '',
      dishTypes: List<String>.from(json['dishTypes'] ?? []),
      diets: List<String>.from(json['diets'] ?? []),
      cuisines: List<String>.from(json['cuisines'] ?? []),
      instructions: json['instructions'] ?? '',
    );
  }

  Recipe toEntity() {
    return Recipe(
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
    );
  }
}
