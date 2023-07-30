import 'package:flutter/material.dart';
import 'package:food_orders_proj/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_orders_proj/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:food_orders_proj/ui/views/login_view/login_view.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_text.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: Column(
          children: [
            (size.width * 0.2).ph,
            CustomText(
              text: 'New Password',
              fontWeight: FontWeight.normal,
              textColor: AppColors.blackMainColor,
              textSize: size.width * 0.08,
            ),
            (size.width * 0.04).ph,
            CustomText(text: 'Please enter your email to receive a'),
            (size.width * 0.01).ph,
            CustomText(text: 'link to create a new password via email'),
            (size.width * 0.13).ph,
            CustomTextField(
                hintText: 'New Password', controller: emailController),
            (size.width * 0.08).ph,
            CustomTextField(
                hintText: 'Confirm Passord', controller: emailController),
            (size.width * 0.08).ph,
            CustomButton(text: 'Next', onPressed: () {})
          ],
        ),
      ),
    ));
  }
}
