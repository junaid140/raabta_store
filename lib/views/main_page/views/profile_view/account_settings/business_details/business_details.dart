import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/controllers/main_page_controllers/profile_view_controllers/account_settings_controllers/business_details_controller.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/account_settings/business_details/edit_business_details.dart';
import 'package:markaz_clone/widgets/app_text.dart';

import '../../../../../../constants/app_colors.dart';
import '../../../../../../widgets/my_app_bar.dart';

class BusinessDetails extends StatelessWidget {
  final String businessName, address, city, phoneNumber;
  const BusinessDetails({
    Key? key,
    required this.address,
    required this.businessName,
    required this.city,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: const AppText(
              text: "Business Details",
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            centerTitle: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  AppNavigations.to(
                    context,
                    nextScreen: EditBusinessDetails(),
                  );
                },
                child: const AppText(
                  text: "Edit",
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: GetBuilder<BusinessDetailsController>(
              init: BusinessDetailsController(),
              builder: (controller) {
                return Column(
                  children: List.generate(
                    controller.businessDetailsTitles.length,
                    (index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        shape: const Border(
                          bottom: BorderSide(
                            color: AppColors.borderColor,
                          ),
                        ),
                        title: AppText(
                          text: controller.businessDetailsTitles[index],
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        trailing: AppText(
                          text: index == 0
                              ? businessName
                              : index == 1
                                  ? address
                                  : index == 2
                                      ? city
                                      : phoneNumber,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
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
