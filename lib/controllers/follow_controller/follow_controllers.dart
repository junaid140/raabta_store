

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/widgets/get_token.dart';

import '../../modals/follow_shops_modal/follow_modals.dart';
import '../../modals/follow_shops_modal/get_followed_shop_modal.dart';
import '../../utils/app_urls.dart';

class FollowController extends GetxController{


  // Click  to follow the shop
   clickToFollow({required String supplierId})async{

    try{
      var token = await GetToken().getToken();
      var response = await http.post(Uri.parse(Urls.followersUrl),headers: {
        "Authorization":"Bearer $token",
        "Content-Type":"application/json",
      },
        body: jsonEncode({
          "supplierId":supplierId
        }),
      );

      if(response.statusCode==200){
        debugPrint("Successfully added");
        return FollowShopModal.fromJson(json.decode(response.body));
      }else{
        debugPrint(response.body);
      }

    }catch(e){
      debugPrint("error in follower function $e");
    }
    return null;
  }

  // here is to get the followed shops:

   Future<List<Docs>> getFollowedShops() async {
     var token = await GetToken().getToken();
     var page = 1;
     var result = <Docs>[];

     while (true) {
       var response = await http.get(
         Uri.parse('${Urls.followersUrl}?page=$page'),
         headers: {
           "Authorization": "Bearer $token",
           "Content-Type": "application/json",
         },
       );

       if (response.statusCode == 200) {
         var data = GetFollowedShopModal.fromJson(json.decode(response.body));
         result.addAll(data.data!.docs!);
         if (page >= data.data!.pages!) {
           break;
         }
         page++;
       } else {
         debugPrint(response.body);
         break;
       }
     }
     return result;
   }



}