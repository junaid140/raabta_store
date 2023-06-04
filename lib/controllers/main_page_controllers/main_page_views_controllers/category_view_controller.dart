import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/widgets/get_token.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:http/http.dart' as http;
import '../../../modals/categories_modals/get_catagories_modal.dart';
import '../../../modals/categories_modals/get_categories_product_modal.dart';
import '../../../modals/categories_modals/sub_categories_modal.dart';
import '../../../utils/app_urls.dart';

class CategoryViewController extends GetxController {

  int selectedIndex = 0;

  changeIndex(int index) {
    selectedIndex = index;
    update();
  }



  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  int selectedCat = 0;
  bool isLoading = true;
  setLoading(bool loading){
    isLoading = loading;
    update();
  }
  scrollListener() {
    List<int> indices = [];

    itemPositionsListener.itemPositions.addListener(() {
      indices = itemPositionsListener.itemPositions.value.map((e) {
        return e.index;
      }).toList();
      selectedCat = indices.first;
      update();
    });
    update();
  }

  changeCat(int index) {
    selectedCat = index;
    itemScrollController.scrollTo(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
      index: selectedCat,
    );
    update();
  }

  @override
  void onInit() {
    scrollListener();
    getCatagories();
    getSubCategories();
    gettingCategoriesProduct("");
    super.onInit();
  }

  // categories controller
  var catagories = GetAllCatagories().obs;
  void getCatagories()async{
    setLoading(true);
    final token = await GetToken().getToken();
    try{
      setLoading(true);
      var response =await http.get(Uri.parse(Urls.allCatagoriesUrl),
          headers: {
            "Authorization":"Bearer $token",
            "Content-Type":"application/json",
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
    }
    catch(e){
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
            "Content-Type":"application/json",
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
    return subCategories.value.data!.docs!
        .where((subCategory) =>
    subCategory.mainCategory!.sId == categoryId)
        .toList();
  }



  // for the categories product details:
  Future<GetCategoriesProduct> gettingCategoriesProduct(String category)async{
    var token = await GetToken().getToken();
    var response = await http.get(Uri.parse("${Urls.searchUrl}?category=$category"),headers: {
      "Authorization":"Bearer $token",
      "Content-Type": "application/json",
    });
    if(response.statusCode==200){
      return GetCategoriesProduct.fromJson(json.decode(response.body));
    }else{
      debugPrint(response.body);
      throw Exception("Failed to load product");
    }
  }

}

