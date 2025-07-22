import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipeImage extends StatelessWidget {
  final String imageUrl;
  const RecipeImage({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 100.r,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}
