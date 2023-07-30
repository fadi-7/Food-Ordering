import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../../ui/shared/utils.dart';
import '../data/models/apies/meal_model.dart';
import '../data/models/cart_model.dart';

class CartService {
  RxList<CartModel> cartList = storage.getCartList().obs;

  void addToCart({
    required MealModel model,
    required int count,
    Function? afterAdd,
  }) {
    if (getCartModel(model) != null) {
      int index = cartList.indexOf(getCartModel(model)!);
      cartList[index].count = cartList[index].count! + count;
      cartList[index].total = cartList[index].total! + (count * model.price!);
    } else {
      cartList.add(CartModel(
        count: count,
        total: (count * model.price!).toDouble(),
        mealModel: model,
      ));
    }
    storage.setCartList(cartList);
    if (afterAdd != null) afterAdd();
  }

  void removeFromCart({required CartModel model, Function? afterRemove}) {
    cartList.remove(model);
    storage.setCartList(cartList);
    if (afterRemove != null) afterRemove();
  }

  void changeCount(
      {required bool incress,
      required CartModel model,
      Function? afterChange}) {
    CartModel result = getCartModel(model.mealModel!)!;
    int index = cartList.indexOf(result);

    if (incress) {
      result.count = result.count! + 1;
      result.total = result.total! + model.mealModel!.price!;
    } else {
      if (result.count! > 1) {
        result.count = result.count! - 1;
        result.total = result.total! - model.mealModel!.price!;
      }
    }

    cartList.remove(result);
    cartList.insert(index, result);

    storage.setCartList(cartList);
    if (afterChange != null) afterChange();
  }

  CartModel? getCartModel(MealModel model) {
    try {
      return cartList.firstWhere(
        (element) => element.mealModel!.id == model.id,
      );
    } catch (e) {
      return null;
    }
  }

  int getCartCount() {
    return cartList.fold(
        0, (previousValue, element) => previousValue + element.count!);
  }
}
