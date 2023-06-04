import 'package:flutter/material.dart';
import 'package:markaz_clone/widgets/image_loader.dart';
import '../../../../constants/app_colors.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/product_ratings.dart';

class ItemsView extends StatelessWidget {
  final String prodDesc, prodPrice,imageUrl;
  final VoidCallback? onTap, onShare;
  final double  ratingsCount;
  final Widget? shareIcon;
  const ItemsView({
    Key? key,
    this.onTap,
    this.imageUrl='',
    this.ratingsCount=0.0,
    required this.prodDesc,
    required this.prodPrice,
    this.onShare,
    this.shareIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.borderColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: ImageLoader(
                  imageUrl: imageUrl,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              height: 15,
              child: AppText(
                textAlign: TextAlign.start,
                maxLines: 2,
                text: prodDesc,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 5,
            ),

            AppText(
              textAlign: TextAlign.start,
              maxLines: 2,
              text: prodPrice,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.priceTagColor,
            ),
            Row(
              children: [
                ProductRatings(
                  itemSize: 13,
                  initialRating: ratingsCount,
                  ignoreGesture: true,
                ),
                AppText(
                  text: " Ratings:$ratingsCount",
                  fontSize: 8,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: onShare,
                child: shareIcon??const Icon(
                  Icons.share_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
