import 'package:flutter/material.dart';
import 'package:food_orders_proj/app/core/services/base_controller.dart';
import 'package:food_orders_proj/ui/shared/custom_widgets/custom_toast.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:food_orders_proj/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';
import '../../../app/core/data/repositories/user_repository.dart';
import '../../../app/core/enums/message_type.dart';

class LoginController extends BaseController {
  // now there is no need for setState() and Future Builder with State Management
  TextEditingController emailController =
      TextEditingController(text: 'Test@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'Test@1234');

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs; //RxBool <=> bool

  void login() {
    if (formKey.currentState!.validate()) {
      runFullLoadingFutureFunction(
          function: UserRepository()
              .login(
                  email: emailController.text,
                  password: passwordController.text)
              .then((value) {
        value.fold((l) {
          CustomToast.showMessage(
              message: l, messageType: MessageType.REJECTED);
        }, (r) {
          storage.setLoggedIn(true);
          storage.setTokenInfo(r);
          Get.off(MainView(), transition: Transition.cupertino);
        });
      }));
    }
  }
}

void cupertinoTransition(Widget view) {
  Get.off(view, transition: Transition.cupertino);
}
