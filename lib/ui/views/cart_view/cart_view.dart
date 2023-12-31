import 'package:flutter/material.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';
import 'package:get/get.dart';
import '../../shared/custom_widgets/custom_button.dart';
import '../../shared/utils.dart';
import 'cart_controller.dart';

class CartView extends StatefulWidget {
  CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartController controller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Obx(() {
      return Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            itemCount: controller.cartList.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  IconButton(
                      onPressed: () {
                        controller.removeFromCart(controller.cartList[index]);
                      },
                      icon: Icon(Icons.delete)),
                  Column(
                    children: [
                      Text(
                        controller.cartList[index].mealModel?.name ?? '',
                        style: TextStyle(fontSize: screenWidth(10)),
                      ),
                      Text(
                        controller.cartList[index].mealModel!.price.toString(),
                        style: TextStyle(fontSize: screenWidth(10)),
                      ),
                      Row(
                        children: [
                          CustomButton(
                            text: '-',
                            onPressed: () {
                              controller.changeCount(
                                  false, controller.cartList[index]);
                            },
                          ),
                          Text(
                            controller.cartList[index].count.toString(),
                            style: TextStyle(fontSize: screenWidth(10)),
                          ),
                          CustomButton(
                            text: '+',
                            onPressed: () {
                              controller.changeCount(
                                  true, controller.cartList[index]);
                            },
                          ),
                        ],
                      ),
                      Text(
                        controller.cartList[index].total.toString(),
                        style: TextStyle(fontSize: screenWidth(10)),
                      ),
                    ],
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return Container(
                width: screenWidth(1),
                height: 2,
                color: AppColors.orangeMainColor,
              );
            },
          ),
          Text(
            'sub Total: ${controller.calcSubTotal()}',
            style: TextStyle(fontSize: screenWidth(10)),
          ),
          Text(
            'Tax: ${controller.calcTax()}',
            style: TextStyle(fontSize: screenWidth(10)),
          ),
          Text(
            'Delivery: ${controller.calcDelivery()}',
            style: TextStyle(fontSize: screenWidth(10)),
          ),
          Text(
            'Total: ${controller.calcTotal()}',
            style: TextStyle(fontSize: screenWidth(10)),
          ),
        ],
      );
    })));
  }
}
