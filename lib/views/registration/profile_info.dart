import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/controllers/registration_controllers/profile_info_controller.dart';
import 'package:markaz_clone/views/main_page/views/login_view/login_page.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: const MyAppBar(
          ),
          body: Padding(
            padding: AppSpacings.defaultPadding,
            child: GetBuilder<ProfileInfoController>(
              init: ProfileInfoController(),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(
                      text: "Choose Gender",
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            contentPadding: controller.selectedIndex == index
                                ? null
                                : const EdgeInsets.only(left: 30),
                            onTap: () {
                              controller.changeIndex(index);
                            },
                            title: Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(
                                  width: 10,
                                ),
                                AppText(
                                  text: controller.genders[index],
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                width:
                                    controller.selectedIndex == index ? 1.5 : 1,
                                color: controller.selectedIndex == index
                                    ? AppColors.primaryColor
                                    : Colors.grey.withOpacity(0.2),
                              ),
                            ),
                            trailing: controller.selectedIndex == index
                                ? const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: AppColors.primaryColor,
                                    child: Icon(
                                      Icons.check,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const AppText(
                      text: "Choose age",
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3.5,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.ages.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            controller.changeAgeIndex(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: controller.selectedAgeIndex == index
                                    ? 1.5
                                    : 1,
                                color: controller.selectedAgeIndex == index
                                    ? AppColors.primaryColor
                                    : Colors.grey.withOpacity(0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  controller.selectedAgeIndex == index
                                      ? MainAxisAlignment.spaceBetween
                                      : MainAxisAlignment.center,
                              children: [
                                AppText(
                                  text: controller.ages[index],
                                  fontWeight: FontWeight.w500,
                                ),
                                controller.selectedAgeIndex == index
                                    ? const CircleAvatar(
                                        radius: 10,
                                        backgroundColor: AppColors.primaryColor,
                                        child: Icon(
                                          Icons.check,
                                          size: 10,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                    AppButton(
                      onTap: () {
                        Get.offAll(
                          () => LoginPage(),
                        );
                      },
                      text: "Done",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
