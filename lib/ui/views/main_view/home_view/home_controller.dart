import 'package:food_orders_proj/app/core/data/models/apies/category_model.dart';
import 'package:food_orders_proj/app/core/data/repositories/category_repository.dart';
import 'package:food_orders_proj/app/core/data/repositories/meal_repository.dart';
import 'package:food_orders_proj/app/core/enums/message_type.dart';
import 'package:food_orders_proj/app/core/services/base_controller.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:get/get.dart';
import '../../../../app/core/data/models/apies/meal_model.dart';
import '../../../../app/core/enums/operation_type.dart';
import '../../../../app/core/enums/request_status.dart';
import '../../../shared/custom_widgets/custom_toast.dart';

class HomeController extends BaseController {
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<MealModel> mealList = <MealModel>[].obs;
  RxInt cartCount = 0.obs;

  bool get isCategoryLoading =>
      requestStatus.value == RequestStatus.LOADING &&
      operationType == OperationType.CATEGORY;

  bool get isMealLoading =>
      requestStatus.value == RequestStatus.LOADING &&
      operationType == OperationType.MEAL;

  @override
  void onInit() {
    getAllGategory();
    getAllMeal();
    cartCount.value = cartService.getCartCount();
    super.onInit();
  }

  void getAllGategory() {
    runLoadingFutureFunction(
        type: OperationType.CATEGORY,
        function: CategoryRepository().getall().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            categoryList.addAll(r);
          });
        }));
  }

  void getAllMeal() {
    runLoadingFutureFunction(
        type: OperationType.MEAL,
        function: MealRepository().getall().then((value) {
          value.fold((l) {
            CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED);
          }, (r) {
            mealList.addAll(r);
          });
        }));
  }

  void addToCart(MealModel model) {
    cartService.addToCart(
        model: model,
        count: 1,
        afterAdd: () {
          cartCount.value += 1;
          CustomToast.showMessage(
              message: 'Added', messageType: MessageType.SUCCSESS);
        });
  }
}
