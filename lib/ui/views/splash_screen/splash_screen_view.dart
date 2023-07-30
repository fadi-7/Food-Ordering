import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:food_orders_proj/ui/views/splash_screen/splash_screen_controller.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  SplashScreenController controller = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: SvgPicture.asset('images/bg_background.svg'),
            ),
            Center(
              child: Container(
                child: SvgPicture.asset('images/ic_logo.svg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenWidth(1)),
              child: SpinKitThreeBounce(
                color: AppColors.orangeMainColor,
                size: screenWidth(15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
