import 'package:flutter/material.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.validator});
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      style: TextStyle(
          fontSize: size.width * 0.035,
          fontWeight: FontWeight.normal,
          color: AppColors.blackMainColor),
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.normal,
              color: AppColors.hintTextGrey),
          filled: true,
          fillColor: AppColors.textFieldGrey,
          contentPadding: EdgeInsets.symmetric(
              horizontal: size.width * 0.07, vertical: size.width * 0.05),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(size.width * 0.1))),
    );
  }
}
