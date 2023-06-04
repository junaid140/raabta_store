import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import '../../../../utils/app_urls.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';

class ProductsImages extends StatefulWidget {
  final List<String>? images;

  const ProductsImages({Key? key, this.images}) : super(key: key);

  @override
  State<ProductsImages> createState() => _ProductsImagesState();
}

class _ProductsImagesState extends State<ProductsImages> {
  final ProductsImagesController controller =
      Get.put(ProductsImagesController());

  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: MyAppBar(
            automaticallyImplyLeading: false,
            title: const AppText(
              text: "Product details",
              fontSize: 14,
            ),
            centerTitle: false,
            leading: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.textColor,
                )),
          ),
          body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: widget.images?.length ?? 0,
                  onPageChanged: (pageIndex){
                    controller.changeSelectedValue;
                    setState(() {
                      isSelected=pageIndex;
                    });
                    },
                  itemBuilder: (context, index) {
                    return EasyImageView(
                      imageProvider: NetworkImage(
                        "${Urls.productsImageUrl}${widget.images![index]}",
                      ),
                      doubleTapZoomable: true,
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: Get.width * 0.9,
                  height: 90,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 60),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: widget.images?.length ?? 0,
                    itemBuilder: (context, innerIndex) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = innerIndex;
                          });
                          controller.changeSelectedValue(innerIndex);
                          controller.goToPage(innerIndex);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 70,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: GradientBoxBorder(
                                width: 2,
                                gradient: LinearGradient(
                                    colors: isSelected == innerIndex
                                        ? [Colors.green, Colors.yellow]
                                        : [
                                            Colors.transparent,
                                            Colors.transparent
                                          ]),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "${Urls.productsImageUrl}${widget.images![innerIndex]}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsImagesController extends GetxController {
  final PageController pageController = PageController();
  RxInt isSelected = RxInt(0);

  changeSelectedValue(int index) {
    isSelected.value = index;
    update();
  }

  void goToPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
