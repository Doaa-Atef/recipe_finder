import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class RecipeDetailsShimmer extends StatelessWidget {
  const RecipeDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: _circle(height: 200.r, width: 200.r),
          ),
          SizedBox(height: 16.h),
          _rect(height: 24.h, width: double.infinity),
          SizedBox(height: 20.h),
          _rowShimmer(),
          SizedBox(height: 10.h),
          _rowShimmer(),
          SizedBox(height: 10.h),
          _rowShimmer(),
          SizedBox(height: 20.h),
          _rect(height: 20.h, width: 120.w),
          ...List.generate(
            5,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: _rect(height: 16.h, width: double.infinity),
            ),
          ),
          SizedBox(height: 20.h),
          _rect(height: 20.h, width: 140.w),
          ...List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: _rect(height: 16.h, width: double.infinity),
            ),
          ),
          SizedBox(height: 20.h),
          _rect(height: 20.h, width: 160.w),
        ],
      ),
    );
  }

  Widget _rect({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  Widget _circle({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      ),
    );
  }

  Widget _rowShimmer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _rect(height: 16.h, width: 100.w),
        _rect(height: 16.h, width: 100.w),
      ],
    );
  }
}
