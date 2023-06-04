import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/utils/app_urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../controllers/shared_products_controller/shared_products.dart';
import '../../../../../modals/shared_modal/get_shared_modal.dart';
import '../../../../../utils/app_navigations.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/my_app_bar.dart';
import '../../../../../widgets/shimmer_effects.dart';
import '../../single_product_details/product_details_view.dart';
import '../../../main_page.dart';
import '../../home_view/items_view.dart';

class SharedItems extends StatelessWidget {
  const SharedItems({
    Key? key,
    required this.sharedItems,
  }) : super(key: key);
  final int sharedItems;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: const AppText(
              text: "Shared Items",
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            centerTitle: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body:GetBuilder<SharedItemsController>(
            init: SharedItemsController(),
            builder: (controller){
              return FutureBuilder<List<Docs>>(
                future: controller.getSharedItems(),
                builder: (context,snapshot){
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return SizedBox(
                      width: double.infinity,
                      height: Get.height*0.9,
                      child:  const VerticalShimmerEffects(),
                    );
                  } if(snapshot.hasData && snapshot.data!.isNotEmpty && snapshot.data != null){
                    final data = snapshot.data!;
                    return GridView.builder(
                      itemCount: data.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        var product = data[index].product!;
                        return  ItemsView(
                          imageUrl: "${Urls.productsImageUrl}${product.images!.first}",
                          prodDesc: product.name.toString(),
                          prodPrice: "Rs. ${product.price}",
                          ratingsCount: product.ratingsCount!.toDouble(),
                          onTap: (){
                           AppNavigations.to(context, nextScreen: ProductDetailsView(
                             productId: product.sId.toString(),
                           ));
                          },
                          onShare: ()async{
                            String productId = product.sId.toString();
                            var pref = await SharedPreferences.getInstance();
                            var userId = pref.getString("userId");
                            showDialog(
                              context: context,
                              barrierDismissible: true,
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
                              await controller.sharedPost(
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
                    return Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/share.png",width: 150,height: 150,),
                          const SizedBox(height: 20,),
                          const AppText(
                            text: "No shared item's yet",
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          AppButton(
                            onTap: () {
                              AppNavigations.off(
                                context,
                                nextScreen: MainPage(
                                  currentIndex: 2,
                                ),
                              );
                            },
                            borderColor: Colors.grey.withOpacity(0.7),
                            btnColor: Theme.of(context).scaffoldBackgroundColor,
                            textColor: Colors.black,
                            text: "Explore Products",
                          )
                        ],
                      ),
                    );

                },
              );
            },
          ),


        ),
      ),
    );
  }
}
