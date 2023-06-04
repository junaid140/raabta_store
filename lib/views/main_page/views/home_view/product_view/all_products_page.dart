import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../controllers/main_page_controllers/'
    'main_page_views_controllers/all_products_controller.dart';
import '../../../../../controllers/shared_products_controller/shared_products.dart';
import '../../../../../utils/app_urls.dart';
import '../../../../../widgets/shimmer_effects.dart';
import '../../single_product_details/product_details_view.dart';
import '../items_view.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SharedItemsController shareController =
        Get.put(SharedItemsController());
    return GetBuilder<AllProductsController>(
      init: AllProductsController(),
      builder: (controller) {
        return SizedBox(
          width: Get.width,
          child: controller.isLoading
              ? const VerticalShimmerEffects()
              : GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: controller.allPagesOfProducts.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = controller.allPagesOfProducts[index];
                    return ItemsView(
                      onTap: () async {
                        await AppNavigations.to(
                          context,
                          nextScreen: ProductDetailsView(
                            productId: data.sId.toString(),
                          ),
                        );
                      },
                      onShare: () async {
                        String productId = data.sId.toString();
                        var pref = await SharedPreferences.getInstance();
                        var userId = pref.getString("userId");
                        await shareController.shareProduct(
                          productId:productId,
                          userId:userId.toString(),
                          imageUrl:"${Urls.productsImageUrl}${data.images!.first}",
                          productName:data.name.toString(),
                          productPrice:data.price.toString(),
                          productDescription: data.description.toString(),
                        );
                      },
                      imageUrl: "${Urls.productsImageUrl}${data.images!.first}",
                      prodDesc: data.name.toString(),
                      prodPrice: "Rs.${data.price}",
                      ratingsCount: data.ratingsCount!.toDouble(),
                    );
                  },
                ),
        );
      },
    );
  }
}
