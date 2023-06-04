import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/views/main_page/views/category_view/category_view.dart';
import 'package:markaz_clone/views/main_page/views/home_view/home_page/home_view.dart';
import 'package:markaz_clone/views/main_page/views/orders/orders_view.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/profile_view.dart';
import 'package:markaz_clone/views/main_page/views/search_view/search_view.dart';

class MainPageController extends GetxController {
  int selectedIndex = 0;

  changeIndex(int value) {
    selectedIndex = value;
    update();
  }

  List<Widget> mainPageViews = [
    const HomeView(),
    const CategoryView(),
     SearchView(),
    const OrdersView(),
    const ProfileView(),
  ];
}
