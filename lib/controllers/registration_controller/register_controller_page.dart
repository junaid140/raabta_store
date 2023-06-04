import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/modals/registration_modal/registerUsersModals.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/utils/app_urls.dart';
import 'package:markaz_clone/views/main_page/views/login_view/login_page.dart';
import 'package:markaz_clone/views/registration/profile_info.dart';
import 'package:markaz_clone/widgets/flutter_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/profile_image.dart';

class RegistrationController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final passwordRegex =
      RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$');


  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool value){
    _isLoading = value;
    update();
  }
  void registerUsers (
    String firstName,
    String lastName,
    String email,
    String password,
    String number,
    context)async{

    setLoading(true);
    try{
      final response = await http.post(Uri.parse(Urls.registrationUrl),
          body: json.encode({
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'phone': number,
            'password':password,
            'image':profileImage,
          }
          ),
          headers: {'Content-Type': 'application/json'}
      );
      final  registerUsersModals = RegisterUsersModals.fromJson(json.decode(response.body)).data;

      if(response.statusCode== 201){
        SharedPreferences pref =await SharedPreferences.getInstance();
        pref.setString("email", email);
        AppNavigations.off(context, nextScreen: ProfileInfo());
        ToastMessage.showMessage('User registered successfully');
        setLoading(false);
        update();
      }
      else{
        debugPrint(response.body);
        ToastMessage.showMessage(registerUsersModals!.message.toString());
        setLoading(false);
      }
    }catch(e){
      debugPrint(e.toString());
      ToastMessage.showMessage(e.hashCode.toString());
    }

}
}
