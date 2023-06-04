import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/modals/addres_modals/get_address_modal.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_cache_image.dart';
import 'package:markaz_clone/widgets/flutter_toast.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:markaz_clone/views/main_page/views/single_product_details/product_details_view.dart';
import '../../../../controllers/address_page_controller/new_address_controller.dart';
import '../../../../controllers/main_page_controllers/main_page_views_controllers/all_products_controller.dart';
import '../../../../controllers/product_details_controller/product_details_view_controller.dart';
import '../../../../modals/cart_modals/cart_modal.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/image_loader.dart';
import 'cart_address_page.dart';
import 'edit_cart_address.dart';

class CartOrderPage extends StatelessWidget {
  final Docs? addressData;
  final List<CartItem> cartItem;
  const CartOrderPage(
      {Key? key,
        required this.addressData,
        required this.cartItem,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetails = Get.put(ProductDetailsViewController());
    final allProducts = Get.put(AllProductsController());
    String deliveryCharges = allProducts.deliveryCharges;
    int totalWholesalePrice = 0;
    int totalShippingFee = 0;
    int totalProfit = 0;
    int totalPriceToCustomer = 0;
    for (final cartItems in cartItem) {
      totalWholesalePrice +=
          int.parse(cartItems.price.toString()) * int.parse(cartItems.qty.toString());
      totalShippingFee +=
          int.parse(deliveryCharges) * int.parse(cartItems.qty.toString());
      totalProfit +=
          int.parse(cartItems.userProfit!.isEmpty ? "0" : cartItems.userProfit!);
      totalPriceToCustomer +=
          int.parse(cartItems.price.toString()) *
              int.parse(cartItems.qty.toString()) +
              int.parse(cartItems.userProfit!.isEmpty
                  ? "0"
                  : cartItems.userProfit!) +
              int.parse(deliveryCharges);
    }
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
                return SingleChildScrollView(
                  child: Padding(
                    padding: AppSpacings.defaultPadding,
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
                                        text: addressData!.customerName!.substring(0,1).isEmpty
                                            ? "-" : addressData!.customerName!.substring(0,1),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                   AppText(
                                    text:  " ${addressData!.customerName!}",
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
                                        AppNavigations.off(context, nextScreen: EditCartAddress(
                                          addressId: addressData!.sId.toString(),
                                          cartItem: cartItem,
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
                                    "Rs.$totalWholesalePrice",
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
                                    text: "Rs.$totalShippingFee",
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
                                    "Rs. $totalProfit",
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
                                    "Rs. $totalPriceToCustomer",
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
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                            itemCount: cartItem.length,
                            shrinkWrap: true,
                            itemBuilder: (context,index){
                              final cartItems = cartItem[index];
                              return Column(
                                children: [
                                  const SizedBox(height: 10,),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(20),
                                    onTap: (){
                                      AppNavigations.off(context, nextScreen: ProductDetailsView(
                                        productId: cartItems.id.toString(),
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
                                                  padding: const EdgeInsets.only(bottom: 30.0),
                                                  child: Container(
                                                    width:60,
                                                    height:60,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child:  ImageLoader(
                                                        imageUrl: "${cartItems.imageUrl}",
                                                      ),
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
                                                          text: cartItems.title.toString(),
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.textColor,
                                                        ),
                                                        AppText(
                                                          text:
                                                          "Rs.${int.parse(cartItems.price.toString()) * int.parse(cartItems.qty.toString()) + int.parse(cartItems.userProfit!.isEmpty ? "0" : cartItems.userProfit!)}",
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.blue,
                                                        ),
                                                        // ignore: prefer_const_constructors
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        AppText(
                                                          text: "Quantity: ${cartItems.qty}",
                                                          color: AppColors.orderTextColor,
                                                          fontSize: 13,
                                                        ),
                                                        AppText(
                                                          text:
                                                          "Profit: Rs. ${cartItems.userProfit!.isEmpty?"0":cartItems.userProfit!}",
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
                                ],
                              );
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                        AppButton(
                          text: "Continue",
                          onTap: () async{
                            List<Map<String, String?>> products = [];
                            for (final cartItems in cartItem) {
                              final product = {
                                "product": cartItems.id.toString(),
                                "qty": cartItems.qty.toString(),
                                "unitPrice": cartItems.price.toString(),
                                "userProfit": cartItems.userProfit!.isEmpty ? "0" : cartItems.userProfit!,
                                "productOwner": cartItems.productOwnerId,
                              };
                              products.add(product);
                            }
                            productDetails.createCartOrder(
                              addressData!.sId.toString(),
                              deliveryCharges.toString(),
                              products,
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
                                                  nextScreen: CartAddAddress(
                                                    cartItems: cartItem,
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
