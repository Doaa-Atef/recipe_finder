import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder/features/recipe_details/presentation/widgets/recipe_info.dart';

class NutrientInfoSection extends StatelessWidget {
  final dynamic recipe;
  const NutrientInfoSection({required this.recipe, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InfoRow(
              icon: Icons.restaurant,
              text: '${recipe.servings} servings',
            ),
            InfoRow(icon: Icons.timer, text: '${recipe.readyInMinutes} mins'),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InfoRow(
              icon: Icons.local_fire_department,
              text: '${recipe.calories} cal',
            ),
            InfoRow(
              icon: Icons.fitness_center,
              text: '${recipe.protein} g protein',
            ),
          ],
        ),
        SizedBox(height: 8.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InfoRow(icon: Icons.eco, text: '${recipe.fiber} g fiber'),
            InfoRow(icon: Icons.grain, text: '${recipe.sugar} g sugar'),
          ],
        ),
      ],
    );
  }
}
