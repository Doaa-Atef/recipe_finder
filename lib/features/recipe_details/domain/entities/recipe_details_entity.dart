class RecipeDetails {
  final int id;
  final String title;
  final String image;
  final int readyInMinutes;
  final int servings;
  final String sourceUrl;
  final List<String> dishTypes;
  final List<String> diets;
  final List<String> cuisines;
  final List<String> instructions;
  final double calories;
  final double protein;
  final double fiber;
  final double sugar;
  final List<String> ingredients;

  RecipeDetails({
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
    required this.calories,
    required this.protein,
    required this.fiber,
    required this.sugar,
    required this.ingredients,
  });
}
