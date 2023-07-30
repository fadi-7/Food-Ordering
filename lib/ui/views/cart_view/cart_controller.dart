import 'package:get/get_rx/src/rx_types/rx_types.dart';
import '../../../app/core/data/models/cart_model.dart';
import '../../../app/core/services/base_controller.dart';
import '../../shared/utils.dart';

class CartController extends BaseController {
  RxList<CartModel> cartList = <CartModel>[].obs;

  @override
  void onInit() {
    cartList.value = storage.getCartList();
    changeTotals();
    super.onInit();
  }

  void removeFromCart(CartModel model) {
    cartService.removeFromCart(
        model: model,
        afterRemove: () {
          changeTotals();
        });
  }

  void changeCount(bool incress, CartModel model) {
    cartService.changeCount(
        incress: incress,
        model: model,
        afterChange: () {
          changeTotals();
        });
  }

  double calcSubTotal() {
    return cartList.fold(0.0, (sum, element) => sum + element.total!);
  }

  double calcTax() {
    return calcSubTotal() * taxAmount;
  }

  double calcDelivery() {
    return (calcSubTotal() + calcTax()) * deliveryAmount;
  }

  double calcTotal() {
    return calcSubTotal() + calcTax() + calcDelivery();
  }

  void changeTotals() {
    calcSubTotal();
    calcTax();
    calcDelivery();
    calcTotal();
  }
}
