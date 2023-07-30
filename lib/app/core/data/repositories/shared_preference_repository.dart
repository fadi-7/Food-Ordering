import 'dart:convert';
import 'package:food_orders_proj/app/core/enums/data_type.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/apies/token_info.dart';
import '../models/cart_model.dart';

class sharedPreferenceRepository {
  SharedPreferences globalSharedprefs = Get.find();
  String PREF_FIRST_LUNCH = 'first_lunch';
  String PREF_IS_LOGGEDIN = 'logged in';
  String PREF_TOKEN_INFO =
      'token_info'; // now after we created our tokenInfo variable in the sharedPreferenceRepository there is no need for set/get loggedIn
  String PREF_APP_LANG = 'app language';
  String PREF_CART_LIST = 'cart_list';
  setTokenInfo(TokenInfo value) {
    setPreference(
      dataType: DataType.STRING,
      key: PREF_TOKEN_INFO,
      value: jsonEncode(value),
    );
  }

  TokenInfo? getTokenInfo() {
    if (globalSharedprefs.containsKey(PREF_TOKEN_INFO)) {
      return TokenInfo.fromJson(jsonDecode(getPreference(
          key: PREF_TOKEN_INFO))); //if there is a value then we are loggedIn
    } else {
      return null; // if not then its the first time and we should logIn
    }
  }

  setFirstLunch(bool value) {
    setPreference(dataType: DataType.BOOL, key: PREF_FIRST_LUNCH, value: value);
  }

  bool getFirstLunch() {
    if (globalSharedprefs.containsKey(PREF_FIRST_LUNCH))
      return getPreference(key: PREF_FIRST_LUNCH);
    else
      return true;
  }

  setLoggedIn(bool value) {
    setPreference(dataType: DataType.BOOL, key: PREF_IS_LOGGEDIN, value: value);
  }

  bool getLoggedIn() {
    if (globalSharedprefs.containsKey(PREF_IS_LOGGEDIN))
      return getPreference(key: PREF_IS_LOGGEDIN);
    else
      return false;
  }

  setAppLanguage(String value) {
    setPreference(dataType: DataType.STRING, key: PREF_APP_LANG, value: value);
  }

  String getAppLanguage() {
    if (globalSharedprefs.containsKey(PREF_APP_LANG))
      return getPreference(key: PREF_APP_LANG);
    else
      return 'ar';
  }

  void setCartList(List<CartModel> list) {
    setPreference(
        dataType: DataType.STRING,
        key: PREF_CART_LIST,
        value: CartModel.encode(list));
  }

  List<CartModel> getCartList() {
    if (globalSharedprefs.containsKey(PREF_CART_LIST)) {
      return CartModel.decode(getPreference(key: PREF_CART_LIST));
    } else {
      return [];
    }
  }

  setPreference(
      {required DataType dataType,
      required String key,
      required dynamic value}) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedprefs.setInt(key, value);
        break;
      case DataType.BOOL:
        await globalSharedprefs.setBool(key, value);
        break;
      case DataType.STRING:
        await globalSharedprefs.setString(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedprefs.setDouble(key, value);
        break;
      case DataType.LISTSTRING:
        await globalSharedprefs.setStringList('items', <String>[key, value]);
        break;
    }
  }

  dynamic getPreference({required String key}) {
    return globalSharedprefs.get(key);
  }
}
