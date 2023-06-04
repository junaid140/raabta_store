import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class AppColors {
  static const primaryColor = Color(0xFFFFBF53);
  static const borderColor = Color(0xFFECEDEE);
  static const priceTagColor = Color.fromARGB(255, 38, 154, 250);
  static const roundButtonColor = Color(0xFFFFBF53);
  static const textColor = Color(0xff20235f);
  static const orderTextColor = Color(0xffb1afbc);
  static const black = Color(0xff1B2129);
  static const gradientBorder =  GradientBoxBorder(
    gradient: LinearGradient(colors: [Colors.green, Colors.yellow]),width: 3);
  Map<int, int> rgbo = {
    1: 38,
    2: 146,
    3: 41,
  };

  MaterialColor getMaterialColor() {
    Map<int, Color> color = {
      50: Color.fromRGBO(rgbo[1]!, rgbo[2]!, rgbo[3]!, .1),
      100: Color.fromRGBO(rgbo[1]!, rgbo[2]!, rgbo[3]!, .2),
      200: Color.fromRGBO(rgbo[1]!, rgbo[2]!, rgbo[3]!, .3),
      300: Color.fromRGBO(rgbo[1]!, rgbo[2]!, rgbo[3]!, .4),
      400: Color.fromRGBO(rgbo[1]!, rgbo[2]!, rgbo[3]!, .5),
      500: Color.fromRGBO(rgbo[1]!, rgbo[2]!, rgbo[3]!, .6),
      600: Color.fromRGBO(rgbo[1]!, rgbo[2]!, rgbo[3]!, .7),
      700: Color.fromRGBO(rgbo[1]!, rgbo[2]!, rgbo[3]!, .8),
      800: Color.fromRGBO(rgbo[1]!, rgbo[2]!, rgbo[3]!, .9),
      900: Color.fromRGBO(rgbo[1]!, rgbo[2]!, rgbo[3]!, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFF269229, color);
    return colorCustom;
  }
}
