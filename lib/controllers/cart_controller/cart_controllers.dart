import 'package:get/get.dart';

class CartController extends GetxController {
  int add = 1;

  addMore() {
    add++;
    update();
  }

  subtractLess() {
    if (add > 1) {
      add--;
    }
    update();
  }

  RxInt isSelected = RxInt(-1);

  changeSelectedValue(int index) {
    isSelected.value = index;
    update();
  }
}
