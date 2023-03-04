import 'dart:io';

import 'package:nkr_e_mart/comoonWidgets/Exit_dialogue.dart';
import 'package:nkr_e_mart/controller/home_controller.dart';
import 'package:nkr_e_mart/view/Category/category_screen.dart';
import 'package:nkr_e_mart/view/HomeScreen/home_screen.dart';
import 'package:nkr_e_mart/view/profile/profile_screen.dart';

import '../../const/consts.dart';
import '../Cart/cart_screen.dart';

class Home extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  Home({Key? key}) : super(key: key);

  var navbarItem = [
    BottomNavigationBarItem(icon: Image.asset(icHome, width: 26), label: home),
    BottomNavigationBarItem(
        icon: Image.asset(icCategories, width: 26), label: categories),
    BottomNavigationBarItem(icon: Image.asset(icCart, width: 26), label: cart),
    BottomNavigationBarItem(
        icon: Image.asset(icProfile, width: 26), label: account),
  ];
  var navBody = [
    const HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() =>
                Expanded(child: navBody[homeController.navigationIndex.value]))
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: redColor,
            currentIndex: homeController.navigationIndex.value,
            items: navbarItem,
            onTap: (val) {
              homeController.navigationIndex.value = val;
            },
          ),
        ),
      ),
    );
  }
}
