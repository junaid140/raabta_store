import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/widgets/get_token.dart';
import '../../modals/recents_view_modals/my_recents_view_modal.dart';
import '../../utils/app_urls.dart';

class MyRecentViewController extends GetxController{
  
  
  @override
  void onInit() {
    super.onInit();
    fetchMyRecentView();
  }
  
  Future<MyRecentViewModal> fetchMyRecentView()async{

    try{
      var token = await GetToken().getToken();
      var response = await http.get(Uri.parse(Urls.recentView),headers: {
        "Content-Type":"application/json",
        "Authorization":"Bearer $token",
      });
      if(response.statusCode==200){
        return MyRecentViewModal.fromJson(json.decode(response.body));
      }else{
        debugPrint(response.body);
      }
    }catch(e){
      debugPrint(e.toString());
    }
    throw Exception("Data is not showing in recent view");
  }
}