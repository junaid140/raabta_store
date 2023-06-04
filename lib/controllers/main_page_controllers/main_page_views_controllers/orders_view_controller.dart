import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/widgets/get_token.dart';
import '../../../modals/order_modals/get_my_orders_modal.dart';

class OrdersViewController extends GetxController {
  List<String> btnsText = ["In-Progress", "Delivered", "Returned"];
  int selectedIndex = 0;

  changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  // get ordersList
   bool _isLoading = true;
  bool get isLoading => _isLoading;
  setLoading(bool loading){
    _isLoading = loading;
  }

Future<List<Docs>> getMyOrders()async{
    try{
      final token = await GetToken().getToken();
      final List<Docs> allOrderedProducts = [];
      int page = 1;
      int totalPage = 1;

      while(page<=totalPage){
        final response = await http.get(
          Uri.parse('${Urls.myOrdersUrl}?page=$page'),
          headers: {
            "Authorization": "Bearer $token",
          "Content-Type":"application/json",
          });
        if(response.statusCode==200){
          final getOrderedProducts = GetMyOrdersModal.fromJson(json.decode(response.body));
          final orderedProducts = getOrderedProducts.data?.docs??[];
          allOrderedProducts.addAll(orderedProducts);

          if(totalPage==1){
            totalPage = getOrderedProducts.data?.pages??1;
          }
        }
        else {
          debugPrint(response.body);
          throw Exception('Failed to load data in get orders');
        }
           page++;
      }
      return allOrderedProducts;
    }
    catch(e){
      debugPrint(e.toString());
      throw Exception('Failed to load data in getMyOrders...');
    }
}


}
