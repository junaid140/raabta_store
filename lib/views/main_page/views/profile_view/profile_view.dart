import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/controllers/main_page_controllers/'
    'profile_view_controllers/profile_view_controller.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/'
    'account_settings/payment_methods/payment_manager.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cart_view/cart_manager.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    CartRep cartRep = CartRep(prefs: SharedPreferences.getInstance());
    PaymentManager paymentManager = PaymentManager(prefs: SharedPreferences.getInstance());
    return GetBuilder<ProfileViewController>(
      init: ProfileViewController(),
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 230,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color.fromRGBO(0, 2, 103, 1),
                        Color.fromRGBO(38, 146, 41, 1),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      RoundButton(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return GetBuilder<ProfileViewController>(
                                  init: ProfileViewController(),
                                  builder: (_) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 50),
                                      height: 230,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(18.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: AppText(
                                                        text: "Show Sales",
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 17,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            RadioListTile(
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .trailing,
                                              title: AppText(
                                                text: _.monthlySale,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              value: _.monthlySale,
                                              groupValue: controller.groupValue,
                                              onChanged: (value) {
                                                controller
                                                    .changeSaleValue(value);
                                              },
                                            ),
                                            const Divider(),
                                            RadioListTile(
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .trailing,
                                              title: AppText(
                                                text: _.allTimeSale,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              value: _.allTimeSale,
                                              groupValue: controller.groupValue,
                                              onChanged: (value) {
                                                controller
                                                    .changeSaleValue(value);
                                              },
                                            ),
                                            const Divider(),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          );
                        },
                        text: controller.groupValue,
                        btnColor: Colors.white.withOpacity(0.1),
                        textColor: Colors.white,
                        height: 35,
                        width: 100,
                        borderColor: Colors.white,
                        trailing: const Padding(
                          padding: EdgeInsets.only(left: 5.0),
                          child: Icon(
                            size: 20,
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      AppText(
                        text: "Rs. ${controller.totalSale}",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      AppText(
                        text: controller.groupValue == controller.allTimeSale
                            ? "Total Sales"
                            : "Sale in ${controller.formatedDate()}",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              AppText(
                                text: controller.completedOrders.toString(),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const AppText(
                                text: "Completed\nOrders",
                                textAlign: TextAlign.center,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              AppText(
                                text: "Rs. ${controller.totalProfit}",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const AppText(
                                text: "Total\nProfit",
                                textAlign: TextAlign.center,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              AppText(
                                text: "Rs. ${controller.totalBonus}",
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const AppText(
                                text: "Total\n Bonus",
                                textAlign: TextAlign.center,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const AppText(
                  text: "Account",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                Column(
                  children: List.generate(
                    controller.accountSettingTitles.length,
                    (index) {
                      return ListTile(
                        onTap: () {
                          AppNavigations.to(
                            context,
                            nextScreen: controller.accountSettingScreens(
                              address: "Address",
                              businessName: "business",
                              city: "Multan",
                              phoneNumber: "0300000000",
                            )[index],
                          );
                        },
                        shape: const Border(
                          bottom: BorderSide(
                            color: AppColors.borderColor,
                            width: 0.5,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.wallet),
                        title: AppText(
                          text: controller.accountSettingTitles[index],
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const AppText(
                  text: "Help & Support",
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                Column(
                  children: List.generate(
                    controller.accountSupportTiltle.length,
                    (index) {
                      return ListTile(
                        onTap: () {
                          AppNavigations.to(
                            context,
                            nextScreen: controller.helpAndSupport()[index],
                          );
                        },
                        shape: const Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.alarm),
                        title: AppText(
                          text: controller.accountSupportTiltle[index],
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.login_outlined),
                  title: const AppText(text: "Logout",fontWeight: FontWeight.w400,
                    fontSize: 14,),
                  trailing: controller.isLoading
                      ?const Align(
                      alignment: Alignment.centerRight,
                      child: CircularProgressIndicator())
                      :null,
                  onTap: ()async{
                   await controller.logout(context);
                    cartRep.clearCart();
                    paymentManager.clearMethod();
                    final SharedPreferences pref =await SharedPreferences.getInstance();
                    pref.remove("token");
                    pref.remove("userId");
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
