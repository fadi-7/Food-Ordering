import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:food_orders_proj/app/core/data/models/apies/category_model.dart';
import '../../enums/request_type.dart';
import '../../utiles/network_utile.dart';
import '../models/apies/common_response.dart';
import '../models/apies/meal_model.dart';
import '../models/apies/token_info.dart';
import '../network/endpoints/category_endpoints.dart';
import '../network/endpoints/meal_endpoints.dart';
import '../network/endpoints/user_endpoints.dart';
import '../network/network_config.dart';

class MealRepository {
  Future<Either<String, List<MealModel>>> getall() async {
    // the left is always String (the error message) - the right will be changed from api repository to another
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: MealEndpoints.getall,
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<MealModel> result = [];
          commonResponse.data!.forEach((element) {
            result.add(MealModel.fromJson(element));
          });
          return right(result);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
