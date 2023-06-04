import 'package:get/get.dart';

class ProfileInfoController extends GetxController {
  List<String> genders = ["Male", "Female", "Unspecified"];
  List<String> ages = ["13-18", "19-24", "25-34", "35-44", "45-54", "54+"];
  int? selectedIndex;
  int? selectedAgeIndex;
  changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  changeAgeIndex(int index) {
    selectedAgeIndex = index;
    update();
  }
}
