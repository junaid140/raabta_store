import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/views/main_page/main_page.dart';
import 'package:markaz_clone/views/on_boarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  var email = pref.getString("email");
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Rabta Store',
    theme: ThemeData(
      progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.primaryColor,
    ),
      primarySwatch: AppColors().getMaterialColor(),
      tabBarTheme: const TabBarTheme(
        unselectedLabelColor: Colors.grey,
      ),
      checkboxTheme: const CheckboxThemeData(
        side: BorderSide(
          color: Colors.black12,
          width: 2,
        ),
      ),
    ),
    home: email == null ? OnBoardingPage() : MainPage(),
  ));
}
