import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:food_orders_proj/ui/views/meal_details_view/meal_details_view.dart';
import '../../../shared/colors.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeView extends StatefulWidget {
  final Function onPressed;
  HomeView({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          drawer: Container(
            color: AppColors.redGoogleButton,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  return controller.isCategoryLoading
                      ? SpinKitCircle(
                          color: AppColors.orangeMainColor,
                        )
                      : controller.categoryList.isEmpty
                          ? Text('No Category')
                          : Container(
                              width: screenWidth(1),
                              height: screenWidth(4),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: controller.categoryList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      Get.to(MealDetailsView(
                                        model: controller.mealList[index],
                                      ));
                                    },
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              'http://via.placeholder.com/350x150',
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        Text(
                                          controller.categoryList[index].name ??
                                              '',
                                          style: TextStyle(fontSize: 50),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                }),
                Obx(() {
                  return controller.isMealLoading
                      ? SpinKitCircle(
                          color: AppColors.orangeMainColor,
                        )
                      : controller.mealList.isEmpty
                          ? Text('No Meal')
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.mealList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await Get.to(MealDetailsView(
                                            model: controller.mealList[index]));

                                        controller.cartCount.value =
                                            cartService.getCartCount();
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'http://via.placeholder.com/350x150',
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Text(
                                      controller.mealList[index].name ?? '',
                                      style: TextStyle(fontSize: 50),
                                    ),
                                  ],
                                );
                              },
                            );
                })
              ],
            ),
          )),
    );
  }
}
          
          //         meals!.fold((l) {
          //           CustomToast.showMeassge(
          //               message: l, messageType: MessageType.REJECTED);
          //         }, (r) {
          //           mealList.clear();
          //           mealList.addAll(r);
          //         });
          //       }

          //       return Column(
          //         children: [
          //           categories == null
          //               ? SpinKitCircle(
          //                   color: AppColors.mainOrangeColor,
          //                 )
          //               : Expanded(
          //                   child: ListView.builder(
          //                     scrollDirection: Axis.horizontal,
          //                     shrinkWrap: true,
          //                     itemCount: categoryList.length,
          //                     itemBuilder: (BuildContext context, int index) {
          //                       return Column(
          //                         children: [
          //                           CachedNetworkImage(
          //                             imageUrl:
          //                                 'http://via.placeholder.com/350x150',
          //                             placeholder: (context, url) =>
          //                                 CircularProgressIndicator(),
          //                             errorWidget: (context, url, error) =>
          //                                 Icon(Icons.error),
          //                           ),
          //                           Text(
          //                             categoryList[index].name ?? '',
          //                             style: TextStyle(fontSize: 50),
          //                           ),
          //                         ],
          //                       );
          //                     },
          //                   ),
          //                 ),
          //           meals == null
          //               ? SpinKitCircle(
          //                   color: AppColors.mainOrangeColor,
          //                 )
          //               : Expanded(
          //                   child: ListView.builder(
          //                     scrollDirection: Axis.vertical,
          //                     shrinkWrap: true,
          //                     itemCount: mealList.length,
          //                     itemBuilder: (BuildContext context, int index) {
          //                       return Column(
          //                         children: [
          //                           CachedNetworkImage(
          //                             imageUrl:
          //                                 'http://via.placeholder.com/350x150',
          //                             placeholder: (context, url) =>
          //                                 CircularProgressIndicator(),
          //                             errorWidget: (context, url, error) =>
          //                                 Icon(Icons.error),
          //                           ),
          //                           Text(
          //                             mealList[index].name ?? '',
          //                             style: TextStyle(fontSize: 50),
          //                           ),
          //                         ],
          //                       );
          //                     },
          //                   ),
          //                 ),
          //         ],
          //       );
          //     }))
          // FutureBuilder<List<dynamic>>(
          //     future: Future.wait([
          //       CategoryRepository().getAll(),
          //       MealRepository().getAll(),
          //     ]),
          //     builder: ((context, AsyncSnapshot<List<dynamic>> snapshot1) {
          //       var categories = snapshot1.data != null
          //           ? snapshot1.data![0]
          //               as dartz.Either<String, List<CategoryModel>>
          //           : null;
          //       var meals = snapshot1.data != null
          //           ? snapshot1.data![1]
          //               as dartz.Either<String, List<MealModel>>
          //           : null;

          //       if (snapshot1.connectionState != ConnectionState.waiting) {
          //         categories!.fold((l) {
          //           CustomToast.showMeassge(
          //               message: l, messageType: MessageType.REJECTED);
          //         }, (r) {
          //           categoryList.clear();
          //           categoryList.addAll(r);
          //         });

// class HomeView extends StatefulWidget {
//   final Function onPressed;
//   HomeView({Key? key, required this.onPressed}) : super(key: key);

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   List<CategoryModel> categoryList = [];
//   List<MealModel> mealList = [];
//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//           drawer: Container(
//             color: AppColors.redGoogleButton,
//           ),
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
//             child: Column(
//               children: [
//                 (size.width * 0.1).ph,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     CustomText(
//                       text: 'Good morning Akila!',
//                       textSize: size.width * 0.06,
//                       textColor: AppColors.blackMainColor,
//                     ),
//                     Icon(Icons.shopping_cart)
//                   ],
//                 ),
//                 (size.width * 0.08).ph,
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: CustomText(
//                     text: 'Delivering to',
//                     textSize: size.width * 0.025,
//                   ),
//                 ),
//                 (size.width * 0.02).ph,
//                 Row(
//                   children: [
//                     CustomText(
//                       text: 'Current Location',
//                       textColor: AppColors.titlesDarkGrey,
//                       textSize: size.width * 0.045,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     (size.width * 0.09).pw,
//                     Icon(
//                       Icons.arrow_drop_down_sharp,
//                       color: AppColors.orangeMainColor,
//                     )
//                   ],
//                 ),
//                 (size.width * 0.09).ph,
//                 CustomTextField(
//                     hintText: 'Search food', controller: searchController),
//                 Card(
//                   child: SvgPicture.asset(
//                     'images/offers.svg',
//                     fit: BoxFit.cover,
//                   ),
//                   elevation: size.width * 0.008,
//                 ),
//                 FutureBuilder<List<dynamic>>(
//                     future: Future.wait([
//                       CategoryRepository().getall(),
//                       MealRepository().getall(),
//                     ]),
//                     builder:
//                         ((context, AsyncSnapshot<List<dynamic>> snapshot1) {
//                       var categories = snapshot1.data != null
//                           ? snapshot1.data![0]
//                               as dartz.Either<String, List<CategoryModel>>
//                           : null;
//                       var meals = snapshot1.data != null
//                           ? snapshot1.data![1]
//                               as dartz.Either<String, List<MealModel>>
//                           : null;

//                       if (snapshot1.connectionState !=
//                           ConnectionState.waiting) {
//                         categories!.fold((l) {
//                           CustomToast.showMessage(
                             
//                               message: l,
//                               messageType: MessageType.REJECTED);
//                         }, (r) {
//                           categoryList.clear();
//                           categoryList.addAll(r);
//                         });

//                         meals!.fold((l) {
//                           CustomToast.showMessage(
                             
//                               message: l,
//                               messageType: MessageType.REJECTED);
//                         }, (r) {
//                           mealList.clear();
//                           mealList.addAll(r);
//                         });
//                       }
//                       return Column(
//                         children: [
//                           categories == null
//                               ? SpinKitCircle(
//                                   color: AppColors.orangeMainColor,
//                                 )
//                               : Expanded(
//                                   child: ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     shrinkWrap: true,
//                                     itemCount: categoryList.length,
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       return Column(
//                                         children: [
//                                           CachedNetworkImage(
//                                             imageUrl:
//                                                 'http://via.placeholder.com/350x150',
//                                             placeholder: (context, url) =>
//                                                 CircularProgressIndicator(),
//                                             errorWidget:
//                                                 (context, url, error) =>
//                                                     Icon(Icons.error),
//                                           ),
//                                           Text(
//                                             categoryList[index].name ?? '',
//                                             style: TextStyle(fontSize: 50),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 ),
//                           meals == null
//                               ? SpinKitCircle(
//                                   color: AppColors.orangeMainColor,
//                                 )
//                               : Expanded(
//                                   child: ListView.builder(
//                                     scrollDirection: Axis.vertical,
//                                     shrinkWrap: true,
//                                     itemCount: mealList.length,
//                                     itemBuilder:
//                                         (BuildContext context, int index) {
//                                       return Column(
//                                         children: [
//                                           CachedNetworkImage(
//                                             imageUrl:
//                                                 'http://via.placeholder.com/350x150',
//                                             placeholder: (context, url) =>
//                                                 CircularProgressIndicator(),
//                                             errorWidget:
//                                                 (context, url, error) =>
//                                                     Icon(Icons.error),
//                                           ),
//                                           Text(
//                                             mealList[index].name ?? '',
//                                             style: TextStyle(fontSize: 50),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 ),
//                         ],
//                       );
//                     })),
//               ],
//             ),
//           )),
//     );
//   }
// }
