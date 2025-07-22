import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/custom-appbar.dart';
import '../../data/const_categories_data.dart';
import '../widgets/grid_category_section.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  void navigateToCategory(
    BuildContext context,
    String category,
    bool isCuisine,
  ) {
    Navigator.pushNamed(
      context,
      Routes.categoryResults,
      arguments: {'category': category, 'isCuisine': isCuisine},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleKey: "Categories"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridCategorySection(
              title: 'Cuisines:',
              items: cuisines,
              isCuisine: true,
              onTap: (category, isCuisine) {
                navigateToCategory(context, category, isCuisine);
              },
            ),
            SizedBox(height: 20.h),
            GridCategorySection(
              title: 'Meal Types:',
              items: meals,
              isCuisine: false,
              onTap: (category, isCuisine) {
                navigateToCategory(context, category, isCuisine);
              },
            ),
          ],
        ),
      ),
    );
  }
}
