import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/modals/addres_modals/get_address_modal.dart';
import 'package:markaz_clone/modals/product_modals/GetSingleProductModal.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_cache_image.dart';
import 'package:markaz_clone/widgets/flutter_toast.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:markaz_clone/views/main_page/views/single_product_details/product_details_view.dart';
import '../../../../controllers/address_page_controller/new_address_controller.dart';
import '../../../../controllers/product_details_controller/product_details_view_controller.dart';
import '../../../../utils/app_urls.dart';
import '../../../../widgets/app_text.dart';
import 'edit_old_address.dart';
import 'new_address_page.dart';

class OldOrderPage extends StatelessWidget {
  final String deliveryCharges;
  final Docs? addressData;
  final Doc productData;
  const OldOrderPage(
      {Key? key,
        required this.deliveryCharges,
        required this.addressData,
       required this.productData,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetails = Get.put(ProductDetailsViewController());
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
          child: Scaffold(
            appBar: MyAppBar(
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: AppColors.textColor,
                  )),
              title: const AppText(
                text: "Order Details",
                fontWeight: FontWeight.w500,
              ),
              centerTitle: false,
            ),
            body: GetBuilder<NewAddressController>(
              init: NewAddressController(),
              builder: (controller) {
                return Container(
                  padding: AppSpacings.defaultPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 160,
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: AppColors.gradientBorder,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.textColor,
                                    child: Center(
                                      child: AppText(
                                        text: addressData!.customerName!.substring(0,1),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                   AppText(
                                    text: "  ${addressData!.customerName!}",
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.edit,
                                    color: AppColors.orderTextColor,
                                    size: 18,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        AppNavigations.off(context, nextScreen: EditOldAddress(
                                          deliveryCharges: deliveryCharges,
                                          addressId: addressData!.sId.toString(),
                                          data: productData,
                                        ));
                                      },
                                      child: const AppText(
                                        text: "  Edit",
                                        color: AppColors.orderTextColor,
                                        fontWeight: FontWeight.w500,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  AppText(
                                    text:
                                    " house number: ${addressData?.houseNo},",
                                    color: AppColors.orderTextColor,
                                    fontSize: 12,
                                  ),
                                  Flexible(
                                    child: AppText(
                                      text:
                                      " street number: ${addressData?.streetNo},",
                                      color: AppColors.orderTextColor,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  AppText(
                                    text:
                                    " sector: ${addressData?.block},",
                                    color: AppColors.orderTextColor,
                                    fontSize: 12,
                                  ),
                                  Flexible(
                                    child: AppText(
                                      text:
                                      " Mashoor jagha: ${addressData?.nearestLandmark}",
                                      color: AppColors.orderTextColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 23,
                              ),
                              AppText(
                                text:"${addressData?.phoneNo}",
                                color: AppColors.orderTextColor,
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: AppColors.borderColor,
                          thickness: 2,
                          height: 35,
                        ),
                        Row(
                          children: const [
                            AppText(
                              text: "Payment Method",
                              color: AppColors.orderTextColor,
                            ),
                            Spacer(),
                            Icon(
                              Icons.account_balance_wallet,
                              color: AppColors.textColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            AppText(
                              text: "Cash On Delivery (COD)",
                              color: AppColors.textColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            )
                          ],
                        ),
                        const Divider(
                          color: AppColors.borderColor,
                          thickness: 2,
                          height: 35,
                        ),
                        Container(
                          height: 190,
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border:
                            Border.all(width: 2, color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppText(
                                text: "Order Summary",
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const AppText(
                                    text: "Total Wholesale Price",
                                    color: AppColors.orderTextColor,
                                    fontSize: 13,
                                  ),
                                  AppText(
                                    text:
                                    "Rs.${int.parse(productData.price.toString()) * int.parse(productDetails.add.toString())}",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const AppText(
                                    text: "Shipping Fee",
                                    color: AppColors.orderTextColor,
                                    fontSize: 13,
                                  ),
                                  AppText(
                                    text: "Rs.$deliveryCharges",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const AppText(
                                    text: "Total Profit",
                                    color: AppColors.orderTextColor,
                                    fontSize: 13,
                                  ),
                                  AppText(
                                    text:
                                    "Rs. ${productDetails.profitController.text.isEmpty ? "0" : productDetails.profitController.text}",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              const Divider(
                                color: AppColors.borderColor,
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const AppText(
                                    text: "Total Price charge to customer",
                                    color: AppColors.orderTextColor,
                                    fontSize: 13,
                                  ),
                                  AppText(
                                    text:
                                    "Rs. ${int.parse(productData.price.toString()) * int.parse(productDetails.add.toString()) + int.parse(productDetails.profitController.text.isEmpty ? "0" : productDetails.profitController.text) + int.parse(deliveryCharges)}",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const AppText(
                          text: "Review your order",
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                          fontSize: 15,
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: (){
                            AppNavigations.off(context, nextScreen: ProductDetailsView(
                              productId: productData.sId.toString(),
                            ));
                          },
                          child: Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: AppColors.borderColor, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 25.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child:  AppCacheImage(
                                            imageUrl: "${Urls.productsImageUrl}${productData.images!.first}",
                                            fit: BoxFit.fill,
                                            height: 85,
                                            width: 85,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: SizedBox(
                                          width: 250,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              AppText(
                                                text: productData.name.toString(),
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textColor,
                                              ),
                                              AppText(
                                                text:
                                                "Rs.${int.parse(productData.price.toString()) * int.parse(productDetails.add.toString()) + int.parse(productDetails.profitController.text.isEmpty ? "0" : productDetails.profitController.text)}",
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue,
                                              ),
                                              // ignore: prefer_const_constructors
                                              SizedBox(
                                                height: 10,
                                              ),
                                              AppText(
                                                text: "Quantity: ${productDetails.add}",
                                                color: AppColors.orderTextColor,
                                                fontSize: 13,
                                              ),
                                              AppText(
                                                text:
                                                "Profit: Rs. ${productDetails.profitController.text}",
                                                color: AppColors.orderTextColor,
                                                fontSize: 13,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        AppButton(
                          text: "Continue",
                          onTap: () async{
                             productDetails.createOrder(
                               addressData!.sId.toString(),
                              deliveryCharges.toString(),
                              productData.sId.toString(),
                              productDetails.add.toString(),
                              productData.price.toString(),
                              productDetails.profitController.text.isEmpty?"0":productDetails.profitController.text,
                              productData.owner!.sId!,
                            ).then((value) {
                              ToastMessage.showMessage("Order Placed successfully");
                               showModalBottomSheet(
                                   backgroundColor:
                                   Theme.of(context).scaffoldBackgroundColor,
                                   shape: const RoundedRectangleBorder(
                                     borderRadius: BorderRadius.only(
                                       topLeft: Radius.circular(30),
                                       topRight: Radius.circular(30),
                                     ),
                                   ),
                                   context: context,
                                   builder: (context) {
                                     return Container(
                                       height: 350,
                                       padding: AppSpacings.defaultPadding,
                                       child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                         children: [
                                           const SizedBox(
                                             height: 50,
                                           ),
                                           const AppText(
                                             text: "Thanks for your order",
                                             fontSize: 20,
                                             fontWeight: FontWeight.w500,
                                             color: AppColors.textColor,
                                           ),
                                           const SizedBox(
                                             height: 20,
                                           ),
                                           RichText(
                                             text: const TextSpan(
                                                 text:
                                                 "After your order is confirmed, you will receive a notification.",
                                                 style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 16),
                                                 children: [
                                                   TextSpan(
                                                       text:
                                                       "You will receive your profit in your account 48-72 hours after successful delivery.",
                                                       style: TextStyle(
                                                           color: AppColors.textColor,
                                                           fontWeight:
                                                           FontWeight.w500))
                                                 ]),
                                           ),
                                           const SizedBox(
                                             height: 30,
                                           ),
                                           AppButton(
                                             text: "Continue Shipping",
                                             fontSize: 13,
                                             onTap: () {
                                               AppNavigations.off(context,
                                                   nextScreen: NewAddressPage(
                                                     data: productData,
                                                   ));
                                               controller.setBoolValue(true);
                                             },
                                           )
                                         ],
                                       ),
                                     );
                                   });
                             });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
