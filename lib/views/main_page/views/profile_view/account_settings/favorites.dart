import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../controllers/main_page_controllers/favorite_controller/favorite_controllres.dart';
import '../../../../../controllers/main_page_controllers/'
    'main_page_views_controllers/all_products_controller.dart';
import '../../../../../controllers/shared_products_controller/shared_products.dart';
import '../../../../../modals/wishlist_modals/get_wish_modals.dart';
import '../../../../../utils/app_navigations.dart';
import '../../../../../utils/app_urls.dart';
import '../../../../../widgets/app_button.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/my_app_bar.dart';
import '../../../../../widgets/shimmer_effects.dart';
import '../../single_product_details/product_details_view.dart';
import '../../../main_page.dart';
import '../../home_view/items_view.dart';


class Favorites extends StatelessWidget {
  const Favorites({
    Key? key,
    required this.favoritesItems,
  }) : super(key: key);
  final int favoritesItems;

  @override
  Widget build(BuildContext context) {
    final shareProduct = Get.put(SharedItemsController());
    final favouriteProductId = Get.put(AllProductsController());
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: const AppText(
              text: "Favorites",
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
          body: Column(
            children: [
              GetBuilder<FavoriteController>(
                  init: FavoriteController(),
                  builder: (controller){
                   return  FutureBuilder<List<Docs>>(
                      future:controller.getWishListedProducts(),
                      builder: (context,snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return Expanded(child: const VerticalShimmerEffects());
                        }
                        else if(snapshot.hasData){
                          if(snapshot.data!.isEmpty){
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/fav.png",height: 150,width: 150,),
                                    const SizedBox(height: 20,),
                                    const AppText(
                                      text: "There is no item in the wishList ",
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
                                      btnColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                      textColor: Colors.black,
                                      text: "Explore Products",
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          return Expanded(
                            child: GridView.builder(
                              itemCount: snapshot.data!.length,
                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.75,
                                crossAxisCount: 2,
                              ),
                              itemBuilder: (context, index) {
                                var data = snapshot.data![index];
                                favouriteProductId.favProductId =
                                    snapshot.data![index].sId.toString();
                                return ItemsView(
                                  imageUrl:
                                  "${Urls.productsImageUrl}${data.product!.images!.first}",
                                  prodDesc: data.product!.name.toString(),
                                  prodPrice: "Rs.${data.product!.price}",
                                  ratingsCount:
                                  data.product!.ratingsCount!.toDouble(),
                                  onShare: () async {
                                    String productId = data.sId.toString();
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
                                      await shareProduct.sharedPost(
                                        productId,
                                        userId!,
                                        "${Urls.productsImageUrl}${data.product!.images!.first}",
                                        data.product!.name.toString(),
                                        data.product!.price.toString(),
                                        data.product!.description.toString(),

                                      );
                                    } finally {
                                      Navigator.of(context).pop(); // Close the dialog box
                                    }
                                  },
                                  onTap: () {
                                    AppNavigations.to(context,
                                        nextScreen: ProductDetailsView(
                                          productId:
                                          data.product!.sId.toString(),
                                        ));
                                  },
                                );
                              },
                            ),
                          );
                        }else if(!snapshot.hasData){
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const AppText(
                                    text: "There is no item in the wishList ",
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
                                    btnColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                    textColor: Colors.black,
                                    text: "Explore Products",
                                  )
                                ],
                              ),
                            ),
                          );
                        }else{
                          return const Center();
                        }
                      },
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
