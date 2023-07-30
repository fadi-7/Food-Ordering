import 'package:flutter/material.dart';
import 'package:food_orders_proj/app/core/data/models/apies/meal_model.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';
import 'package:food_orders_proj/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_orders_proj/ui/views/meal_details_view/meal_details_controller.dart';
import 'package:get/get.dart';
import '../../shared/utils.dart';

class MealDetailsView extends StatefulWidget {
  final MealModel model;
  MealDetailsView({Key? key, required this.model}) : super(key: key);

  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {
  late MealDetailsController controller;
  @override
  void initState() {
    controller = Get.put(MealDetailsController(widget.model));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Text(
            'Price: ${widget.model.price}',
            style: TextStyle(fontSize: screenWidth(10)),
          ),
          Obx(() {
            return Row(
              children: [
                CustomButton(
                  text: '+',
                  onPressed: () {
                    controller.changeCount(true);
                  },
                ),
                CustomButton(
                  text: controller.count.value.toString(),
                  onPressed: () {},
                ),
                CustomButton(
                  text: '-',
                  onPressed: controller.count.value == 1
                      ? () {}
                      : () {
                          controller.changeCount(false);
                        },
                  backgroundColor: controller.count.value == 1
                      ? AppColors.greyMainColor
                      : AppColors.orangeMainColor,
                ),
              ],
            );
          }),
          Obx(() {
            return Text(
              controller.calcTotal().toString(),
              style: TextStyle(fontSize: screenWidth(10)),
            );
          }),
          CustomButton(
            text: 'add',
            onPressed: () {
              controller.addToCart();
            },
          )
        ],
      )),
    );
  }
}
