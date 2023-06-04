import 'package:get/get.dart';

class DetailsOfProducts extends GetxController {
  int selectedIndex = 0;

  changeIndex(int index) {
    selectedIndex = index;
    update();
  }
}
