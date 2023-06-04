import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:markaz_clone/widgets/get_token.dart';
import '../../../../modals/home_modals/text_banner_modal.dart';
import '../../../../utils/app_urls.dart';


class TextBannerController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    getText();
  }
  var textBanner = TextBannerModal().obs;

  void getText()async{
    var token = await GetToken().getToken();
    var response =await http.get(Uri.parse(Urls.textBannerUrl),headers: {
      "Authorization":"Bearer $token"
    });
    if(response.statusCode == 200){
      textBanner.value = TextBannerModal.fromJson(json.decode(response.body));
      print(token);
      update();
    }
    else{
      print("failed to load data ");
    }
  }
}


