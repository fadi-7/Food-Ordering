import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:get/get.dart';
import '../intro_view/intro_view.dart';
import '../landing_view/landing_view.dart';

class SplashScreenController extends GetxController {
  void onInit() {
    Future.delayed(Duration(seconds: 5)).then((value) {
      if (storage.getFirstLunch()) {
        Get.off(IntroView()); //Get.off() <=> pushReplacement
      } else {
        return storage.getLoggedIn()
            ? Get.off(LandingView())
            : Get.off(LandingView());
      }
      storage.setFirstLunch(false);
    });
  }
}
