import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_finder/core/styles/app_colors.dart';
import 'package:recipe_finder/features/recipe_details/presentation/widgets/recipe_info.dart';
import '../../../core/routes/routes.dart';

class RecipeItem extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;
  final int readyInMinutes;
  final bool isFavorite;
  final VoidCallback onPressed;

  const RecipeItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.readyInMinutes,
    required this.isFavorite,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.recipeDetails,
          arguments: {'id': id, 'title': title},
        );
      },
      child: Card(
        color: AppColors.mintGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      imageUrl,
                      height: 150.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://images.unsplash.com/photo-1639856571053-9d5b39b2362b?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                          height: 150.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    )

                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, right: 4.w),
                    child: CircleAvatar(
                      backgroundColor: AppColors.offWhite,
                      radius: 20.r,
                      child: IconButton(
                        onPressed: onPressed,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16.sp),
              ),
              SizedBox(height: 4.h),
              InfoRow(icon: Icons.timer, text: '$readyInMinutes mins'),
            ],
          ),
        ),
      ),
    );
  }
}
