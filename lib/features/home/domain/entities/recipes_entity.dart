class Recipe {
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

  const Recipe({
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'readyInMinutes': readyInMinutes,
      'servings': servings,
      'sourceUrl': sourceUrl,
      'dishTypes': dishTypes,
      'diets': diets,
      'cuisines': cuisines,
      'instructions': instructions,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      readyInMinutes: json['readyInMinutes'],
      servings: json['servings'],
      sourceUrl: json['sourceUrl'],
      dishTypes: List<String>.from(json['dishTypes'] ?? []),
      diets: List<String>.from(json['diets'] ?? []),
      cuisines: List<String>.from(json['cuisines'] ?? []),
      instructions: json['instructions'] ?? '',
    );
  }
}
