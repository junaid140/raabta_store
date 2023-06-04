import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:markaz_clone/modals/shared_modal/post_items.dart';
import 'package:markaz_clone/widgets/flutter_toast.dart';
import 'package:markaz_clone/widgets/get_token.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../constants/app_colors.dart';
import '../../modals/shared_modal/get_shared_modal.dart';
import '../../utils/app_urls.dart';
import 'package:flutter/services.dart';
import '../../widgets/app_text.dart';


class SharedItemsController extends GetxController{

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  setLoading(bool value) {
    _isLoading = value;
    update();
  }

  // to share the product to any social media account:

  Future<void> sharedPost(String productID, String userID,String urls,name,price,desc)async{
    setLoading(true);
    try{
      setLoading(true);
      final directory = await getTemporaryDirectory();
      final file = File("${directory.path}/images.jpg");
      final bytes = await http.get(Uri.parse(urls));
      await file.writeAsBytes(bytes.bodyBytes);
      final shareFiles = [file.path];
      await Share.shareFiles(shareFiles,
          text: 'Here is the details of a product! \nName:$name, Price:Rs.$price, Descriptions:$desc',
          mimeTypes: ['image/jpeg', 'image/png','image/jpg']);

      final token = await GetToken().getToken();
      final response = await http.post(Uri.parse(Urls.sharesUrl),headers: {
        "Authorization":"Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body: jsonEncode(<String,String>{
          'product':productID,
          'user':userID,
        }),
      );
      PostSharedItemModal postResponse =
      PostSharedItemModal.fromJson(json.decode(response.body));
      if(postResponse.success!){
        debugPrint("Success ${postResponse.data!.message!}");
        setLoading(false);
      }else{
        debugPrint("Failed ${postResponse.data!.message!}");
        setLoading(false);
      }

    }catch(e){
      setLoading(false);
      debugPrint(e.toString());
    } finally{
      setLoading(false);
    }

  }

  // save the images to the gallery
Future<void> downloadImage(String imageUrl)async{
    try{
      final response = await http.get(Uri.parse(imageUrl));
      final bytes = response.bodyBytes;
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/myImages.jpg';
      final File imageFile = File(imagePath);
      await imageFile.writeAsBytes(bytes);
       final savedImage =  await ImageGallerySaver.saveFile(imagePath);
       if(savedImage!=null){
         ToastMessage.showMessage("Image saved to gallery!");
       }
    }catch(e){
      ToastMessage.showMessage("Error saving image. Please try again!");
    }

}



// copy product details into your clipboard
Future<void> copyToClipBoard(String productDetails)async{
    await Clipboard.setData(ClipboardData(text: productDetails));
    ToastMessage.showMessage("Product details copy to clipboard!");
}



// get shared items here :

  Future<List<Docs>> getSharedItems() async {
    try {
      final token = await GetToken().getToken();
      final List<Docs> allSharedItems = [];

      int page = 1;
      int totalPageCount = 1;

      while (page <= totalPageCount) {
        final response = await http.get(Uri.parse('${Urls.sharesUrl}?page=$page'), headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        });

        if (response.statusCode == 200) {
          final getSharedItemModal = GetSharedItemModal.fromJson(json.decode(response.body));
          final sharedItems = getSharedItemModal.data?.docs ?? [];
          allSharedItems.addAll(sharedItems);

          if (totalPageCount == 1) {
            totalPageCount = getSharedItemModal.data?.pages ?? 1;
          }
        }
        else {
          debugPrint(response.body);
          throw Exception('Failed to load data');
        }

        page++;
      }

      return allSharedItems;
    } catch (e) {
      debugPrint(e.toString());
      throw Exception('Failed to load data in get shared items..');
    }
  }

  Future<void> shareProduct(
      {required String productId,
        required String userId,
        required  String imageUrl,
        required String productName,
        required String productPrice,
        required String productDescription}) async {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          content: Container(
            width: 40,
            height: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/rabtastore.svg", width: 45, height: 45),
                SizedBox(height: 10),
                AppText(text: 'Wait for a while...', fontSize: 12, fontWeight: FontWeight.w500),
              ],
            ),
          ),
        );
      },
    );

    try {
      await sharedPost(
        productId,
        userId,
        "${Urls.productsImageUrl}$imageUrl",
        productName,
        productPrice,
        productDescription,
      );
    } finally {
      Get.back(); // Close the dialog box
    }
  }



}