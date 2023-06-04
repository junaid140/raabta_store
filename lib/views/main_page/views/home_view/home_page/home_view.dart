import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_constants.dart';
import 'package:markaz_clone/controllers/main_page_controllers/'
    'main_page_views_controllers/home_page_controllers/home_controller.dart';
import 'package:markaz_clone/controllers/main_page_controllers/'
    'main_page_views_controllers/all_products_controller.dart';
import 'package:markaz_clone/views/main_page/main_page.dart';
import 'package:markaz_clone/views/main_page/views/home_view/items_view.dart';
import 'package:markaz_clone/widgets/app_cache_image.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/views/main_page/views/single_product_details/'
    'product_details_view.dart';
import 'package:marquee/marquee.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../controllers/main_page_controllers/main_page_views_controllers/'
    'category_view_controller.dart';
import '../../../../../controllers/main_page_controllers/'
    'main_page_views_controllers/home_page_controllers/text_banner_controller.dart';
import '../../../../../controllers/recent_view_controllers/my_recent_view_controller.dart';
import '../../../../../controllers/shared_products_controller/shared_products.dart';
import '../../../../../modals/recents_view_modals/my_recents_view_modal.dart';
import '../../../../../utils/app_navigations.dart';
import '../../../../../utils/app_urls.dart';
import '../../../../../widgets/image_loader.dart';
import '../../../../../widgets/shimmer_effects.dart';
import '../catagories&subcatagories.dart';
import '../product_view/all_products_page.dart';
import 'get_categories_products.dart';


class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final SharedItemsController shareController = Get.put(SharedItemsController());
    final MyRecentViewController recentView = Get.put(MyRecentViewController());
    return SingleChildScrollView(
      child: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<TextBannerController>(
                  init: TextBannerController(),
                  builder: (controller) {
                    if (controller.textBanner.value.data != null) {
                      return Container(
                        height: 40,
                        width: width,
                        decoration: const BoxDecoration(
                          color: Color(0xff01bc87),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Marquee(
                              text: controller
                                  .textBanner.value.data!.doc!.text
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              velocity: 40.0,
                              pauseAfterRound:
                              const Duration(seconds: 1),
                              accelerationDuration:
                              const Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration:
                              const Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 40,
                          width: width,
                          margin:
                          const EdgeInsets.only(left: 2, right: 2),
                          decoration: const BoxDecoration(
                            color: Color(0xff01bc87),
                          ),
                        ),
                      );
                    }
                  },
                ),
                FutureBuilder(
                    future: _.fetchBanners(),
                    builder: (context, snapshot) {
                      var data = snapshot.data;
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return SizedBox(
                          height: 250,
                          width: width,
                          child: Stack(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: PageView.builder(
                                  allowImplicitScrolling: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 2,
                                  controller: _.pageController,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      AppConstants.dummyImage,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: SmoothPageIndicator(
                                  controller: _.pageController,
                                  count: 2,
                                  effect: const SlideEffect(
                                    activeDotColor: Colors.grey,
                                    radius: 2,
                                    dotHeight: 5,
                                    dotWidth: 15,
                                    paintStyle: PaintingStyle.fill,
                                    dotColor: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasData) {
                        Timer.periodic(const Duration(seconds: 2), (timer) {
                          final nextPage =
                              (_.pageController.page ?? 0) + 1;
                          if (nextPage == data?.length) {
                            _.pageController.jumpToPage(0);
                          } else {
                            _.pageController.nextPage(
                                duration:
                                const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }
                        });
                        return SizedBox(
                          height: 250,
                          width: width,
                          child: Stack(
                            children: [
                              PageView.builder(
                                allowImplicitScrolling: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: data?.length,
                                controller: _.pageController,
                                itemBuilder: (context, index) {
                                  return ImageLoader(
                                    imageUrl: "${Urls.bannerImageUrl}${data?[index].image}",
                                  );
                                },
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: SmoothPageIndicator(
                                  controller: _.pageController,
                                  count: data!.length,
                                  effect: const SlideEffect(
                                    activeDotColor:
                                    AppColors.primaryColor,
                                    radius: 2,
                                    dotHeight: 5,
                                    dotWidth: 15,
                                    paintStyle: PaintingStyle.fill,
                                    dotColor: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const Center();
                    }),
                const SizedBox(
                  height: 15,
                ),
                CatWidget(
                  text: "Top Category",
                  trailingText: "See all",
                  onSeeAll: () {
                    AppNavigations.off(
                      context,
                      nextScreen: MainPage(
                        currentIndex: 1,
                      ),
                    );
                  },
                  icon: const SizedBox(),
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<CategoryViewController>(
                    init: CategoryViewController(),
                    builder: (cat){
                      var catagories = cat.catagories.value.data?.docs!;
                      return SizedBox(
                        width: Get.width,
                        height: 100,
                        child:cat.isLoading?
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 6,
                            itemBuilder: (context, index) {
                              return Container(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                margin: EdgeInsets.only(
                                  right: index == 5 ? 15 : 0,
                                ),
                                width: 85,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                        Border.all(width: 1.3, color: Colors.grey),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Container(
                                        width: 50,
                                        height: 10,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ):
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: catagories?.length,
                            itemBuilder: (context , index){
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children:  [
                                      const SizedBox(width: 10),
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: index == 6 ? 15 : 0,
                                        ),
                                        width: 85,
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap:(){
                                                var subCatagories =
                                                cat.getSubCategoriesByCategoryId(
                                                    cat.catagories.value.data!.docs![index].sId!);
                                                AppNavigations.to(context,
                                                    nextScreen:  CatagoriesAndSubCatagories(
                                                      name: catagories[index].name!.toString(),
                                                      subCategoriesName: subCatagories,
                                                    )
                                                );
                                              },
                                              child: Container(
                                                height: 70,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 1.3, color: Colors.grey),
                                                ),
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(8),
                                                    child: ImageLoader(imageUrl: "${Urls.categoriesImageUrl}${catagories![index].image!}",)),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 45,
                                              child: Center(
                                                child: AppText(
                                                  text: catagories[index].name!.toString(),
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]

                                ),
                              );
                            }),
                      );
                    }),
                const SizedBox(
                  height: 15,
                ),
                CatWidget(
                  text: "All Categories & there products",
                  trailingText: "",
                  icon: const SizedBox.shrink(),
                ),
                CategoryList(),
                const SizedBox(
                  height: 15,
                ),
                // const Padding(
                //   padding: EdgeInsets.only(left: 10.0),
                //   child: AppText(text: "Recent View ",fontSize: 18,fontWeight: FontWeight.w500,),
                // ),
                // FutureBuilder<MyRecentViewModal>(
                //     future: recentView.fetchMyRecentView(),
                //     builder: (context,snapshot){
                //       if(snapshot.connectionState==ConnectionState.waiting){
                //         return HorizontalShimmerEffect();
                //       }else if(snapshot.hasData && snapshot.data!.data != null && snapshot.data!.data!.docs != null){
                //         var data = snapshot.data?.data?.docs!;
                //         return SizedBox(
                //           width: double.infinity,
                //           height: 260,
                //           child: ListView.builder(
                //               shrinkWrap: true,
                //               itemCount: data?.length,
                //               scrollDirection: Axis.horizontal,
                //               itemBuilder: (context , index){
                //                 var productData = data![index].product!;
                //                 return SizedBox(
                //                   width: 210,
                //                   child: ItemsView(
                //                       shareIcon:const Icon(
                //                         Icons.share_outlined,
                //                       ),
                //                       onTap: ()async{
                //                         await AppNavigations.to(
                //                           context,
                //                           nextScreen:
                //                           ProductDetailsView(
                //                             productId:
                //                             productData.sId.toString(),
                //                           ),
                //                         );
                //                       },
                //                       onShare:() async {
                //
                //                         String productId = productData.sId.toString();
                //                         var pref = await SharedPreferences.getInstance();
                //                         var userId = pref.getString("userId");
                //                         showDialog(
                //                           context: context,
                //                           barrierDismissible: false,
                //                           builder: (BuildContext context) {
                //                             return AlertDialog(
                //                               elevation: 0,
                //                               backgroundColor: AppColors.primaryColor,
                //                               shape: RoundedRectangleBorder(
                //                                 borderRadius: BorderRadius.only(
                //                                   bottomRight: Radius.circular(40),
                //                                   topLeft: Radius.circular(40),
                //                                   topRight: Radius.circular(5),
                //                                   bottomLeft: Radius.circular(5),
                //                                 ),
                //                               ),
                //                               content: Container(
                //                                 width: 40,
                //                                 height: 90,
                //                                 child: Column(
                //                                   mainAxisAlignment: MainAxisAlignment.center,
                //                                   crossAxisAlignment: CrossAxisAlignment.center,
                //                                   children: [
                //                                     SvgPicture.asset("assets/images/rabtastore.svg",width: 45,height: 45,),
                //                                     SizedBox(height: 10),
                //                                     AppText(text: 'Wait for a while ...',fontSize: 12,fontWeight: FontWeight.w500,),
                //                                   ],
                //                                 ),
                //                               ),
                //                             );
                //                           },
                //                         );
                //
                //                         try {
                //                           await shareController.sharedPost(
                //                             productId,
                //                             userId!,
                //                             "${Urls.productsImageUrl}${productData.images!.first}",
                //                             productData.name.toString(),
                //                             productData.price.toString(),
                //                             productData.description.toString(),
                //
                //                           );
                //                         } finally {
                //                           Navigator.of(context).pop(); // Close the dialog box
                //                         }
                //
                //                       },
                //                       imageUrl: "${Urls.productsImageUrl}${data[index].product?.images?.first}",
                //                       prodDesc: data[index].product!.name.toString(),
                //                       prodPrice: data[index].product!.price.toString()),
                //                 );
                //               }),
                //         );
                //       }
                //       return const Center();
                //     }),
                // const SizedBox(
                //   height: 15,
                // ),
                CatWidget(
                  text: "All Products",
                  trailingText: "",
                  icon: const SizedBox.shrink(),
                ),
                AllProductsView(),
                const SizedBox(
                  height: 15,
                ),

              ],
            );
          }),
    );
  }
}

class ProductCategory extends StatelessWidget {
  final String prodDesc, prodPrice, prodCollec;
  final bool inCollection;
  final double rating;
  final VoidCallback? onShare;
  final bool isRatingAvailable;

  const ProductCategory({
    super.key,
    required this.prodCollec,
    required this.prodDesc,
    required this.prodPrice,
    this.isRatingAvailable = false,
    this.rating = 4.0,
    this.inCollection = true,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllProductsController>(
        init: AllProductsController(),
        builder: (controller) {
          return SizedBox(
            width: 300,
            height: 400,
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.productList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      AppNavigations.to(
                        context,
                        nextScreen: ProductDetailsView(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.37,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.37,
                            child: AppCacheImage(
                              imageUrl: controller
                                  .productList[index].images!.first
                                  .toString(),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              !inCollection
                                  ? const SizedBox()
                                  : AppText(
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      text: prodCollec,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: AppText(
                                  textAlign: TextAlign.start,
                                  maxLines: 2,
                                  text: prodDesc,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              AppText(
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                text: "Rs.$prodPrice",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.priceTagColor,
                              ),
                              SizedBox(
                                height: 40,
                                child: Stack(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    isRatingAvailable
                                        ? Row(
                                            children: [
                                              const Icon(
                                                Icons.star_rate_rounded,
                                                color: Colors.amber,
                                              ),
                                              AppText(
                                                text: rating.toString(),
                                                fontSize: 8,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: onShare,
                                        child: const Icon(
                                          Icons.share_outlined,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        });
  }
}

class CatWidget extends StatelessWidget {
  final VoidCallback? onShare, onSeeAll;
  final String text, trailingText;
  final Widget? icon;

  const CatWidget({
    super.key,
    this.onShare,
    this.icon,
    required this.text,
    required this.trailingText,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: onSeeAll,
                child: AppText(
                  text: text,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              icon ??
                  InkWell(
                    onTap: onShare,
                    child: const Icon(Icons.share_outlined),
                  ),
            ],
          ),
          InkWell(
            onTap: onSeeAll,
            child: AppText(
              text: trailingText,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
