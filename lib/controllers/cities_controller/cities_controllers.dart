import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../modals/cities_modal/cities_modals.dart';
import '../../utils/app_urls.dart';
import '../../widgets/get_token.dart';

class GetAllCities extends GetxController {
  Future<GetAllCitiesModal?> getCities() async {
    try {
      var token = await GetToken().getToken();

      var response = await http.get(Uri.parse(Urls.allCities), headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      });
      if (response.statusCode == 200) {
        debugPrint("Done");
        return GetAllCitiesModal.fromJson(json.decode(response.body));
      } else {
        debugPrint("fail");
      }
    } catch (e) {
      debugPrint(" all cities error :$e");
    }
    return null;
  }
}
