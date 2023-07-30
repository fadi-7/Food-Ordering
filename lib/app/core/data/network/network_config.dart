import 'package:food_orders_proj/app/core/data/repositories/shared_preference_repository.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import '../../enums/request_type.dart';

class NetworkConfig {
  static String BASE_API =
      'api/web/'; // api versioning : is when the backend adds some new features on the api in versions like /api/version_1/web
  static String getFullApiUrl(String api) {
    return BASE_API + api;
  }

  static Map<String, String> getHeaders(
      {bool? needAuth =
          true, // generaly most apies need authorization so that we gave it initial value true
      RequestType? type = RequestType.POST,
      Map<String, String>? extraHeaders = const {}}) {
    return {
      if (needAuth!)
        'Authorization':
            'Bearer ${storage.getTokenInfo()?.accessToken ?? ''}', // if tokenInfo = null => replace it with '' - if accessToken = null replace it with ''
      if (type == RequestType.POST) 'Content-Type': 'application/json',
      ...extraHeaders! // if extraHeaders is empty then the header has the same keys and values
      // else if there is any elements in extraHeaders then add them to the main header(...)
    };
  }
}
