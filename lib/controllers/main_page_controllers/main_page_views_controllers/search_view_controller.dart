import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/modals/search_modals/search_modal.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/utils/app_urls.dart';
import 'package:markaz_clone/widgets/get_token.dart';


class SearchViewController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isSearching = false;
  bool get isSearching => _isSearching;


  setLoading(bool loading, {bool searching = false}) {
    _isLoading = loading;
    _isSearching = searching;
    update();
  }


  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Docs>> searchProducts({required String keyword})async{
    try{
      final token = await GetToken().getToken();
      final List<Docs> allSearchProducts = [];
      int page = 1;
      int totalPages = 1;

      while(page<=totalPages){
        final response = await http.get(
          Uri.parse("${Urls.searchUrl}?keyword=$keyword&page=$page"),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          });
        if(response.statusCode==200){
          final getAllSearchProducts = SearchModal.fromJson(json.decode(response.body));
          final allSearches = getAllSearchProducts.data?.docs??[];
          allSearchProducts.addAll(allSearches);
          if(totalPages==1){
            totalPages = getAllSearchProducts.data?.pages??1;
          }
        }

        else{
          debugPrint(response.body);
          throw Exception('Failed to load data in searchProducts  products');
        }
        page++;
      }
      return allSearchProducts;

    }  catch(e){
      debugPrint(e.toString());
      throw Exception('Failed to load data in searchProducts...');
    }
  }


  Future<List<Docs>> getAllProducts() async {
    try {
      final token = await GetToken().getToken();
      final List<Docs> allProducts = [];
      int page = 1;
      int totalPages = 1;

      while (page <= totalPages) {
        final response = await http.get(
          Uri.parse("${Urls.searchUrl}?page=$page"),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        );

        if (response.statusCode == 200) {
          final getAllProducts =
          SearchModal.fromJson(json.decode(response.body));
          final products = getAllProducts.data?.docs ?? [];
          allProducts.addAll(products);
          if (totalPages == 1) {
            totalPages = getAllProducts.data?.pages ?? 1;
          }
        } else {
          debugPrint(response.body);
          throw Exception('Failed to load data in getAllProducts');
        }
        page++;
      }
      return allProducts;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to load data in getAllProducts...');
    }
  }



}







