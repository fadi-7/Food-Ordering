import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_orders_proj/ui/views/landing_view/landing_view.dart';
import 'package:food_orders_proj/ui/views/login_view/login_view.dart';
import 'package:get/get.dart';

import '../../shared/colors.dart';
import '../../shared/custom_widgets/custom_button.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  List<String> titleList = [
    'Find Food You Love',
    'Fast Delivery',
    'Live Tracking'
  ];
  List<String> descriptionList = [
    'Discover the best foods from over 1,000 \n restaurants and fast delivery to your doorstep',
    'Fast food delivery to your home, office \n wherever you are',
    'Real time tracking of your food on the app \n once you placed the order'
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.09, vertical: size.width * 0.07),
          child: Column(children: [
            (size.width * 0.05).ph,
            SvgPicture.asset("images/intro$currentIndex.svg"),
            (size.width * 0.05).ph,
            DotsIndicator(
              dotsCount: 3,
              position: currentIndex.toDouble(),
              decorator: DotsDecorator(
                size: const Size.square(13.0),
                activeSize: const Size(18.0, 13.0),
                color: AppColors.greyMainColor, // Inactive color
                activeColor: AppColors.orangeMainColor,
              ),
            ),
            (size.width * 0.1).ph,
            Text(titleList[currentIndex],
                style: TextStyle(fontSize: size.width * 0.07)),
            (size.width * 0.07).ph,
            Text(
              descriptionList[currentIndex],
              textAlign: TextAlign.center,
            ),
            Spacer(),
            CustomButton(
                text: currentIndex != 2 ? "Next" : "Finish",
                onPressed: () {
                  if (currentIndex != 2)
                    setState(() {
                      currentIndex = currentIndex + 1;
                    });
                  else {
                    Get.to(LandingView());
                  }
                })
          ]),
        ),
      ),
    );
  }
}
