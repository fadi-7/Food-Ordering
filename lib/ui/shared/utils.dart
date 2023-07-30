import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_orders_proj/app/core/data/repositories/shared_preference_repository.dart';
import 'package:get/get.dart';

import '../../app/core/enums/connectivity_status.dart';
import '../../app/core/enums/message_type.dart';
import '../../app/core/services/cart_service.dart';
import '../../app/core/services/connectivity_service.dart';
import '../../app/core/services/location_service.dart';
import '../../app/my_app_controller.dart';
import 'colors.dart';
import 'custom_widgets/custom_toast.dart';

bool isEmail(String value) {
  RegExp regExp = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regExp.hasMatch(value);
}

bool isPassword(String value) {
  RegExp regExp = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  return regExp.hasMatch(value);
}

bool isPhoneNum(String value) {
  RegExp regExp = new RegExp(r'^(\\+9639|09)\\d{8}$');
  return regExp.hasMatch(value);
}

bool isName(String value) {
  RegExp regExp = new RegExp(r'/^[A-Za-z]+$/');
  return regExp.hasMatch(value);
}

bool isAddress(String value) {
  RegExp regExp = new RegExp(r'/^[A-Za-z]+$/');
  return regExp.hasMatch(value);
}

double screenWidth(double percent) {
  return Get.size.width / percent; // Get.size <=> Mediaquery.of(context).size
}

double screenHeight(double percent) {
  return Get.size.height / percent;
}

sharedPreferenceRepository get storage =>
    Get.find<sharedPreferenceRepository>();
CartService get cartService => Get.find<CartService>();

ConnectivityService get connectivityService => Get.find<ConnectivityService>();
LocationService get locationService => Get.find<LocationService>();

void fadeInTransition(Widget view) {
  Get.to(view, transition: Transition.fadeIn);
}

void customLoader() => BotToast.showCustomLoading(toastBuilder: (builder) {
      return Container(
        width: screenWidth(5),
        height: screenWidth(5),
        decoration: BoxDecoration(
            color: AppColors.blackMainColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(15)),
        child: SpinKitCircle(color: AppColors.orangeMainColor),
      );
    });

double get taxAmount => 0.18;
double get deliveryAmount => 0.1;

bool get isOnline =>
    Get.find<MyAppController>().connectionStatus == ConnectivityStatus.ONLINE;

void checkConnection(Function function) {
  if (isOnline)
    function();
  else
    CustomToast.showMessage(
        message: 'Please check internet connection',
        messageType: MessageType.WARNING);
}
