import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/controllers/registration_controllers/otp_controller.dart';
import 'package:markaz_clone/modals/payment_modals/payment_modal.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/'
    'account_settings/payment_methods/payment_manager.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/'
    'account_settings/payment_methods/payment_method.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../widgets/app_formfield.dart';
import 'add_payment_method.dart';

class OTPPage extends StatelessWidget {
  final String number;

  final String image;

  final String name;

  OTPPage({Key? key,  this.number = '', this.name = '', this.image = ''})
      : super(key: key);
  final payment = PaymentManager(prefs: SharedPreferences.getInstance());

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: MyAppBar(
            height: 55,
            leading: InkWell(
                onTap: () {
                  AppNavigations.off(context, nextScreen: AddPaymentMethod());
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.textColor,
                )),
            title: const AppText(
              text: "OTP Verification",
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, top: 5),
                child: CircularPercentIndicator(
                  addAutomaticKeepAlive: true,
                  animation: true,
                  radius: 25.0,
                  lineWidth: 3.0,
                  percent: 1.0,
                  center: const AppText(
                    text: "2 of 2",
                    fontSize: 13,
                    color: AppColors.orderTextColor,
                  ),
                  progressColor: Colors.green,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: AppSpacings.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                  text:
                      "We have sent a verification code to your registered number\n $number",
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 30,
                ),
                const AppPinField(),
                const SizedBox(
                  height: 30,
                ),
                GetBuilder<OtpController>(
                  init: OtpController(),
                  builder: (_) {
                    return InkWell(
                      onTap: _.isOtpExpires
                          ? () {
                              _.restartTimer();
                            }
                          : null,
                      child: AppText(
                        text: _.isOtpExpires
                            ? "Resend OTP"
                            : "Resend in:${_.otpTime}",
                        color: _.isOtpExpires
                            ? AppColors.textColor
                            : AppColors.orderTextColor,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: AppButton(
                    text: "Confirm",
                    fontSize: 14,
                    onTap: () {
                      payment.addToCart(PaymentModal(
                          id: DateTime.now().toString(),
                          name: name,
                          image: image,
                          number: int.parse(number)));
                      AppNavigations.off(context,
                          nextScreen: const PaymentMethod());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
