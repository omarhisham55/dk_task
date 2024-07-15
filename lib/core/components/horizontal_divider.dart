import 'package:dakahlia_task/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalDivider extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets? margin;
  const HorizontalDivider({
    super.key,
    required this.width,
    required this.height,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.semiDarkGrey),
      ),
    );
  }
}
