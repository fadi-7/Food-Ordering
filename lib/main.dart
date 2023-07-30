import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:food_orders_proj/app/core/data/repositories/shared_preference_repository.dart';
import 'package:food_orders_proj/app/core/services/location_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/core/services/cart_service.dart';
import 'app/my_app.dart';
import 'firebase_options.dart';

SharedPreferences? globalSharedprefs;
//visible in all of the project

Future<void> main() async {
  // here we started to use get X , we replaced main with getMain
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() async {
    var globalSharedprefs = await SharedPreferences.getInstance();
    return globalSharedprefs;
  });
  Get.put(sharedPreferenceRepository());
  Get.put(CartService());
  Get.put(LocationService());

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token.
    });
    if (GetPlatform.isIOS) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  } catch (e) {}

  runApp(MyApp());
}
// sharedPereferance sp=get.find <=> get.find<sharedPereferance>