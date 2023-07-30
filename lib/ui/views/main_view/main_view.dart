import 'package:flutter/material.dart';
import 'package:food_orders_proj/app/core/enums/bottom_navigation.dart';
import 'package:food_orders_proj/ui/views/main_view/main_view_widgets/bottom_navigation_widget.dart';
import 'package:food_orders_proj/ui/views/main_view/offers_view/offers_view.dart';
import 'home_view/home_view.dart';
import 'menu_view/menu_view.dart';
import 'more_view/more_view.dart';
import 'profile_view/profile_view.dart';

class MainView extends StatefulWidget {
  MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  BottomNavigationEnum selected = BottomNavigationEnum.HOME;
  PageController controller = PageController(initialPage: 2);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView(controller: controller, children: [
        MenuView(),
        OffersView(),
        HomeView(onPressed: () {}),
        ProfileView(),
        MoreView()
      ]),
      //drawer: CustomDrawer(),
      bottomNavigationBar: BottomNavigationWidget(
        bottomNavigation: selected,
        onTap: (select, pageNumber) {
          setState(() {
            selected = select;
          });
          controller.jumpToPage(pageNumber);
        },
      ),
    ));
  }
}
