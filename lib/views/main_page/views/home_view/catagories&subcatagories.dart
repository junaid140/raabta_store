import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/main_page/views/cart_view/cart_page.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../controllers/main_page_controllers/main_page_views_controllers/category_view_controller.dart';
import '../../../../controllers/shared_products_controller/shared_products.dart';
import '../../../../utils/app_urls.dart';
import '../../../../widgets/app_button.dart';
import '../single_product_details/product_details_view.dart';
import 'items_view.dart';

class CatagoriesAndSubCatagories extends StatelessWidget {
  final String? name;
  final List subCategoriesName;
  const CatagoriesAndSubCatagories({Key? key,
    this.name,
   required this.subCategoriesName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sharePost = Get.put(SharedItemsController());
    return ColoredBox(
       color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: AppText(text: name!.toString()),
            actions:  [
              InkWell(
                  onTap: (){
                    AppNavigations.to(context, nextScreen: const CartScreen());
                  },
                  child:const Icon(Icons.add_shopping_cart,color: AppColors.textColor,)),
            ],
            leading: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: const Icon(Icons.arrow_back_ios_new,color: AppColors.textColor,),),
          ),
          body: GetBuilder<CategoryViewController>(
            init: CategoryViewController(),
            builder: (controller) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        subCategoriesName.length,
                            (index) => Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 6.0),
                          child: RoundButton(
                            btnColor: controller.selectedIndex == index ? null : Colors.white,
                            textColor: controller.selectedIndex == index
                                ? null
                                : AppColors.roundButtonColor,
                            onTap: () {
                              controller.changeIndex(index);
                            },
                            text: subCategoriesName[index].name,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: controller.gettingCategoriesProduct(subCategoriesName[controller.selectedIndex].mainCategory.sId),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasData) {
                          var data = snapshot.data!.data!.docs!;
                          return GridView.builder(
                            itemCount: data.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.75,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, innerIndex) {
                              final product = data[innerIndex];
                              return ItemsView(
                                imageUrl: "${Urls.productsImageUrl}${product.images!.first}",
                                prodDesc: product.name.toString(),
                                prodPrice: "Rs. ${product.price}",
                                ratingsCount: product.ratingsCount!.toDouble(),
                                onTap: () {
                                  AppNavigations.to(
                                    context,
                                    nextScreen: ProductDetailsView(
                                      productId: product.sId.toString(),
                                    ),
                                  );
                                },
                                onShare: () async {
                                  String productId = product.sId.toString();
                                  var pref = await SharedPreferences.getInstance();
                                  var userId = pref.getString("userId");

                                  showDialog(
                                    context: context,
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
                                              SvgPicture.asset("assets/images/rabtastore.svg",width: 45,height: 45,),
                                              SizedBox(height: 10),
                                              AppText(text: 'Wait for a while ...',fontSize: 12,fontWeight: FontWeight.w500,),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  try {
                                    await sharePost.sharedPost(
                                      productId,
                                      userId!,
                                      "${Urls.productsImageUrl}${product.images!.first}",
                                      product.name.toString(),
                                      product.price.toString(),
                                      product.description.toString(),

                                    );
                                  } finally {
                                    Navigator.of(context).pop(); // Close the dialog box
                                  }
                                },
                              );
                            },
                          );
                        }
                        return const Center(child: AppText(text: "Error"));
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
