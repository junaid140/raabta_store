import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/modals/product_modals/GetSingleProductModal.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/app_spacings.dart';
import '../../../../controllers/main_page_controllers/main_page_views_controllers/all_products_controller.dart';
import '../../../../controllers/product_details_controller/product_details_view_controller.dart';
import '../../../../modals/cart_modals/cart_modal.dart';
import '../../../../utils/app_navigations.dart';
import '../../../../utils/app_urls.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_formfield.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/flutter_toast.dart';
import '../../main_page.dart';
import '../address_view/new_address_page.dart';
import '../cart_view/cart_manager.dart';
import '../cart_view/cart_page.dart';

class SetPricePage extends StatefulWidget {
  final Doc data;
  const SetPricePage({Key? key , required this.data}) : super(key: key);

  @override
  State<SetPricePage> createState() => _SetPricePageState();
}

class _SetPricePageState extends State<SetPricePage> {
  final cartRep = CartRep(prefs: SharedPreferences.getInstance());

  final AllProductsController controller = Get.put(AllProductsController());

  @override
  Widget build(BuildContext context) {
    final width = Get.width;
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                )),
            centerTitle: false,
            title: const AppText(
              text: "Product Details",
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          body: SingleChildScrollView(
            child: GetBuilder<ProductDetailsViewController>(
                init: ProductDetailsViewController(),
                builder: (_) {
                  _.profitController.addListener(() {
                    setState(() {});
                  });
                  return SizedBox(
                    child: Column(
                      children: [
                        Container(
                          padding: AppSpacings.defaultPadding,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  AppText(
                                    text: "Unit Price",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Spacer(
                                    flex: 2,
                                  ),
                                  AppText(
                                      text: "Quantity",
                                      fontSize: 14,
                                      fontWeight:
                                      FontWeight.w500),
                                  Spacer(
                                    flex: 1,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  AppText(
                                      text: "Rs. ${widget.data.price}",
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.w500),
                                  const Spacer(flex: 5,),
                                  Row(
                                    children: [
                                      InkWell(
                                        borderRadius:
                                        BorderRadius
                                            .circular(10),
                                        onTap: () {
                                          _.subtractLess();
                                        },
                                        child: Container(
                                          height: 43,
                                          width: 43,
                                          decoration:
                                          BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(10),
                                            border: AppColors.gradientBorder,
                                          ),
                                          child: const Center(
                                            child: AppText(
                                              text: "-",
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15,),
                                      AppText(text: _.add.toString()),
                                      const SizedBox(width: 15,),
                                      InkWell(
                                        borderRadius:
                                        BorderRadius
                                            .circular(10),
                                        onTap: () {
                                          _.addMore();
                                        },
                                        child: Container(
                                          height: 43,
                                          width: 43,
                                          decoration:
                                          BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(10),
                                            border:AppColors.gradientBorder,),
                                          child: const Center(
                                            child: AppText(
                                              text: "+",
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(flex: 1,),
                                ],
                              ),
                              const Divider(color: AppColors.borderColor,height: 60,thickness: 2,),
                              const SizedBox(height: 10),
                              const AppText(text: "Select Size",fontSize: 13,fontWeight: FontWeight.w500,),
                              // SizedBox(
                              //   width: Get.width,
                              //   height: 100,
                              //   child: ListView.builder(
                              //       itemCount: widget.data.attributes!.length??0,
                              //       shrinkWrap: true,
                              //       physics: NeverScrollableScrollPhysics(),
                              //       scrollDirection: Axis.horizontal,
                              //       itemBuilder: (context,index){
                              //         if(widget.data.attributes!.isNotEmpty){
                              //           return Column(
                              //             children: [
                              //               AppText(text:widget.data.attributes![index].name.toString() ),
                              //               AppText(text:widget.data.attributes![index].value.toString() ),
                              //               AppText(text:widget.data.attributes![index].label.toString() ),
                              //             ],
                              //           );
                              //         }
                              //         return Center();
                              //       }),
                              // ),
                              const SizedBox(height: 10),
                              const AppText(text: "",fontSize: 13,fontWeight: FontWeight.w500,),
                              AppFormfield(
                                controller: _.profitController,
                                hintText: "Ap k Profit",
                                labelText: "Ap k Profit",
                                hintFontSize: 12,
                                labelFontSize: 12,
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 40),
                              const DottedLine(
                                direction: Axis.horizontal,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: 4.0,
                                dashColor: Colors.grey,
                              ),
                              const SizedBox(height: 40),
                              Row(
                                children: [
                                  const AppText(text: "Wholesale Price",
                                    fontWeight: FontWeight.w500,fontSize: 15,),
                                  const Spacer(),
                                  AppText(text: "Rs. ${widget.data.price}",fontWeight: FontWeight.w500,fontSize: 15,),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children:  [
                                  const AppText(text: "Total Profit",fontWeight: FontWeight.w500,fontSize: 15,),
                                  const Spacer(),
                                  AppText(text: "Rs.${_.profitController.text.isEmpty?"00":_.profitController.text} ",
                                    fontWeight: FontWeight.w500,fontSize: 15,),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children:  [
                                  const AppText(text: "Delivery Charges",
                                    fontWeight: FontWeight.w500,fontSize: 15,),
                                  const  Spacer(),
                                  AppText(text: "Rs.${int.parse(controller.deliveryCharges)*int.parse(_.add.toString())}",
                                    fontWeight: FontWeight.w500,fontSize: 15,),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children:  [
                                  const  AppText(text: "Customer ki Price",fontWeight: FontWeight.w500,fontSize: 15,),
                                  const Spacer(),
                                  AppText(text: "Rs.${
                                      int.parse(widget.data.price.toString())*
                                          int.parse(_.add.toString())+
                                          int.parse(_.profitController.text.isEmpty?"0":_.profitController.text)+
                                          (int.parse(controller.deliveryCharges)*int.parse(_.add.toString()))}",
                                    fontWeight: FontWeight.w500,fontSize: 15,),
                                ],
                              ),
                              const SizedBox(height: 90,),
                              Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                children: [
                                  AppButton(text: "Add to Bag",btnColor: AppColors.primaryColor,fontSize: 13,
                                    width:width*0.42,
                                    onTap: ()async{
                                      final cartItems = await cartRep.getCartItems();
                                      if (cartItems.any((item) => item.id == widget.data.sId.toString())) {
                                        // Product already in cart, show toast message
                                        ToastMessage.showMessage("Product is already in the cart");
                                        return;
                                      }else{
                                        cartRep.addToCart(
                                          CartItem(
                                            id: widget.data.sId.toString(),
                                            title: widget.data.name.toString(),
                                            size: "",
                                            price: int.parse(widget.data.price.toString()),
                                            productOwnerId: widget.data.owner?.sId.toString(),
                                            userProfit: _.profitController.text.isEmpty
                                                ?"0":_.profitController.text.toString(),
                                            imageUrl:"${Urls.productsImageUrl}${widget.data.images?.first}",
                                            qty: _.add.toString(),
                                          ),
                                        ).then((value) {
                                          showModalBottomSheet(
                                              backgroundColor:
                                              Theme.of(context).scaffoldBackgroundColor,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                              context: context, builder: (controller){
                                            return Container(
                                              height: 330,
                                              padding: AppSpacings.defaultPadding,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children:  [
                                                  const  SizedBox(height: 5,),
                                                  const AppText(text: "Added to beg",
                                                    color: AppColors.textColor,
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  const  SizedBox(height: 10,),
                                                  const Padding(
                                                    padding: EdgeInsets.only(left: 20.0),
                                                    child: AppText(
                                                      textAlign: TextAlign.center,
                                                      text: "Click the checkout button to complete the purchase\n process.",
                                                      fontSize: 11.5,
                                                      color: AppColors.textColor,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20,),
                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: AppColors.borderColor),
                                                      ),
                                                      child:  InkWell(
                                                        onTap: (){
                                                          AppNavigations.off(
                                                            context,
                                                            nextScreen: MainPage(
                                                              currentIndex: 2,
                                                            ),
                                                          );
                                                        },
                                                        child: const Center(child: AppText(text: "Continue shopping",
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 13,
                                                          color: AppColors.textColor,
                                                        ),),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                  AppButton(
                                                    btnColor: AppColors.primaryColor,
                                                    text: "Checkout",
                                                    textColor: Colors.white,
                                                    fontSize: 13, onTap: (){
                                                      Navigator.pop(context);
                                                      AppNavigations.to(context, nextScreen: const CartScreen());
                                                    },),
                                                ],
                                              ),
                                            );
                                          });
                                        });
                                      }
                                    },
                                  ),
                                  AppButton(text: "Order Now",btnColor: AppColors.primaryColor,fontSize: 13,
                                    width:width*0.42,
                                    onTap: (){
                                      AppNavigations.to(context,
                                          nextScreen:  NewAddressPage(
                                        deliveryCharges:"${int.parse(controller.deliveryCharges)*
                                            int.parse(_.add.toString())}",
                                        data: widget.data,
                                      ));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
