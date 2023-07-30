import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';

import '../../../ui/shared/utils.dart';
import '../enums/operation_type.dart';
import '../enums/request_status.dart';

class BaseController extends GetxController {
  Rx<RequestStatus> requestStatus = RequestStatus.DEFUALT.obs;
  Rx<OperationType> operationType = OperationType.NONE.obs;

  Future runFutureFunction({required Future function}) async {
    return await function;
  }

  Future runLoadingFutureFunction(
      {required Future function,
      OperationType? type = OperationType.NONE}) async {
    requestStatus.value = RequestStatus.LOADING;
    operationType.value = type!;
    await function;
    requestStatus.value = RequestStatus.DEFUALT;
    operationType.value = OperationType.NONE;
  }

  Future runFullLoadingFutureFunction({
    required Future function,
  }) async {
    customLoader();
    await function;
    BotToast.closeAllLoading();
  }
}
