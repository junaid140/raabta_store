import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/modals/product_modals/get_all_products.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/utils/app_urls.dart';
import 'package:markaz_clone/widgets/get_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../modals/product_modals/GetSingleProductModal.dart';


class AllProductsController extends GetxController {
  TextEditingController searchController = TextEditingController();
  String deliveryCharges = "90";
  String favProductId = '';


  var productList = <Docs>[].obs;
  bool isLoading = false;


  setLoading(bool loading){
    isLoading = loading;
    update();
  }
  @override
  void onInit() {
    super.onInit();
    getAllProducts();
    getAllPagesOfProducts();
  }

  // to get all products:

  void getAllProducts()async{
    setLoading(true);
    try{
      setLoading(true);
      update();
      final SharedPreferences pref =await  SharedPreferences.getInstance();
      var token = pref.getString("token");
      var response = await http.get(Uri.parse(Urls.allProductsUrl),
          headers: {
            "Authorization":"Bearer $token",
          }
      );
      if(response.statusCode == 200){
        GetAllProductModal data = GetAllProductModal.fromJson(json.decode(response.body));
        productList.value = data.data!.docs!;
        update();
        setLoading(false);
        update();

      }else{
        debugPrint("Error: ${response.statusCode}");
        setLoading(false);
        update();
      }
    }catch(e){
      debugPrint(" All Product controller  $e");
      setLoading(false);
      update();
    }

  }

  Rx<GetSingleProductModal> singleProduct = GetSingleProductModal().obs ;

  // for the single product details:
  Future<GetSingleProductModal> gettingProductDetails(String productId)async{
    try{
      var response = await http.get(Uri.parse("${Urls.allProductsUrl}/$productId"));
      if(response.statusCode==200){
        return GetSingleProductModal.fromJson(json.decode(response.body));
      }else{
        throw Exception("Failed to load product");
      }
    }catch(e){
      debugPrint(" Single Product controller  $e");
    }
   throw Exception("Error in a getting single product data");
  }

  bool isClicked = false;
  setClicked(bool loading){
    isClicked = loading;
    update();
  }

  var allPagesOfProducts = <Docs>[].obs;

  void getAllPagesOfProducts()async{
    setLoading(true);
    try{
      setLoading(true);
      var token =await GetToken().getToken();
      var response = await http.get(Uri.parse("${Urls.allProductsUrl}?page=1"),
          headers: {
            "Authorization":"Bearer $token",
            "Content-Type":"application/json"
          }
      );
      if(response.statusCode == 200){
        GetAllProductModal data = GetAllProductModal.fromJson(json.decode(response.body));
        allPagesOfProducts.value = data.data!.docs!;
        int pages = data.data!.pages!;
        update();
        setLoading(false);

        for(int i = 2 ; i <=pages;i++){
          var pageResponse = await http.get(
              Uri.parse("${Urls.allProductsUrl}?page=$i"),
              headers: {
                "Authorization":"Bearer $token",
                "Content-Type":"application/json"
              }
          );
          if(pageResponse.statusCode==200){
            var pageData = GetAllProductModal.fromJson(
                json.decode(pageResponse.body));
            allPagesOfProducts.addAll(pageData.data!.docs!);
            update();
            setLoading(false);
          }else {
            debugPrint("Error fetching page $i: ${pageResponse.statusCode}");
            setLoading(false);
          }
        }
      }else{
        debugPrint("Error: ${response.statusCode}");
        setLoading(false);
      }
    }catch(e){
      debugPrint(" All Product controller  $e");
      setLoading(false);
    }
  }
}
