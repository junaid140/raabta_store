import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_constants.dart';
import 'package:markaz_clone/views/main_page/views/single_product_details/products_images.dart';
import 'package:markaz_clone/views/single_shop_view.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/image_loader.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:markaz_clone/widgets/product_ratings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../controllers/main_page_controllers/favorite_controller/favorite_controllres.dart';
import '../../../../controllers/main_page_controllers/main_page_views_controllers/all_products_controller.dart';
import '../../../../controllers/main_page_controllers/main_page_views_controllers/home_page_controllers/get_catagories_controller.dart';
import '../../../../controllers/shared_products_controller/shared_products.dart';
import '../../../../controllers/suppliers_controller/all_supplier_controller.dart';
import '../../../../modals/categories_modals/get_categories_product_modal.dart';
import '../../../../modals/supplier_modal/get_supplier_products_modal.dart';
import '../../../../utils/app_navigations.dart';
import '../../../../utils/app_urls.dart';
import '../cart_view/cart_manager.dart';
import '../cart_view/cart_page.dart';
import '../home_view/home_page/home_view.dart';
import '../home_view/items_view.dart';
import '../set_product_rate_view/set_price_page.dart';
import '../../../../widgets/flutter_toast.dart';

class ProductDetailsView extends StatelessWidget {
  final bool isRatingAvailable;
  final String productId;

  ProductDetailsView({
    Key? key,
     this.productId ='',
    this.isRatingAvailable = true,
  }) : super(key: key);

  final PageController _pageController = PageController();

  final cartRep = CartRep(prefs: SharedPreferences.getInstance());
  final AllProductsController controller = Get.put(AllProductsController());
  final FavoriteController wishListController = Get.put(FavoriteController());
  final SupplierController supplierController = Get.put(SupplierController());
  final SharedItemsController shareController = Get.put(SharedItemsController());
  final GetAllCatagoriesController similarCategoriesProducts = Get.put(GetAllCatagoriesController());

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            actions: [
              InkWell(
                  onTap: (){
                    AppNavigations.to(context, nextScreen: const CartScreen());
                  },
                  child:const Icon(Icons.add_shopping_cart,color: AppColors.textColor,)),
            ],
          ),
          body: FutureBuilder(
            future: controller.gettingProductDetails(productId),
            builder: (context,snapshot){
              var data = snapshot.data?.data?.doc;
              if(snapshot.connectionState== ConnectionState.waiting){
                return  const Center(child: SizedBox(
                  width: 100,
                  height: 100,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballBeat,
                    strokeWidth: 1,
                    colors: [
                      Colors.green,
                      AppColors.primaryColor,
                      AppColors.black,
                    ],),
                ),);
              }
              if(snapshot.hasData){
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5,),
                            SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black12,
                                    ),
                                    child: PageView.builder(
                                      controller: _pageController,
                                      itemCount: data?.images?.length??0,
                                      itemBuilder: (context, index) {
                                        return  InkWell(
                                          onTap: (){
                                            AppNavigations.to(context, nextScreen: ProductsImages(
                                              images: data.images!,
                                            ));
                                          },
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: ImageLoader(imageUrl: "${Urls.productsImageUrl}${data!.images![index]}",))
                                        );
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      height: 20,
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                        bottom: 10,
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                        Theme.of(context).scaffoldBackgroundColor,
                                      ),
                                      child: SmoothPageIndicator(
                                        effect: const SlideEffect(
                                          activeDotColor: AppColors.roundButtonColor,
                                          dotHeight: 8,
                                          dotWidth: 8,
                                          dotColor:
                                          Color.fromARGB(255, 206, 206, 206),
                                        ),
                                        controller: _pageController,
                                        count: data?.images?.length??0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: AppText(
                                    text: data!.name.toString(),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      const SizedBox(width: 20,),
                                      InkWell(
                                          onTap: () async {
                                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                                            var userId = prefs.getString("userId");
                                            var productId = data.sId.toString();
                                            if (wishListController.isClicked) {
                                              wishListController.removeFromWishList(productId);
                                            } else {
                                              wishListController.addWishListProduct("$userId", productId);
                                            }
                                          },
                                          child: Icon(
                                            wishListController.isClicked
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                          ),
                                        ),

                                      GetBuilder<SharedItemsController>(
                                          init: SharedItemsController(),
                                          builder: (_){
                                            return Align(
                                              alignment: Alignment
                                                  .bottomRight,
                                              child: InkWell(
                                                onTap: () async{
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
                                                      await shareController.sharedPost(
                                                        productId,
                                                        userId!,
                                                        "${Urls.productsImageUrl}${data.images!.first}",
                                                        data.name.toString(),
                                                        data.price.toString(),
                                                        data.description.toString(),

                                                      );
                                                    } finally {
                                                      Navigator.of(context).pop(); // Close the dialog box
                                                    }
                                                },
                                                child: const Icon(
                                                  Icons
                                                      .share_outlined,
                                                ),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const AppText(
                              text: "Delivery in 3-5 days",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                                text: TextSpan(
                              text: "Discount: ",
                                  style: TextStyle(color: AppColors.black,fontWeight: FontWeight.w600,fontSize: 16),
                                  children: [
                                    TextSpan(
                                      text: data.discount!=null?data.discount.toString():"",
                                      style: TextStyle(
                                          decoration: TextDecoration.lineThrough,
                                        color: AppColors.orderTextColor,
                                        fontWeight: FontWeight.w400,
                                      )
                                    ),
                                  ]
                            ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.car_repair_outlined,
                                  color: AppColors.priceTagColor,
                                ),
                                AppText(
                                  text: "Delivery Rs.${controller.deliveryCharges}",
                                  color: AppColors.priceTagColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            isRatingAvailable
                                ? Column(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  AppText(
                                                    text: data.ratingsCount.toString(),
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  const AppText(
                                                    text: "/5",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const AppText(
                                                text: "Overall Rating",
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              ProductRatings(
                                                itemSize: 30,
                                                initialRating: data.ratingsCount!.toDouble(),
                                                ignoreGesture: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Expanded(
                                      //   child: Column(
                                      //     crossAxisAlignment:
                                      //     CrossAxisAlignment.start,
                                      //     mainAxisAlignment:
                                      //     MainAxisAlignment.spaceBetween,
                                      //     children: List.generate(
                                      //       3,
                                      //           (index) {
                                      //         return Row(
                                      //           crossAxisAlignment:
                                      //           CrossAxisAlignment.start,
                                      //           mainAxisAlignment:
                                      //           MainAxisAlignment
                                      //               .spaceBetween,
                                      //           children: [
                                      //             Column(
                                      //               crossAxisAlignment:
                                      //               CrossAxisAlignment
                                      //                   .start,
                                      //               children: [
                                      //                 AppText(
                                      //                   text: index == 0
                                      //                       ? "Delivery Time"
                                      //                       : index == 1
                                      //                       ? "Price"
                                      //                       : "Quality",
                                      //                   fontSize: 10,
                                      //                   color: Colors.grey,
                                      //                 ),
                                      //                 const SizedBox(
                                      //                   height: 5,
                                      //                 ),
                                      //                 ProductRatings(
                                      //                   initialRating: data.ratingsAvg.toDouble(),
                                      //                   itemSize: 10,
                                      //                   ignoreGesture: true,
                                      //                 ),
                                      //               ],
                                      //             ),
                                      //             AppText(
                                      //               text: data.ratingsAvg.toString(),
                                      //               fontWeight: FontWeight.w500,
                                      //               fontSize: 12,
                                      //             ),
                                      //           ],
                                      //         );
                                      //       },
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                                : const SizedBox.shrink(),
                            const AppText(
                              text: "Product description",
                              fontWeight: FontWeight.w500,
                            ),
                            AppText(
                              text: data.description.toString(),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            GetBuilder<SharedItemsController>(
                                init: SharedItemsController(),
                                builder: (con) {
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    horizontalTitleGap: 0,
                                    onTap: () {
                                      con.copyToClipBoard(
                                          "Name: ${data.name}, "
                                              "Description: ${data.description}, "
                                              "Price: ${data.price}"
                                      );
                                    },
                                    leading: const Icon(
                                      Icons.copy,
                                      color: AppColors.primaryColor,
                                    ),
                                    title: const AppText(
                                      text: "Copy product details",
                                      color: AppColors.primaryColor,
                                    ),
                                  );
                                }
                            ),
                            GetBuilder<SharedItemsController>(
                                init: SharedItemsController(),
                                builder: (_){
                                  return ListTile(
                                    horizontalTitleGap: 0,
                                    contentPadding: EdgeInsets.zero,
                                    onTap: ()async {
                                      if (data.images != null) {
                                        List<String> imageFileNames = data.images!;
                                        for (int i = 0; i < imageFileNames.length; i++) {
                                          try {
                                            await _.downloadImage('${Urls.productsImageUrl}${imageFileNames[i]}');
                                          } catch (e) {
                                            ToastMessage.showMessage("Error saving image. Please try again!");
                                          }
                                        }
                                      }
                                    },

                                    leading: const Icon(
                                      Icons.download,
                                      color: AppColors.primaryColor,
                                    ),
                                    title: const AppText(
                                      text: "Download",
                                      color: AppColors.primaryColor,
                                    ),
                                  );
                                }),

                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 0,
                              onTap: () {
                                AppNavigations.to(
                                  context,
                                  nextScreen: SingleShopView(
                                    followers: 120,
                                    rating: 5,
                                    shopName: "${data.owner!.firstName!} ${data.owner!.lastName!}",
                                    totalProducts: 120,
                                  ),
                                );
                              },
                              leading: const Icon(
                                Icons.shopify_rounded,
                              ),
                              title: const AppText(
                                text: "Shop",
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              horizontalTitleGap: 0,
                              contentPadding: EdgeInsets.zero,
                              onTap: () {},
                              leading: const Icon(
                                Icons.shopping_cart_checkout_rounded,
                              ),
                              title: const AppText(
                                text: "Return Policy",
                              ),
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 15,
                            ),
                            const CatWidget(
                              text: "More from this Shop",
                              trailingText: "",
                              icon: SizedBox(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder<GetSupplierProducts>(
                                future: supplierController.fetchSupplierProducts(),
                                builder: (context , snapshot){
                                  if (snapshot.connectionState == ConnectionState.waiting)
                                  {
                                    return SizedBox(
                                      width: Get.width,
                                      height: 260,
                                      child: ListView.builder(
                                        itemCount: 4,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: 200,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: const ItemsView(
                                                imageUrl: AppConstants.dummyImage,
                                                prodDesc: "      ",
                                                prodPrice: "      ",
                                                ratingsCount: 5.0,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  else if (snapshot.hasData && snapshot.data!.data != null && snapshot.data!.data!.docs != null) {
                                    var data = snapshot.data!.data!.docs!;
                                    return
                                      SizedBox(
                                        width: Get.width,
                                        height: 260,
                                        child: ListView.builder(
                                            itemCount:data.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context,index){
                                              var products = data[index];
                                              return SizedBox(
                                                width: 200,
                                                child: ItemsView(
                                                  onTap: ()async{
                                                    await AppNavigations.to(
                                                      context,
                                                      nextScreen:
                                                      ProductDetailsView(
                                                        productId:
                                                        products.id.toString(),
                                                      ),
                                                    );
                                                  },
                                                  onShare:() async {
                                                      String productId = products.id.toString();
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
                                                        await shareController.sharedPost(
                                                          productId,
                                                          userId!,
                                                          "${Urls.productsImageUrl}${products.images!.first}",
                                                          products.name.toString(),
                                                          products.price.toString(),
                                                          products.description.toString(),

                                                        );
                                                      } finally {
                                                        Navigator.of(context).pop(); // Close the dialog box
                                                      }

                                                  },
                                                  imageUrl: "${Urls.productsImageUrl}${products.images!.first}",
                                                  prodDesc: products.name.toString(),
                                                  prodPrice: "Rs.${products.price}",
                                                  ratingsCount: products.ratingsCount!.toDouble(),
                                                ),
                                              );

                                            }),
                                      );
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return const Center(child: Text('No data'));
                                  }
                                }),
                            const SizedBox(
                              height: 10,
                            ),
                            const CatWidget(
                              text: "Related categories",
                              trailingText: "",
                              icon: SizedBox(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            FutureBuilder<GetCategoriesProduct>(
                                future:similarCategoriesProducts.gettingCategoriesProduct(data.category!.sId!) ,
                                builder: (context,snapshot){
                                  if(snapshot.connectionState==ConnectionState.waiting){
                                    return SizedBox(
                                      width: Get.width,
                                      height: 260,
                                      child: ListView.builder(
                                        itemCount: 4,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: 200,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: const ItemsView(
                                                imageUrl: AppConstants.dummyImage,
                                                prodDesc: "      ",
                                                prodPrice: "      ",
                                                ratingsCount: 5.0,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  if(snapshot.hasData&&snapshot.data!.data!.docs!=null){
                                    var relatedCategories = snapshot.data!.data!.docs!;
                                    return SizedBox(
                                      width: Get.width,
                                      height: 260,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                          itemCount: relatedCategories.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context,index){
                                            var products = relatedCategories[index];
                                            return SizedBox(
                                              width: 200,
                                              child: ItemsView(
                                                onTap: ()async{
                                                  await AppNavigations.to(
                                                    context,
                                                    nextScreen:
                                                    ProductDetailsView(
                                                      productId:
                                                      products.sId.toString(),
                                                    ),
                                                  );
                                                },
                                                onShare:() async {
                                                    String productId = products.sId.toString();
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
                                                      await shareController.sharedPost(
                                                        productId,
                                                        userId!,
                                                        "${Urls.productsImageUrl}${products.images!.first}",
                                                        products.name.toString(),
                                                        products.price.toString(),
                                                        products.description.toString(),

                                                      );
                                                    } finally {
                                                      Navigator.of(context).pop(); // Close the dialog box
                                                    }
                                                },
                                                imageUrl: "${Urls.productsImageUrl}${products.images!.first}",
                                                prodDesc: products.name.toString(),
                                                prodPrice: "Rs.${products.price}",
                                                ratingsCount: products.ratingsCount!.toDouble(),
                                              ),
                                            );
                                          }),
                                    );
                                  }if(snapshot.hasError){
                                    return AppText(text: "Error fetching related products.");
                                  }
                                  return const Center();
                                }),
                            const SizedBox(height: 100,),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {

                        AppNavigations.to(context, nextScreen: SetPricePage(
                          data: data,
                        ));
                      },
                      child: Container(
                        height: 70,
                        margin: const EdgeInsets.only(
                          bottom: 10,
                          left: 10,
                          right: 10,
                        ),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                ),
                                child: Center(
                                  child: AppText(
                                    text: "Rs. ${data.price}",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                                child: const Center(
                                  child: AppText(
                                    text: "Order",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const Center();
            },
          ),
        ),
      ),
    );
  }
}
