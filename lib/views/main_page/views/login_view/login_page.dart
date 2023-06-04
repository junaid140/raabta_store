import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/controllers/login_controller/login_controller_page.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/registration/registration_page.dart';
import 'package:markaz_clone/widgets/app_formfield.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child:Scaffold(
          appBar: MyAppBar(),
          body: Padding(
            padding: AppSpacings.defaultPadding,
            child: GetBuilder<LoginController>(
              init: LoginController(),
              builder: (controller){
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        text: "Welcome!",
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const AppText(
                        text: "Apnay email sy login karen.",
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Form(
                        key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppFormfield(
                                hintText: "Email",
                                labelText: "Email",
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter an email address';
                                  }
                                  if (!controller.emailRegex.hasMatch(value)) {
                                    return 'Please enter a valid email address';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              AppFormfield(
                                hintText: 'Password',
                                labelText: 'Password',
                                controller: controller.passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: (){
                                  if (_key.currentState!.validate()) {
                                    controller.loginUser(
                                        controller.emailController.text,
                                        controller.passwordController.text,
                                        context
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  width: Get.width,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.primaryColor,
                                    border: Border.all(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  child: controller.isLoading?
                                  const Center(
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.ballBeat,
                                      strokeWidth: 4,
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                        Colors.white,
                                      ],),
                                  )
                                      : const Center(
                                    child: AppText(
                                      text: "Login",
                                      color:  Colors.white,
                                      fontSize:  17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children:  [
                                  const  AppText(text: "Don't have an account?"),
                                  TextButton(
                                      onPressed: (){
                                        AppNavigations.off(context, nextScreen: RegistrationPage());
                                      },
                                      child: const AppText(
                                        text: "Register",
                                        fontWeight: FontWeight.w500,))
                                ],
                              ),
                            ],))
                    ],
                  ),
                );
              },
            ),
          ),
        ),

      ),
    );
  }
}


