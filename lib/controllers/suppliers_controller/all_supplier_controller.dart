import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/modals/supplier_modal/get_supplier_products_modal.dart';
import '../../modals/supplier_modal/single_supplier_modal.dart';
import '../../utils/app_urls.dart';

class SupplierController extends GetxController {

  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
    fetchSupplierProducts();
  }

  int selectedIndex = 0;
  changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  String tokenSupplier = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDJhN2RlODQ1N2YzNDM1MDYxNDg2ZTAiLCJpYXQiOjE2ODQ3MzE1NjAsImV4cCI6MTY4NTMzNjM2MH0.05ngxqUzIFoOQvvvi989ERklPy54OwusrE15HLTQDjY";
  Future<GetSingleSupplier> fetchData()async{
    try{
      final response = await http.get(Uri.parse(Urls.singleSupplier),headers: {
        "Authorization":"Bearer $tokenSupplier",
        "Content-Type":"application/json",
      });

      if(response.statusCode == 200){
        return GetSingleSupplier.fromJson(json.decode(response.body));

      }else{
       return  throw Exception("Error : GetSingleSupplier");
      }
    }catch(e){
      debugPrint(e.toString());
    }
    throw Exception("Error : GetSingleSupplier");
  }


  var supplierProduct = <Docs>[].obs;


  Future<GetSupplierProducts> fetchSupplierProducts()async{
    try{
      var response = await http.get(Uri.parse(Urls.supplierProducts),headers: {
        "Authorization":"Bearer $tokenSupplier",
        "Content-Type":"application/json",
      });
      if(response.statusCode==200){
        return GetSupplierProducts.fromJson(json.decode(response.body));
      }else{
        debugPrint(response.body);
        return throw Exception("Error loading fetchSupplierProducts");
      }
    }catch(e){
      debugPrint(e.toString());
    }
    throw Exception("Error in function fetchSupplierProducts");
  }

}
