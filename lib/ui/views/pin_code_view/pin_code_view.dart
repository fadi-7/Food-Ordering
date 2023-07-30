import 'package:flutter/material.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';
import 'package:food_orders_proj/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_orders_proj/ui/shared/custom_widgets/custom_text.dart';
import 'package:food_orders_proj/ui/views/login_view/login_view.dart';
import 'package:food_orders_proj/ui/views/new_password/new_password.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeView extends StatefulWidget {
  const PinCodeView({super.key});

  @override
  State<PinCodeView> createState() => _PinCodeViewState();
}

class _PinCodeViewState extends State<PinCodeView> {
  TextEditingController pinController = TextEditingController();
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
              text: 'We have sent an OTP to',
              fontWeight: FontWeight.normal,
              textColor: AppColors.blackMainColor,
              textSize: size.width * 0.07,
            ),
            CustomText(
              text: 'your Mobile',
              fontWeight: FontWeight.normal,
              textColor: AppColors.blackMainColor,
              textSize: size.width * 0.07,
            ),
            (size.width * 0.02).ph,
            CustomText(text: 'Please check your mobile number 071*****12'),
            (size.width * 0.01).ph,
            CustomText(text: 'continue to reset your password'),
            (size.width * 0.15).ph,
            PinCodeTextField(
              controller: pinController,
              appContext: context,
              length: 4,
              onChanged: (value) {},
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(size.width * 0.03),
                fieldHeight: size.width * 0.13,
                fieldWidth: size.width * 0.13,
                activeFillColor: AppColors.whiteMainColor,
                selectedFillColor: AppColors.textFieldGrey,
                inactiveFillColor: AppColors.textFieldGrey,
              ),
              hintCharacter: '*',
            ),
            (size.width * 0.07).ph,
            CustomButton(
                text: 'Next',
                onPressed: () {
                  Get.to(NewPassword());
                }),
            (size.width * 0.08).ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: "Didn't Receive? "),
                CustomText(
                  text: 'Click Here',
                  textColor: AppColors.orangeMainColor,
                  fontWeight: FontWeight.bold,
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
