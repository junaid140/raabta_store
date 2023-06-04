import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/app_constants.dart';
import '../views/main_page/views/home_view/items_view.dart';

class VerticalShimmerEffects extends StatelessWidget {
  const VerticalShimmerEffects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.74,
          crossAxisCount: 2,
        ),
        itemCount: 6,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const ItemsView(
              imageUrl: AppConstants.dummyImage,
              prodDesc: "    ",
              prodPrice: "    ",
            ),
          );
        });
  }
}

class HorizontalShimmerEffect extends StatelessWidget {
  const HorizontalShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      width: Get.width,
      child:Shimmer.fromColors(
        period: const Duration(seconds: 2),
        direction: ShimmerDirection.btt,
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (_, __) => const Padding(
            padding: EdgeInsets.only(
                left: 8.0),
            child: SizedBox(
              width: 200,
              child: ItemsView(
                imageUrl: AppConstants.dummyImage,
                prodDesc: "    ",
                prodPrice: "    ",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
