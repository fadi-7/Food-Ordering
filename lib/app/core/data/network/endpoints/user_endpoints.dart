import 'package:food_orders_proj/app/core/data/network/network_config.dart';

class UserEndpoints {
  static String login = NetworkConfig.getFullApiUrl('user/login');
  static String register = NetworkConfig.getFullApiUrl('user/register');
}
