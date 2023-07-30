import 'package:flutter/material.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.textSize,
    this.fontWeight,
  });
  final String text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(
      text,
      style: TextStyle(
          fontSize: textSize ?? size.width * 0.035,
          color: textColor ?? AppColors.greyMainColor,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}
