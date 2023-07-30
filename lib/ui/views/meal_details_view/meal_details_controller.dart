import 'package:food_orders_proj/app/core/services/base_controller.dart';
import 'package:food_orders_proj/app/core/services/cart_service.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:get/get.dart';
import '../../../app/core/data/models/apies/meal_model.dart';
import '../cart_view/cart_view.dart';

class MealDetailsController extends BaseController {
  MealDetailsController(MealModel mealModel) {
    model = mealModel;
  }

  MealModel model = MealModel();
  RxInt count = 1.obs;

  void changeCount(bool incress) {
    if (incress)
      count++;
    else {
      if (count > 1) count--;
    }
  }

  double calcTotal() {
    return (count.value * model.price!).toDouble();
  }

  void addToCart() {
    cartService.addToCart(
        model: model,
        count: count.value,
        afterAdd: () {
          Get.to(() => CartView());
        });
  }
}
