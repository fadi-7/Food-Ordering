import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import '../../enums/request_type.dart';
import '../../utiles/network_utile.dart';
import '../models/apies/common_response.dart';
import '../models/apies/token_info.dart';
import '../network/endpoints/user_endpoints.dart';
import '../network/network_config.dart';

class UserRepository {
  Future<Either<String, TokenInfo>> login({
    // Either is a variable  in Dart-z package that returns 2 values
    // the left one 'string' if the statusCode!=200
    // the right one 'model' if the statusCode=200
    required String email,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        // because the function is future ,the compiler expects a return or await but here we replaced await with .then because we are waiting the response from the api then we will do something
        type: RequestType.POST,
        url: UserEndpoints.login,
        body: {
          'userName': email,
          'password': password,
        },
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<
            Map<String,
                dynamic>> commonResponse = CommonResponse.fromJson(
            response); //the jsonResponse that is returned from the NetworkUtil - we built an object of CommonResponse

        if (commonResponse.getStatus) {
          return Right(TokenInfo.fromJson(commonResponse.data ??
              {})); //storing response of the api after parsing it into a model - we gave data a default value to avoid the application from stopping if data didn't has a value
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> register({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    required int age,
    required String photo,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        type: RequestType.POST,
        url: UserEndpoints.register,
        fields: {
          'Email': email,
          'FirstName': firstname,
          'LastName': lastname,
          'Password': password,
          'Age': age.toString(),
        },
        files: {"Photo": photo},
        headers: NetworkConfig.getHeaders(needAuth: false),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.getStatus);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
