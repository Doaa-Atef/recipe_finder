import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder/core/dependency_injection/di.dart';
import 'package:recipe_finder/core/styles/app_colors.dart';
import 'package:recipe_finder/core/widgets/custom-appbar.dart';
import 'package:recipe_finder/features/recipe_details/presentation/screens/recipe_webview_screen.dart';
import 'package:recipe_finder/features/recipe_details/presentation/manager/recipe_details_cubit.dart';
import 'package:recipe_finder/features/recipe_details/presentation/widgets/instructions_widget.dart';
import 'package:recipe_finder/features/recipe_details/presentation/widgets/recipe_details_shimmer.dart';
import '../widgets/nutrient_info.dart';
import '../widgets/recipe_image.dart';
import '../widgets/recipe_title.dart';
import '../widgets/section_title.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final int recipeId;
  final String recipeTitle;
  const RecipeDetailsScreen({
    super.key,
    required this.recipeId,
    required this.recipeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RecipeDetailsCubit>()..getRecipeDetails(recipeId),
      child: BlocBuilder<RecipeDetailsCubit, RecipeDetailsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(titleKey: recipeTitle),
            body: Builder(
              builder: (_) {
                if (state is RecipeDetailsLoading) {
                  return RecipeDetailsShimmer();
                } else if (state is RecipeDetailsError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  );
                } else if (state is RecipeDetailsLoaded) {
                  final recipe = state.recipeDetails;

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RecipeImage(imageUrl: recipe.image),
                        RecipeTitle(title: recipe.title),
                        NutrientInfoSection(recipe: recipe),
                        SectionTitle("Ingredients"),
                        ...recipe.ingredients.map(
                          (item) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: Text(
                              "- $item",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        ),
                        SectionTitle("Instructions"),
                        recipe.instructions.isNotEmpty
                            ? InstructionsItem(
                                instructions: recipe.instructions,
                              )
                            : Text(
                                "No instructions available.",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                        SizedBox(height: 10.h),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    WebViewScreen(url: recipe.sourceUrl),
                              ),
                            );
                          },
                          child: Text(
                            'View Recipe Source',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColors.secondaryColor,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        SizedBox(height: 35.h),
                      ],
                    ),
                  );
                }
                return const SizedBox(); // initial
              },
            ),
          );
        },
      ),
    );
  }
}
