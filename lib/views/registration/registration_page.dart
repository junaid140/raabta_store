import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/main_page/views/login_view/login_page.dart';
import 'package:markaz_clone/widgets/app_formfield.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import '../../controllers/registration_controller/register_controller_page.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController phonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: const MyAppBar(
          ),
          body: GetBuilder<RegistrationController>(
            init: RegistrationController(),
            builder: (controller){
              return SingleChildScrollView(
                child: Padding(
                  padding: AppSpacings.defaultPadding,
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
                        text: "Apni profile banayain",
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppFormfield(
                              controller: controller.firstNameController,
                              labelText: "First Name",
                              hintText: "First Name",
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter your first name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppFormfield(
                              controller: controller.lastNameController,
                              labelText: "Last Name",
                              hintText: "Last Name",
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter your last name";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppFormfield(
                              controller: controller.numberController,
                              labelText: "Phone Number",
                              hintText: "Phone Number",
                              validator: (value){
                                if(value!.isEmpty){
                                  return "Please enter your Phone Number";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppFormfield(
                              controller: controller.emailController,
                              labelText: "Email",
                              hintText: "Email",
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
                              height: 20,
                            ),
                            AppFormfield(
                              controller: controller.passwordController,
                              labelText: "password",
                              hintText: "Password",
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (!controller.passwordRegex.hasMatch(value)) {
                                  return 'Please enter a valid password with at least 8 characters,\n one uppercase , one lowercase , and one digit';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: (){
                          if (_formKey.currentState!.validate()) {
                            controller.registerUsers(
                                controller.firstNameController.text,
                                controller.lastNameController.text,
                                controller.emailController.text,
                                controller.passwordController.text,
                                controller.numberController.text,
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
                          child: controller.isLoading? const Center(
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballBeat,
                              strokeWidth: 4,
                              colors: [
                                Colors.white,
                                Colors.white,
                                Colors.white,
                              ],),
                          ): const Center(
                            child: AppText(
                              text: "Register",
                              color:  Colors.white,
                              fontSize:  17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children:  [
                          const  AppText(text: "Do you have an account?"),
                          TextButton(
                              onPressed: (){
                                AppNavigations.off(context, nextScreen: LoginPage());
                              },
                              child: const AppText(
                                text: "Login",
                                fontWeight: FontWeight.w500,))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },

          ),
        ),
      ),
    );
  }
}
