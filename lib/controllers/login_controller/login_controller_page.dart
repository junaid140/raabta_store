import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/modals/login_modal/loginModals.dart';
import 'package:markaz_clone/utils/app_urls.dart';
import 'package:markaz_clone/widgets/flutter_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import '../../utils/app_navigations.dart';
import '../../views/main_page/main_page.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final passwordRegex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$');



  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool value) {
    _isLoading = value;
    update();
  }

  void loginUser(String email, String password,context) async {
    setLoading(true);
    try {
      final response = await http.post(Uri.parse(Urls.loggedInUrl),
          body: json.encode({
            'email': email,
            'password': password,
          }),
          headers: {
            "Content-type": "application/json",
          });
      final data = LoginModals.fromJson(json.decode(response.body)).data;

      if (response.statusCode == 200) {
        SharedPreferences pref =await SharedPreferences.getInstance();
        pref.setString("email", email);
        pref.setString("token", "${data?.token!}");
        pref.setString("userId", "${data?.doc?.id!}");
        Fluttertoast.showToast(
          backgroundColor: AppColors.primaryColor,
          gravity: ToastGravity.TOP_RIGHT,
          msg: data!.message.toString(),);
        AppNavigations.off(context, nextScreen: MainPage());
        setLoading(false);
      } else {
        ToastMessage.showMessage(data!.message.toString());
        setLoading(false);
      }
    } catch (e) {
      debugPrint(e.toString());
      setLoading(false);
    }
  }
}
