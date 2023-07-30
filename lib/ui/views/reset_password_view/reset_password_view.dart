import 'package:flutter/material.dart';
import 'package:food_orders_proj/ui/views/login_view/login_view.dart';
import 'package:food_orders_proj/ui/views/pin_code_view/pin_code_view.dart';
import 'package:get/get.dart';
import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_text.dart';
import '../../shared/custom_widgets/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: Column(
          children: [
            (size.width * 0.2).ph,
            CustomText(
                text: 'Reset Password',
                textColor: AppColors.blackMainColor,
                textSize: size.width * 0.1,
                fontWeight: FontWeight.normal),
            (size.width * 0.03).ph,
            CustomText(
              text: 'Please enter your email to receive a',
            ),
            (size.width * 0.01).ph,
            CustomText(text: 'link to create a new password via email'),
            (size.width * 0.2).ph,
            CustomTextField(hintText: 'Email', controller: emailController),
            (size.width * 0.06).ph,
            CustomButton(
                text: 'Send',
                onPressed: () {
                  Get.to(PinCodeView());
                }),
          ],
        ),
      ),
    ));
  }
}
