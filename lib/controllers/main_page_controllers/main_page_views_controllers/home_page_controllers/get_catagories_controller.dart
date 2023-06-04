import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/modals/categories_modals/get_catagories_modal.dart';
import 'package:markaz_clone/widgets/flutter_toast.dart';
import '../../../../modals/categories_modals/get_categories_product_modal.dart';
import '../../../../modals/categories_modals/sub_categories_modal.dart';
import '../../../../utils/app_urls.dart';
import '../../../../widgets/get_token.dart';

class GetAllCatagoriesController extends GetxController{


  @override
  void onInit() {
    super.onInit();
    getCatagories();
    getSubCategoriesByCategoryId;
    gettingCategoriesProduct;
  }
  bool isLoading = true;
  setLoading(bool loading){
    isLoading = loading;
    update();
  }




  var catagories = GetAllCatagories().obs;
  void getCatagories()async{
    setLoading(true);
    final token = await GetToken().getToken();
    try{
      setLoading(true);
      var response =await http.get(Uri.parse(Urls.allCatagoriesUrl),
          headers: {
            "Authorization":"Bearer $token",
            "Content-Type":"application/json"
          }
      );
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        catagories.value = GetAllCatagories.fromJson(data);
        update();
        setLoading(false);
      } else{
        debugPrint("Error${response.statusCode}");
        setLoading(false);
      }
    }catch(e){
      debugPrint(e.toString());
      setLoading(false);
    }

  }

  // sub-categories controller
  var subCategories = SubCatagoriesModal().obs;
  void getSubCategories()async{
    setLoading(true);
    final token = await GetToken().getToken();
    try{
      setLoading(true);
      var response = await http.get(Uri.parse(Urls.subCategoriesUrl),
          headers: {
            "Authorization":"Bearer $token",
          }
      );
      if(response.statusCode==200){
        subCategories.value = SubCatagoriesModal.fromJson(json.decode(response.body));
        setLoading(false);
        update();
      }else{
        debugPrint("Error : ${response.statusCode}");
        setLoading(false);
      }
    }catch(e){
      debugPrint(e.toString());
      setLoading(false);
    }

  }


  // showing data when the ID of categories == Id of sub-categories mainItem.
  List getSubCategoriesByCategoryId(String categoryId) {
    return subCategories.value.data?.docs
        ?.where((subCategory) =>
    subCategory.mainCategory?.sId == categoryId)
        .toList() ?? [];
  }

  // get categories products:

  Rx<GetCategoriesProduct> productList = GetCategoriesProduct().obs ;

  // for the single product details:
  Future<GetCategoriesProduct> gettingCategoriesProduct(String category)async{
    try{
      var token = await GetToken().getToken();
      var response = await http.get(Uri.parse("${Urls.searchUrl}?category=$category"),headers: {
        "Authorization":"Bearer $token",
        "Content-Type": "application/json",
      });
      if(response.statusCode==200){
        return GetCategoriesProduct.fromJson(json.decode(response.body));
      }else{
        debugPrint(response.body);
        throw Exception("Failed to load  categories product");
      }
    }catch(e){
      ToastMessage.showMessage("$e");
    }
    throw Exception("Failed to load  categories product");
  }
}