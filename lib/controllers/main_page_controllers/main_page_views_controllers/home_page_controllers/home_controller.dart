import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import '../../../../modals/home_modals/bannar_modal.dart';

class HomeController extends GetxController {

  final PageController pageController = PageController();


  int selectedIndex = 0;
  changeIndex(int index) {
    selectedIndex = index;
    update();
  }
  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }
  var banners = <Docs>[].obs;
  bool isLoading = true;


  Future<List<Docs>?> fetchBanners()async{

    isLoading = true;
    update();
    try{
      var response = await http.get(Uri.parse(Urls.bannersUrl),headers: {
        "Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDA3NDQzZmI1Mjc4ODJkNDc3MGFiYmYiLCJpYXQiOjE2ODA1MTg2NTUsImV4cCI6MTY4MTEyMzQ1NX0.2aPs9EwyThe5WEDZZ0nQT57jcRSKDifRb8Mp41oZoLo",
        "content-type": "application/json",
      });
      if(response.statusCode ==200){
        final data = GetImageBannersModal.fromJson(json.decode(response.body)).data;
        banners.assignAll(data!.docs!);
        return data.docs!;
      }else{
        isLoading = false;
        update();
        print(response.body);
        print('Request failed with status: ${response.statusCode}.');
      }

    }catch(e){
      isLoading = false;
      update();
      print('Request failed with error: $e.');
    }
    return null;
  }
}
