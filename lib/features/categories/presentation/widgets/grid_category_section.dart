import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder/core/styles/app_colors.dart';

import '../../data/model/category_model.dart';


class GridCategorySection extends StatelessWidget {
  final String title;
  final List<CategoryModel> items;
  final bool isCuisine;
  final void Function(String category, bool isCuisine) onTap;

  const GridCategorySection({
    super.key,
    required this.title,
    required this.items,
    required this.isCuisine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.h),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          shrinkWrap: true,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          children: items.map((item) {
            return GestureDetector(
              onTap: () => onTap(item.name, isCuisine),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.mintGreen,
                    radius: 40.r,
                    backgroundImage: NetworkImage(item.image),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.sp),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
