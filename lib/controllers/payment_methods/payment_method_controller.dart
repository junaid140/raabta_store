import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../modals/payment_method_modal/pay_meth_modal.dart';
import '../../utils/app_urls.dart';

class PaymentMethodController extends GetxController{


  TextEditingController accountController= TextEditingController();
  int? selectedContainerIndex ;
  bool value = false;
  upDatedIndex(index){
    selectedContainerIndex = index;
    update();
  }
  upDatedBoolValue(newValue){
    value =newValue;
    update();
  }

  Future<GetPaymentMethodsModal?> allPaymentMethods()async{
    try{
      var response = await http.get(Uri.parse(Urls.paymentMethodsUrl),headers: {
        "Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDA3NDQzZmI1Mjc4ODJkNDc3MGFiYmYiLCJpYXQiOjE2ODM4NzY1MjYsImV4cCI6MTY4NDQ4MTMyNn0.EzEkdxrHzUEHhsDa6jfKae_W9oshbkrHb2-WJRpZsD4",
        "Content-Type":"application/json",
      });
      if(response.statusCode==200){
        return GetPaymentMethodsModal.fromJson(json.decode(response.body));
      }
      else{
        throw Exception("error ${response.statusCode}");
      }

    }catch(e){
      debugPrint("Error in the get paymentMethod $e");
    }

    return null;
  }
}