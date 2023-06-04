
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../controllers/main_page_controllers/main_page_views_controllers/category_view_controller.dart';
import '../../../../../controllers/shared_products_controller/shared_products.dart';
import '../../../../../modals/categories_modals/get_categories_product_modal.dart';
import '../../../../../utils/app_navigations.dart';
import '../../../../../utils/app_urls.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/shimmer_effects.dart';
import '../../single_product_details/product_details_view.dart';
import '../items_view.dart';




class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<bool> _expandedList = [];
  final catagories = Get.put(CategoryViewController());

  final SharedItemsController shareController = Get.put(SharedItemsController());


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final catagoriesValue = catagories.catagories.value;
      if (catagoriesValue.data == null || catagoriesValue.data!.docs == null) {
        return CircularProgressIndicator();
      }
      final dataLength = catagoriesValue.data!.docs!.length;
         return  ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dataLength,
            itemBuilder: (context, index) {
              final category = catagories.catagories.value.data!.docs![index];
              if (_expandedList.length <= index) {
                _expandedList.add(true);
              }
              return Column(
                children: [
                  ListTile(
                    tileColor: AppColors.borderColor.withOpacity(0.3),
                    title: AppText(
                      text: "${index + 1}.${category.name}",
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    onTap: () {
                      setState(() {
                        _expandedList[index] = !_expandedList[index];
                      });
                    },
                    trailing: _expandedList[index]
                        ? Icon(Icons.arrow_drop_up,color: AppColors.primaryColor,)
                        : Icon(Icons.arrow_drop_down,color: AppColors.black,),
                  ),
                  if (_expandedList[index])
                    FutureBuilder<GetCategoriesProduct>(
                      future: catagories
                          .gettingCategoriesProduct(category.sId.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final products = snapshot.data!.data?.docs;
                          if (products != null && products.isNotEmpty) {
                            return SizedBox(
                              width: double.infinity,
                              height: 260,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return SizedBox(
                                    width: 210,
                                    child: ItemsView(
                                        shareIcon: const Icon(
                                          Icons.share_outlined,
                                        ),
                                        onTap: () async {
                                          await AppNavigations.to(
                                            context,
                                            nextScreen: ProductDetailsView(
                                              productId: product.sId.toString(),
                                            ),
                                          );
                                        },
                                        onShare: () async {
                                          String productId =
                                              product.sId.toString();
                                          var pref = await SharedPreferences
                                              .getInstance();
                                          var userId = pref.getString("userId");
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                elevation: 0,
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(40),
                                                    topLeft:
                                                        Radius.circular(40),
                                                    topRight:
                                                        Radius.circular(5),
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                                content: Container(
                                                  width: 40,
                                                  height: 90,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/images/rabtastore.svg",
                                                        width: 45,
                                                        height: 45,
                                                      ),
                                                      SizedBox(height: 10),
                                                      AppText(
                                                        text:
                                                            'Wait for a while ...',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
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
                                              "${Urls.productsImageUrl}${product.images!.first}",
                                              product.name.toString(),
                                              product.price.toString(),
                                              product.description.toString(),
                                            );
                                          } finally {
                                            Navigator.of(context)
                                                .pop(); // Close the dialog box
                                          }
                                        },
                                        imageUrl:
                                            "${Urls.productsImageUrl}${product.images?.first}",
                                        prodDesc: product.name.toString(),
                                        prodPrice: product.price.toString()),
                                  );
                                },
                              ),
                            );
                          } else {
                            return AppText(text: 'No products found');
                          }
                        } else if (snapshot.hasError) {
                          return AppText(text: 'Error loading products');
                        }
                        // Show a loading indicator while fetching data.
                        return HorizontalShimmerEffect();
                      },
                    ),
                ],
              );
            },
          );
        });
  }
}
