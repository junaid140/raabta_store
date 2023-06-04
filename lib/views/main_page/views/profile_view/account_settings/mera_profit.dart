import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/controllers/main_page_controllers/profile_view_controllers/account_settings_controllers/mera_profit_controller.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';

class MeraProfit extends StatelessWidget {
  const MeraProfit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
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
          ),
          body: GetBuilder<MeraProfitController>(
            init: MeraProfitController(),
            builder: (controller) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton(
                        width: 120,
                        height: 40,
                        onTap: () {
                          controller.changeIndex(0);
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.ease,
                          );
                        },
                        fontSize: 14,
                        text: "Pending",
                        textColor: controller.selectedIndex == 0
                            ? Colors.white
                            : Colors.black,
                        btnColor: controller.selectedIndex == 0
                            ? AppColors.primaryColor
                            : Theme.of(context).scaffoldBackgroundColor,
                        borderColor: controller.selectedIndex == 0
                            ? null
                            : AppColors.borderColor,
                      ),
                      AppButton(
                        width: 120,
                        height: 40,
                        onTap: () {
                          controller.changeIndex(1);
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.ease,
                          );
                        },
                        fontSize: 14,
                        text: "Paid",
                        textColor: controller.selectedIndex == 1
                            ? Colors.white
                            : Colors.black,
                        btnColor: controller.selectedIndex == 1
                            ? AppColors.primaryColor
                            : Theme.of(context).scaffoldBackgroundColor,
                        borderColor: controller.selectedIndex == 1
                            ? null
                            : AppColors.borderColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: SvgPicture.asset(
                                "assets/wallet.svg",
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: AppText(
                                text: index == 0
                                    ? "No pending payment"
                                    : "No paid payment",
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
