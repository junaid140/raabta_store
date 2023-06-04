import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:markaz_clone/modals/logout_modal/logout_modals.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/utils/app_urls.dart';
import 'package:markaz_clone/views/main_page/views/login_view/login_page.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/account_settings/business_details/business_details.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/account_settings/favorites.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/account_settings/followed_shops.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/account_settings/mera_profit.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/account_settings/payment_methods/payment_method.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/account_settings/shared_items.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/help&support/help.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/help&support/privacy_policy.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/help&support/terms_conditions.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/widgets/flutter_toast.dart';
import 'package:markaz_clone/widgets/get_token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewController extends GetxController {
  int totalSale = 0;
  int completedOrders = 0;
  int totalProfit = 0;
  int totalBonus = 0;
  DateTime now = DateTime.now();
  String groupValue = "All time";
  String monthlySale = "Monthly";
  String allTimeSale = "All time";
  changeSaleValue(value) {
    groupValue = value;
    update();
  }

  String formatedDate() {
    return DateFormat("MMM, yyyy").format(now);
  }

  List<String> accountSettingTitles = [
    "Mera Profit",
    "Business Details",
    "Payment Method Add Krein",
    "Followed Shops",
    "Favorites",
    "Shared Items",
  ];
  List<String> accountSupportTiltle = [
    "Help",
    "Terms & conditions",
    "Privacy Policy",
  ];
  List<Widget> helpAndSupport() {
    return [
      const Help(),
      const TermsAndConditions(),
      const PrivacyPolicy(),
    ];
  }

  List<Widget> accountSettingScreens({
    required String address,
    required String businessName,
    required String city,
    required String phoneNumber,
  }) {
    return [
      const MeraProfit(),
      BusinessDetails(
        address: address,
        businessName: businessName,
        city: city,
        phoneNumber: phoneNumber,
      ),
       const PaymentMethod(),
      const FollowedShops(),
      const Favorites(
        favoritesItems: 0,
      ),
      const SharedItems(
        sharedItems: 0,
      ),
    ];
  }

  //logout api integration:

var logoutResponse = LogoutModal().obs;
  bool isLoading = false ;

  setLoading(bool loading){
    isLoading = loading;
    update();
  }

  Future<void> logout(context)async{
    try{
      setLoading(true);
      final token = await GetToken().getToken();
      final response = await http.get(Uri.parse(Urls.logOutUrl),headers: {
        "Authorization":"Bearer $token"
      });

      if(response.statusCode==200){
        setLoading(false);
        logoutResponse.value = LogoutModal.fromJson(json.decode(response.body));
        final SharedPreferences pref =await SharedPreferences.getInstance();
        pref.remove("email");
        pref.remove("token");
        AppNavigations.off(context, nextScreen: LoginPage());
      }else{
        debugPrint("error: ${response.body}");
        setLoading(false);
        ToastMessage.showMessage(logoutResponse.value.data!.message!);
      }
    }catch(e){
      debugPrint("$e error in logout function");
      setLoading(false);
    }

  }
}
