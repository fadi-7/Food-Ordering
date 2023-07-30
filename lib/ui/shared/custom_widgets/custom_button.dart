import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      this.borderColor,
      this.textColor,
      this.backgroundColor,
      this.textFontWeight,
      this.textSize,
      this.svgName,
      required this.onPressed});
  final String text;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final FontWeight? textFontWeight;
  final double? textSize;
  final String? svgName;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Container(
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (svgName != null) ...[
              SvgPicture.asset('images/$svgName.svg'),
              SizedBox(
                width: screenWidth(50),
              )
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor ?? AppColors.whiteMainColor,
                fontSize: textSize ?? screenWidth(28.5),
                fontWeight: textFontWeight ?? FontWeight.normal,
              ),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
            side: borderColor != null
                ? BorderSide(
                    width: 1, color: borderColor ?? AppColors.orangeMainColor)
                : null,
            backgroundColor: backgroundColor ?? AppColors.orangeMainColor,
            shape: StadiumBorder(),
            fixedSize: Size(screenWidth(1), screenHeight(16))),
      ),
    );
  }
}
