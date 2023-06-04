import 'package:flutter/material.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'main_page/views/login_view/login_page.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({Key? key}) : super(key: key);
  final PageController pageController = PageController();
  final List<String> posters = [
    "assets/images/poster1.png",
    "assets/images/poster2.png",
    "assets/images/poster3.png",
    "assets/images/poster4.png",
  ];
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            actions: [
              InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  AppNavigations.off(
                    context,
                    nextScreen:  LoginPage(),
                  );
                },
                child: const Center(
                  child: AppText(
                    text: "Skip  ",
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: AppSpacings.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    itemCount: posters.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 350,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    posters[index],
                                  ),
                                ),
                              ),
                            ),
                            const AppText(
                              text:
                                  "The standard chunk of Lorem Ipsum the 1500s .",
                              textAlign: TextAlign.center,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const AppText(
                              text:
                                  "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. ",
                              fontWeight: FontWeight.w300,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18.0, bottom: 10),
                      child: SmoothPageIndicator(
                        effect: const WormEffect(
                          activeDotColor: AppColors.primaryColor,
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
                        controller: pageController,
                        count: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              if (pageController.page! > 2.0) {
                AppNavigations.off(
                  context,
                  nextScreen:  LoginPage(),
                );
              } else {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              }
            },
            child: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
