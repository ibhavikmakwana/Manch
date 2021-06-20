import 'package:flutter/material.dart';
import 'package:supabase_playground/values/app_colors.dart';

class IndicatorDot extends StatelessWidget {
  final bool? isSelected;

  const IndicatorDot({Key? key, this.isSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ?? false
            ? AppColors.primaryColor
            : AppColors.screenBackground,
      ),
      duration: Duration(milliseconds: 350),
    );
  }
}
