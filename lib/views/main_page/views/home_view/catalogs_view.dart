import 'package:flutter/material.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/widgets/catalog_items_details.dart';
import 'package:markaz_clone/widgets/product_ratings.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/app_constants.dart';
import '../../../../widgets/app_text.dart';

class CatalogsView extends StatelessWidget {
  final int numberOfItems;
  final String prodDesc, prodPrice, prodCollec;
  final double rating;
  final VoidCallback? onTap, onShare;
  const CatalogsView({
    Key? key,
    required this.numberOfItems,
    this.onTap,
    required this.prodCollec,
    required this.prodDesc,
    required this.prodPrice,
    required this.rating,
    this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppNavigations.to(
          context,
          nextScreen: CatalogItemsDetails(
            prodPrice: prodPrice,
            prodCol: prodCollec,
            prodDesc: prodDesc,
            rating: rating.toString(),
            numberOfItems: numberOfItems,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            AppConstants.dummyImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  numberOfItems >= 3
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          AppConstants.dummyImage,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          AppConstants.dummyImage,
                                        ),
                                      ),
                                    ),
                                    child: numberOfItems > 3
                                        ? Center(
                                            child: Container(
                                              color:
                                                  Colors.black.withOpacity(0.3),
                                              child: Center(
                                                child: AppText(
                                                  text: "${numberOfItems - 3}+",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : numberOfItems == 2
                          ? Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      AppConstants.dummyImage,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  textAlign: TextAlign.start,
                  text: prodCollec,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                ProductRatings(
                  initialRating: rating,
                  ignoreGesture: true,
                  itemSize: 20,
                ),
              ],
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
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  text: "Starting from Rs.$prodPrice",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.priceTagColor,
                ),
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
          ],
        ),
      ),
    );
  }
}
