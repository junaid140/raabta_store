import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/widgets/flutter_toast.dart';
import '../../modals/order_modals/create_order_modal.dart';
import '../../utils/app_urls.dart';
import '../../widgets/get_token.dart';

class ProductDetailsViewController extends GetxController {
  TextEditingController profitController = TextEditingController();


  int add = 1;

  addMore() {
    add++;
    update();
  }

  subtractLess() {
    if (add > 1) {
      add--;
    }
    update();
  }
  bool isLoading = true;
  setLoading(bool loading){
    isLoading = loading;
    update();
  }

  // for single product to be ordered
  Future<CreateOrderModal?> createOrder(
      String shippingAddressId,
      String deliveryFee,
      String productId,
      String qty,
      String unitPrice,
      String userProfit,
      String productOwnerId) async {
    var token = await GetToken().getToken();
    List<Map<String, String>> products = [
      {
        "product": productId,
        "qty": qty,
        "unitPrice": unitPrice,
        "userProfit": userProfit,
        "productOwner": productOwnerId,
      }
    ];
    if (products.isEmpty) {
      debugPrint("Error: order must have at least one item");
      return null;
    }
    var response = await http.post(Uri.parse(Urls.allOrdersUrl),
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "application/json"
        },
        body: json.encode({
          "shippingAddress": shippingAddressId,
          "deliveryFee": deliveryFee,
          "products": products,
        }));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      return CreateOrderModal.fromJson(json.decode(response.body));
    } else {
      debugPrint(response.body);
      return null;
    }
  }


  // for multiple product to be ordered
  Future<CreateOrderModal?> createCartOrder(
      String shippingAddressId,
      String deliveryFee,
      List<Map<String, String?>> products,
      ) async {
    var token = await GetToken().getToken();

    if (products.isEmpty) {
      ToastMessage.showMessage("Order must have at least one item");
      return null;
    }

    var response = await http.post(
      Uri.parse(Urls.allOrdersUrl),
      headers: {
        "Authorization": "Bearer $token",
        "content-type": "application/json"
      },
      body: json.encode({
        "shippingAddress": shippingAddressId,
        "deliveryFee": deliveryFee,
        "products": products,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint(response.body);
      return CreateOrderModal.fromJson(json.decode(response.body));
    } else {
      debugPrint(response.body);
      return null;
    }
  }


}
