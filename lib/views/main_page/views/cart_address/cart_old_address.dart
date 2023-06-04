import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../../../../constants/app_colors.dart';
import '../../../../controllers/address_page_controller/new_address_controller.dart';
import '../../../../modals/addres_modals/get_address_modal.dart';
import '../../../../modals/cart_modals/cart_modal.dart';
import '../../../../utils/app_navigations.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text.dart';
import 'cart_order_page.dart';


class CartOldAddressView extends StatelessWidget {
  final List<CartItem> cartItems;
  const CartOldAddressView({Key? key,required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<NewAddressController>(
      init: NewAddressController(),
      builder: (controller) {
        return FutureBuilder<List<Docs>>(
            future: controller.getAddressController(controller.searchController.text),
            builder: (context , snapshot){
              if(snapshot.hasData && snapshot.data!=null&&snapshot.data!.isNotEmpty  ){
                return  Column(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height * 0.65,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data![index];
                            return Padding(
                              padding: EdgeInsets.only(top: 10,left: 10,right: 10),
                              child: Column(
                                children: [
                                  InkWell(
                                    borderRadius:
                                    BorderRadius
                                        .circular(20),
                                    onTap: () {
                                      controller.changeSelectedValue(index);
                                    },
                                    child: Container(
                                      height: 160,
                                      width:
                                      double.infinity,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: GradientBoxBorder(
                                          width: 3,
                                          gradient: LinearGradient(
                                              colors: index == controller.isSelected.value
                                                  ? [Colors.green, Colors.yellow]
                                                  : [Colors.transparent, Colors.transparent
                                              ]),
                                        ),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 15,
                                                backgroundColor:
                                                AppColors
                                                    .textColor,
                                                child:
                                                Center(
                                                  child:
                                                  AppText(
                                                    text: data.customerName!.substring(0,1).isEmpty
                                                        ? "-" : data.customerName!.substring(0,1),
                                                    color: Colors
                                                        .white,
                                                  ),
                                                ),
                                              ),
                                              AppText(
                                                text:
                                                "  ${data.customerName}",
                                                fontWeight:
                                                FontWeight
                                                    .w500,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              AppText(
                                                text:
                                                " house number: ${data.houseNo},",
                                                color: AppColors
                                                    .orderTextColor,
                                                fontSize:
                                                12,
                                              ),
                                              Flexible(
                                                child:
                                                AppText(
                                                  text:
                                                  " street number: ${data.streetNo},",
                                                  color: AppColors
                                                      .orderTextColor,
                                                  fontSize:
                                                  12,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              AppText(
                                                text:
                                                " sector: ${data.block},",
                                                color: AppColors
                                                    .orderTextColor,
                                                fontSize:
                                                12,
                                              ),
                                              Flexible(
                                                child:
                                                AppText(
                                                  text:
                                                  " Mashoor jagha: ${data.nearestLandmark}",
                                                  color: AppColors
                                                      .orderTextColor,
                                                  fontSize:
                                                  12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 23,
                                          ),
                                          AppText(
                                            text: data
                                                .phoneNo
                                                .toString(),
                                            color: AppColors
                                                .orderTextColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    Padding(
                      padding:EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: AppButton(
                            btnColor:
                            controller.selectedContainer ? AppColors.primaryColor : Colors.black12,
                            onTap: controller.selectedContainer ? () {
                              if (controller.selectedAddress != null) {
                                AppNavigations.to(
                                    context,
                                    nextScreen:
                                    CartOrderPage(
                                      addressData: controller.selectedAddress.value,
                                      cartItem: cartItems,
                                    ));
                              }
                            } : null,
                            text: "Continue"),
                      ),
                    ),
                  ],
                );
              }return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  Image.asset("assets/images/address.png",width: 150,height: 150,),
                  SizedBox(height: 50,),
                  AppText(text: "Please add any address",
                    fontSize: 18,fontWeight: FontWeight.w500,),
                ],
              );
            });
      }
    );
  }
}
