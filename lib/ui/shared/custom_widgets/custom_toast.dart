import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_orders_proj/app/core/enums/message_type.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:food_orders_proj/ui/views/landing_view/landing_view.dart';
import 'package:food_orders_proj/ui/views/login_view/login_view.dart';

class CustomToast {
  static showMessage({
    //{null or not required} we put 'requiered' in the requiered params
    //? because we need the context here but we dont have statful or stat less widgets
    required String message,
    MessageType messageType = MessageType.INFO, //we gave a default value
  }) {
    String imageName = 'info';
    Color shadowColor =
        AppColors.blueFacebookButton; //variables to use them in the switch case

    switch (messageType) {
      case MessageType.INFO:
        imageName;
        shadowColor;
        break;

      case MessageType.WARNING:
        imageName = 'warning';
        shadowColor = AppColors.orangeMainColor;
        break;

      case MessageType.REJECTED:
        imageName = 'rejected';
        shadowColor = AppColors.redGoogleButton;

        break;

      case MessageType.SUCCSESS:
        imageName = 'approved';
        shadowColor = Colors.green;

        break;
    }
    BotToast.showCustomText(
        //from Bot Toast Library
        duration: Duration(
            seconds:
                5), //property that controls the amount of time it will appear
        toastBuilder: (value) {
          // we are building it from here

          return Container(
              width: screenWidth(2),
              height: screenWidth(4),
              decoration: BoxDecoration(
                  color: AppColors.whiteMainColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Column(
                children: [
                  SvgPicture.asset(
                    "images/$imageName.svg",
                    width: screenWidth(4),
                  ),
                  (screenWidth(6)).ph,
                  Text(message),
                ],
              ));
        });
  }
}
