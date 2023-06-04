import 'package:flutter/material.dart';

class AppNavigations {
  static to(BuildContext context, {required Widget nextScreen}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
    );
  }

  static off(BuildContext context, {required Widget nextScreen}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => nextScreen,
      ),
    );
  }
}
