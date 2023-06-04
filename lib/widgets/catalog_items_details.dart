import 'package:flutter/material.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_constants.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/main_page/views/home_view/home_page/home_view.dart';
import 'package:markaz_clone/views/single_shop_view.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';

class CatalogItemsDetails extends StatelessWidget {
  final int numberOfItems;
  final String rating, prodDesc, prodCol, prodPrice;
  const CatalogItemsDetails({
    Key? key,
    required this.numberOfItems,
    required this.prodCol,
    required this.prodDesc,
    required this.rating,
    required this.prodPrice,
  }) : super(key: key);

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
            title: const SizedBox(),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.download,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.copy,
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.badge,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        AppConstants.dummyImage,
                      ),
                    ),
                  ),
                  child: Center(
                    child: ColoredBox(
                      color: Colors.black26,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: prodDesc,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              AppNavigations.to(
                                context,
                                nextScreen: SingleShopView(
                                  followers: 100,
                                  rating: double.parse(rating),
                                  shopName: prodCol,
                                  totalProducts: 100,
                                ),
                              );
                            },
                            child: AppText(
                              text: "$prodCol >",
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: Colors.amber,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              AppText(
                                text: rating,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              AppButton(
                                onTap: () {},
                                text: "Share Collection",
                                height: 30,
                                width: 140,
                                fontSize: 12,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: numberOfItems,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCategory(
                        prodCollec: prodCol,
                        prodDesc: prodDesc,
                        prodPrice: prodPrice,
                        inCollection: false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
