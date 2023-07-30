import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:food_orders_proj/app/core/data/models/apies/category_model.dart';
import '../../enums/request_type.dart';
import '../../utiles/network_utile.dart';
import '../models/apies/common_response.dart';
import '../models/apies/token_info.dart';
import '../network/endpoints/category_endpoints.dart';
import '../network/endpoints/user_endpoints.dart';
import '../network/network_config.dart';

class CategoryRepository {
  Future<Either<String, List<CategoryModel>>> getall() async {
    // the left is always String (the error message) - the right will be changed from api repository to another
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: CategoryEndpoints.getall,
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<CategoryModel> result = [];
          commonResponse.data!.forEach((element) {
            result.add(CategoryModel.fromJson(element));
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

  Future<Either<String, TokenInfo>> register({
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: UserEndpoints.login,
        body: {
          'userName': email,
          'password': password,
        },
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(TokenInfo.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      BotToast.showText(text: e.toString());
      return Left(e.toString());
    }
  }
}
