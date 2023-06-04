import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/controllers/registration_controllers/otp_controller.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/registration/profile_info.dart';
import 'package:markaz_clone/views/registration/registration_page.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_formfield.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;
  const OtpVerificationPage({
    Key? key,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: Padding(
            padding: AppSpacings.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  text: "Verification Code",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "We have sent the verification to ",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "${widget.phoneNumber} . ",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              AppNavigations.off(
                                context,
                                nextScreen: RegistrationPage(),
                              );
                            },
                          text: "Change phone Number?",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppPinField(),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: const [
                      AppText(
                        text: "Have a problem?",
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppText(
                        text: "Contact Customer Support",
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GetBuilder<OtpController>(
                  init: OtpController(),
                  builder: (_) {
                    return AppButton(
                      btnColor: _.isOtpExpires
                          ? AppColors.primaryColor
                          : Colors.grey.withOpacity(0.2),
                      onTap: _.isOtpExpires
                          ? () {
                              _.restartTimer();
                            }
                          : null,
                      text: _.isOtpExpires
                          ? "Resend OTP"
                          : "Resend in:${_.otpTime}",
                      textColor: _.isOtpExpires ? Colors.white : Colors.grey,
                    );
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                AppButton(
                  onTap: () {
                    AppNavigations.off(
                      context,
                      nextScreen: const ProfileInfo(),
                    );
                  },
                  text: "Submit",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
