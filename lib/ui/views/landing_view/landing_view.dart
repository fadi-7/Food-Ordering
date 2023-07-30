import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:food_orders_proj/ui/views/login_view/login_view.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/custom_widgets/custom_text.dart';
import '../map_view/map_view.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    LocationData currentLocation;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            width: screenWidth(1),
            height: screenHeight(1.66),
            child: Stack(
              children: [
                ClipPath(
                  clipper: MyArch(),
                  child: Container(
                    width: screenWidth(1),
                    height: screenWidth(1),
                    color: AppColors.orangeMainColor,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SvgPicture.asset('images/ic_logo.svg'),
                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Transform.scale(
                        scale: screenWidth(350),
                        child:
                            SvgPicture.asset('images/bg_landing_screen.svg'))),
              ],
            ),
          ),
          (screenWidth(11)).ph,
          CustomText(text: 'Discover the best foods from over 1,000'),
          (screenWidth(200)).ph,
          CustomText(text: 'restaurants and fast delivery to your doorstep'),
          (screenWidth(6)).ph,
          CustomButton(
              text: 'Login',
              onPressed: () async {
                Get.to(LoginView());
                LocationData? currentLocation =
                    await locationService.getCurrentLocation();
                print(locationService.getLocationInfo(currentLocation!));

                if (currentLocation != null)
                  Get.to(MapView(currentLocation: currentLocation));
              }),
          (size.width * 0.04).ph,
          CustomButton(
            text: 'Create an Account',
            onPressed: () {},
            borderColor: AppColors.orangeMainColor,
            backgroundColor: AppColors.whiteMainColor,
            textColor: AppColors.orangeMainColor,
          )
        ],
      ),
    ));
  }
}

class MyArch extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(size.width, size.height * 0.7008750, size.width,
        size.height * 0.9345000);
    path0.quadraticBezierTo(size.width * 0.9999250, size.height * 1.0083750,
        size.width * 0.9347500, size.height);
    path0.quadraticBezierTo(size.width * 0.7968000, size.height * 1.0025000,
        size.width * 0.7412500, size.height);
    path0.quadraticBezierTo(size.width * 0.6964500, size.height * 0.9979000,
        size.width * 0.6862500, size.height * 0.9387500);
    path0.quadraticBezierTo(size.width * 0.6523250, size.height * 0.7828000,
        size.width * 0.4997000, size.height * 0.7724500);
    path0.quadraticBezierTo(size.width * 0.3488750, size.height * 0.7852750,
        size.width * 0.3137500, size.height * 0.9375000);
    path0.quadraticBezierTo(size.width * 0.3103000, size.height * 0.9971750,
        size.width * 0.2662500, size.height);
    path0.quadraticBezierTo(size.width * 0.2081250, size.height * 1.0025000,
        size.width * 0.0587500, size.height);
    path0.quadraticBezierTo(size.width * -0.0053000, size.height * 0.9990500, 0,
        size.height * 0.9337500);
    path0.quadraticBezierTo(0, size.height * 0.7003125, 0, 0);
    path0.lineTo(size.width * 0.6800000, size.height * 0.7350000);

    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
