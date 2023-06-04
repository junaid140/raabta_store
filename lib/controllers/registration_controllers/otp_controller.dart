import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OtpController extends GetxController {
  bool isOtpExpires = false;
  bool isClicked = false;
  setBoolValue(newValue){
    isClicked = newValue;
    update();
  }
  DateTime currentTime = DateTime(
    2023,
    0,
    0,
    0,
    0,
    59,
  );
  String? otpTime;
  timer() {
    otpTime = DateFormat().add_ms().format(currentTime);
    update();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime newTime = currentTime.subtract(
        Duration(seconds: timer.tick),
      );

      otpTime = DateFormat().add_ms().format(newTime);

      update();
      if (newTime.second <= 0) {
        timer.cancel();
        isOtpExpires = true;
        update();
      }
    });
  }

  restartTimer() {
    isOtpExpires = false;
    update();
    DateTime newTime = currentTime;
    otpTime = DateFormat().add_ms().format(currentTime);
    update();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      newTime = currentTime.subtract(
        Duration(seconds: timer.tick),
      );
      otpTime = DateFormat().add_ms().format(newTime);
      update();
      if (newTime.second <= 0) {
        timer.cancel();
        isOtpExpires = true;
        update();
      }
    });
  }

  @override
  void onInit() {
    timer();
    super.onInit();
  }
}
