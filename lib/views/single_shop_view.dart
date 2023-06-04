import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/modals/supplier_modal/single_supplier_modal.dart';
import 'package:markaz_clone/views/main_page/views/home_view/items_view.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/follow_controller/follow_controllers.dart';
import '../controllers/shared_products_controller/shared_products.dart';
import '../controllers/suppliers_controller/all_supplier_controller.dart';
import '../modals/supplier_modal/get_supplier_products_modal.dart';
import '../utils/app_navigations.dart';
import '../utils/app_urls.dart';
import 'main_page/views/single_product_details/product_details_view.dart';

class SingleShopView extends StatefulWidget {
  final String shopName;
  final double rating;
  final int followers, totalProducts;

  const SingleShopView({
    Key? key,
    required this.followers,
    required this.rating,
    required this.shopName,
    required this.totalProducts,
  }) : super(key: key);

  @override
  State<SingleShopView> createState() => _SingleShopViewState();
}

class _SingleShopViewState extends State<SingleShopView> {

  var sizeBox = const SizedBox(height: 10,);
  final SupplierController controller = Get.put(SupplierController());
  final SharedItemsController shareController = Get.put(SharedItemsController());
  final FollowController follow = Get.put(FollowController());

  bool isFollow = false;
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: AppText(
              text: widget.shopName,
            ),
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
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            FutureBuilder<GetSingleSupplier>(
            future: controller.fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
              {
                return const Center(child: CircularProgressIndicator());
              }
              else if (snapshot.hasData && snapshot.data!.data != null && snapshot.data!.data!.doc != null) {
                var data = snapshot.data!.data!.doc!;
                return
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "${Urls.supplierCover}${data.coverImage}",
                      ),
                      fit: BoxFit.cover
                    ),
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(
                      0.5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AppText(
                          text: "${data.firstName!} ${data.lastName!}",
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.star_rate_rounded,
                                      color: Colors.amber,
                                    ),
                                    AppText(
                                      text: widget.rating.toString(),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const AppText(
                                  text: "1 Rating",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                AppText(
                                  text: widget.followers.toString(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const AppText(
                                  text: "Followers",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                AppText(
                                  text: widget.totalProducts.toString(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const AppText(
                                  text: "Products",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ],
                            ),
                            AppButton(
                              width: 110,
                              height: 40,
                              onTap: () {
                                follow.clickToFollow(supplierId: data.sId.toString());
                                setState(() {
                                  isFollow = true;
                                });
                              },
                              text: isFollow?"Followed":"Follow",
                              fontSize: 13,
                              btnColor: isFollow?Colors.purple:Colors.white,
                              textColor: isFollow?Colors.white:Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Center(child: Text('No data'));
              }
            },
          ),


                sizeBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: const [
                      AppText(text: "All Products",
                        fontSize: 16,fontWeight: FontWeight.bold,color: AppColors.textColor,),

                    ],
                  ),
                ),
                sizeBox,
                FutureBuilder<GetSupplierProducts>(
                  future: controller.fetchSupplierProducts(),
                    builder: (context , snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting)
                      {
                        return const Center(child: CircularProgressIndicator());
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

              ],
            ),
          ),

          // GetBuilder<SupplierController>(
          //     init: SupplierController(),
          //     builder: (_) {
          //       var data = _.singleSupplier.value.data!.doc!;
          //       return CustomScrollView(
          //         slivers: [
          //           SliverAppBar(
          //             elevation: 0,
          //             backgroundColor:
          //             Theme.of(context).scaffoldBackgroundColor,
          //             pinned: true,
          //             centerTitle: true,
          //             title: AppText(
          //               text:"${data.firstName!} ${data.lastName!}",
          //             ),
          //             leading: IconButton(
          //               onPressed: () {
          //                 Navigator.pop(context);
          //               },
          //               icon: const Icon(
          //                 Icons.arrow_back,
          //                 color: Colors.black,
          //               ),
          //             ),
          //             actions: [
          //               IconButton(
          //                 onPressed: () {},
          //                 icon: const Icon(
          //                   Icons.badge,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //             ],
          //           ),
          //           SliverList(
          //             delegate: SliverChildListDelegate(
          //               [
          //                 Container(
          //                   width: double.infinity,
          //                   height: 250,
          //                   decoration:  BoxDecoration(
          //                     image: DecorationImage(
          //                       image: NetworkImage(
          //                         data.coverImage!,
          //                       ),
          //                     ),
          //                   ),
          //                   child: Container(
          //                     color: Colors.black.withOpacity(
          //                       0.5,
          //                     ),
          //                     child: Column(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment.spaceAround,
          //                       children: [
          //                         AppText(
          //                           text: "${data.firstName!} ${data.lastName!}",
          //                           fontSize: 25,
          //                           fontWeight: FontWeight.w700,
          //                           color: Colors.white,
          //                         ),
          //                         Row(
          //                           mainAxisAlignment:
          //                           MainAxisAlignment.spaceEvenly,
          //                           children: [
          //                             Column(
          //                               children: [
          //                                 Row(
          //                                   mainAxisAlignment:
          //                                   MainAxisAlignment.center,
          //                                   children: [
          //                                     const Icon(
          //                                       Icons.star_rate_rounded,
          //                                       color: Colors.amber,
          //                                     ),
          //                                     AppText(
          //                                       text: rating.toString(),
          //                                       fontSize: 16,
          //                                       fontWeight: FontWeight.w600,
          //                                       color: Colors.white,
          //                                     ),
          //                                   ],
          //                                 ),
          //                                 const SizedBox(
          //                                   height: 5,
          //                                 ),
          //                                 const AppText(
          //                                   text: "1 Rating",
          //                                   fontWeight: FontWeight.w500,
          //                                   color: Colors.white,
          //                                   fontSize: 13,
          //                                 ),
          //                               ],
          //                             ),
          //                             Column(
          //                               children: [
          //                                 AppText(
          //                                   text: followers.toString(),
          //                                   fontSize: 16,
          //                                   fontWeight: FontWeight.w600,
          //                                   color: Colors.white,
          //                                 ),
          //                                 const SizedBox(
          //                                   height: 5,
          //                                 ),
          //                                 const AppText(
          //                                   text: "Followers",
          //                                   fontWeight: FontWeight.w500,
          //                                   color: Colors.white,
          //                                   fontSize: 13,
          //                                 ),
          //                               ],
          //                             ),
          //                             Column(
          //                               children: [
          //                                 AppText(
          //                                   text: totalProducts.toString(),
          //                                   fontSize: 16,
          //                                   fontWeight: FontWeight.w600,
          //                                   color: Colors.white,
          //                                 ),
          //                                 const SizedBox(
          //                                   height: 5,
          //                                 ),
          //                                 const AppText(
          //                                   text: "Products",
          //                                   fontWeight: FontWeight.w500,
          //                                   color: Colors.white,
          //                                   fontSize: 13,
          //                                 ),
          //                               ],
          //                             ),
          //                             AppButton(
          //                               width: 110,
          //                               height: 40,
          //                               onTap: () {},
          //                               text: "Follow",
          //                               fontSize: 13,
          //                               btnColor: Colors.white,
          //                               textColor: Colors.black,
          //                             ),
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           AppText(text: "sdhsd"),
          //           ListView.builder(itemBuilder: (context,index){}),
          //         ],
          //       );
          //     }),
        ),
      ),
    );
  }
}
