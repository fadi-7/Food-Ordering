import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:food_orders_proj/app/core/translations/app_translation.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:food_orders_proj/ui/views/splash_screen/splash_screen_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'core/enums/connectivity_status.dart';

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         builder: BotToastInit(), //1. call BotToastInit
//         navigatorObservers: [
//           BotToastNavigatorObserver()
//           //? from flutter website
//         ], //2. registered route observer
//         home: SplashScreenView());
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
        create: (context) =>
            connectivityService.connectivityStatusController.stream,
        initialData: ConnectivityStatus.ONLINE,
        child: GetMaterialApp(
          title: 'Flutter Demo',
          translations: AppTranslation(),
          locale: getLocale(),
          fallbackLocale: getLocale(),
          builder: BotToastInit(), //1. call BotToastInit
          navigatorObservers: [
            BotToastNavigatorObserver()
//           //? from flutter website
          ],
// //2. registered route observer

          home: SplashScreenView(),
        ));
  }
}

Locale getLocale() {
  if (storage.getAppLanguage() == 'ar') {
    return Locale('ar', 'SA');
  } else {
    return Locale('en', 'US');
  }
}
