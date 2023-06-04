import 'package:fluttertoast/fluttertoast.dart';

import '../constants/app_colors.dart';


class ToastMessage{
  static showMessage(String msg){
     Fluttertoast.showToast(
       backgroundColor: AppColors.primaryColor,
         gravity: ToastGravity.TOP_RIGHT,
         msg: msg,);
   }

}