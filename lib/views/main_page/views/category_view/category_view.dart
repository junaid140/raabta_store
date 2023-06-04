import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_constants.dart';
import 'package:markaz_clone/controllers/main_page_controllers'
    '/main_page_views_controllers/category_view_controller.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/utils/app_urls.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shimmer/shimmer.dart';
import 'categories_products.dart';


class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryViewController>(
        init: CategoryViewController(),
        builder: (controller) {
          var catagories = controller.catagories.value.data?.docs!;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: controller.isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (_, __) => Column(
                            children: [
                              Container(
                                height: Get.height,
                                width: Get.width,
                                decoration:const  BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.grey.withOpacity(0.3),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: catagories?.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.changeCat(index);
                                    },
                                    child: Container(
                                      width: Get.width,
                                      padding: const EdgeInsets.only(top: 5),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: controller.selectedCat == index
                                              ? Theme.of(context)
                                              .scaffoldBackgroundColor
                                              : Colors.transparent,
                                      ),
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage("${Urls.categoriesImageUrl}${catagories![index].image}"),
                                            backgroundColor: Colors.transparent,
                                          ),
                                          AppText(
                                            text: catagories[index]
                                                .name
                                                .toString(),
                                            color:
                                                controller.selectedCat == index
                                                    ? AppColors.primaryColor
                                                    : Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
              ),
              Expanded(
                flex: 4,
                child: controller.isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (_, __) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 6,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (_, __) => Column(
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: 60,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      )
                    : ScrollablePositionedList.builder(
                        initialScrollIndex: controller.selectedCat,
                        itemScrollController: controller.itemScrollController,
                        itemPositionsListener: controller.itemPositionsListener,
                        itemCount: catagories?.length??0,
                        itemBuilder: (context, index) {
                          var subCatagories = controller.getSubCategoriesByCategoryId(
                                  controller.catagories.value.data!.docs![index].sId!);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text: catagories![index].name.toString(),
                                fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: AppColors.textColor,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: subCatagories.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap:()async{
                                          await  AppNavigations.to(context,
                                                nextScreen: CategoriesProducts(
                                                  subcategorieName:subCatagories[index].name
                                                      .toString(),
                                                  categoriesId: subCatagories[index].mainCategory.sId,
                                                ));
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              image: const DecorationImage(
                                                image: NetworkImage(
                                                 AppConstants.dummyImage,
                                              ),
                                                fit: BoxFit.cover
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        AppText(
                                          text: subCatagories[index].name
                                              .toString(),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textColor,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Divider(),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        });
  }
}
