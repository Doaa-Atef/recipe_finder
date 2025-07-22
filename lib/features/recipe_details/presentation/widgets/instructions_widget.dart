import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructionsItem extends StatelessWidget {
  final List<String> instructions;

  const InstructionsItem({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: instructions
          .asMap()
          .entries
          .map(
            (entry) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                '${entry.key + 1}. ${entry.value}',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          )
          .toList(),
    );
  }
}
