

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/modals/wishlist_modals/get_wish_modals.dart';
import 'package:http/http.dart' as http;
import '../../../modals/wishlist_modals/add_wishlist_modal.dart';
import '../../../modals/wishlist_modals/remove_wishlist_modal.dart';
import '../../../utils/app_urls.dart';
import '../../../widgets/flutter_toast.dart';
import '../../../widgets/get_token.dart';


class FavoriteController extends GetxController{




  Future<List<Docs>> getWishListedProducts() async {
    try{
      final token = await GetToken().getToken();
      final List<Docs> allWishListedItems = [];

      int page = 1;
      int totalPageCount = 1;

      while(page<=totalPageCount){
        final response = await http.get(Uri.parse("${Urls.wishListUrl}?page=$page"),
            headers: {
              "Authorization":"Bearer $token",
              "Content-Type":"application/json"
            });

        if (response.statusCode == 200) {
          final getWishListProducts = GetWishModals.fromJson(jsonDecode(response.body));
          final wishListProducts = getWishListProducts.data?.docs??[];
          allWishListedItems.addAll(wishListProducts);
          if(totalPageCount==1){
            totalPageCount =  getWishListProducts.data?.pages??1;
          }
        }
        else{
          debugPrint(response.body);
          throw Exception('Failed to load data in wishList get products');
        }
        page++;
      }
      return allWishListedItems;

    }
    catch(e){
      debugPrint(e.toString());
      throw Exception('Failed to load data in getWishListedProducts...');
    }
  }


  @override
  void onInit() {
    super.onInit();
    getWishListedProducts();
  }

  var addWishListItem = RxList<String>();
  var wishListProductIdItem = RxList<String>();

  void addWishListProduct(String userId, String productId) async {
    try {
      var token = await GetToken().getToken();
      var response = await http.post(
        Uri.parse(Urls.wishListUrl),
        body: json.encode({
          "product": productId,
          "user": userId,
        }),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final addWishList = AddWishListModal.fromJson(json.decode(response.body));
        addWishListItem.add(addWishList.data!.doc!.sId!);
        wishListProductIdItem.add(addWishList.data!.doc!.product!);
        ToastMessage.showMessage("Successfully added");
      } else {
        debugPrint(response.body);
      }
      // Check if the product is in the wishlist and update isClicked accordingly
      isClicked = addWishListItem.contains(productId);
      update();
    } catch (e) {
      debugPrint("Error in add wishList $e");
    }
  }


  void removeFromWishList(String productId) async {
    final token = await GetToken().getToken();
    final response = await http.delete(Uri.parse("${Urls.wishListUrl}/$productId"),headers: {
      "Authorization":"Bearer $token",
    });

    final RemoveWishListModal remove = RemoveWishListModal.fromJson(json.decode(response.body));

    if(remove.success== true){
      ToastMessage.showMessage("successfully removed");
    }else{
      debugPrint("failed");
      debugPrint(response.body);
    }
  }
  bool isClicked = false;
  setClicked(bool loading){
    isClicked = loading;
    update();
  }
}