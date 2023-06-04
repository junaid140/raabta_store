import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_constants.dart';
import 'package:markaz_clone/controllers/main_page_controllers/'
    'main_page_views_controllers/orders_view_controller.dart';
import 'package:markaz_clone/modals/order_modals/get_my_orders_modal.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/main_page/main_page.dart';
import 'package:markaz_clone/views/main_page/views/orders/progress_order.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/image_loader.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constants/app_colors.dart';
import '../../../../controllers/main_page_controllers/main_page_views_controllers/all_products_controller.dart';
import '../../../../utils/app_urls.dart';
import '../../../../widgets/app_button.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: GetBuilder<OrdersViewController>(
                init: OrdersViewController(),
                builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                          _.btnsText.length,
                          (index) => RoundButton(
                            btnColor:
                                _.selectedIndex == index ? null : Colors.white,
                            textColor: _.selectedIndex == index
                                ? null
                                : AppColors.roundButtonColor,
                            onTap: () {
                              _.changeIndex(index);
                            },
                            text: _.btnsText[index],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if(_.selectedIndex == 0)
                        FutureBuilder<List<Docs>>(
                            future: _.getMyOrders(),
                            builder: (context,snapshot){
                              if(snapshot.connectionState==ConnectionState.waiting){
                                return SizedBox(
                                  width: Get.width,
                                  height: Get.height*0.75,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child:  ListView.builder(
                                        itemCount: 4,
                                        itemBuilder: (BuildContext context, int index){
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 60,
                                                  decoration: const BoxDecoration(
                                                      color: AppColors.textColor,
                                                      borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(15),
                                                          topRight: Radius.circular(15))
                                                  ),
                                                  child: Row(
                                                    children: const [
                                                      SizedBox(width: 10,),
                                                      AppText(text: "            ",
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                                  width: double.infinity,
                                                  height: 410,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: AppColors.borderColor,width: 2),
                                                    borderRadius: const BorderRadius.only(
                                                        bottomRight: Radius.circular(15),
                                                        bottomLeft: Radius.circular(15)),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: const [
                                                          AppText(text:  "        ",
                                                            color: AppColors.textColor,
                                                            fontWeight: FontWeight.w500,),
                                                          Spacer(),
                                                          AppText(text: "   ",
                                                            fontWeight: FontWeight.w500,color: AppColors.textColor,),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8,),
                                                      const Divider(color: AppColors.borderColor,thickness: 2,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  border:Border.all(color: AppColors.textColor,width: 2),
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 2,
                                                                height: 50,
                                                                color: AppColors.textColor,
                                                              ),
                                                              Container(
                                                                width: 20,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  border:Border.all(color: AppColors.textColor,width: 2),
                                                                  color: AppColors.textColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children:  [
                                                              const  AppText(text: "    ",
                                                                fontSize: 15,
                                                                color: AppColors.textColor,fontWeight: FontWeight.w500,),
                                                              const AppText(text: "        ",
                                                                color: AppColors.textColor,),
                                                              const SizedBox(height: 17),
                                                              Row(
                                                                children: [
                                                                  const AppText(text: "      ", fontSize: 15,
                                                                    color: AppColors.textColor,fontWeight: FontWeight.w500,),
                                                                  const SizedBox(width: 180,),
                                                                  Image.asset("assets/whatsapp.png",width: 40,height: 40,),

                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      const Divider(color: AppColors.borderColor,thickness: 2,),
                                                      ListTile(
                                                        leading: ClipRRect(
                                                          borderRadius: BorderRadius.circular(10),
                                                          // child: Image.network(AppConstants.dummyImage,),
                                                          child: Image.network(AppConstants.dummyImage),
                                                        ),
                                                        title: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: const [
                                                            AppText(text: "  "),
                                                            AppText(text: "    ",),
                                                            AppText(text: "   ",),
                                                          ],
                                                        ),
                                                        trailing:const AppText(text: "    ",),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 28.0),
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Container(
                                                            width: 150,
                                                            height: 30,
                                                            decoration:  BoxDecoration(
                                                              color: Colors.blue,
                                                              borderRadius: BorderRadius.circular(12),
                                                            ),
                                                            child: const Center(
                                                              child: AppText(text: "     ",
                                                                fontSize: 8,
                                                                color: Colors.white,),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 20,),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                );
                              }
                              if(snapshot.data!=null && snapshot.data!.isNotEmpty){
                                return SizedBox(
                                  width: Get.width,
                                  height: Get.height*0.75,
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (BuildContext context, int index){
                                        var order = snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 60,
                                                decoration: const BoxDecoration(
                                                    color: AppColors.textColor,
                                                    borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(15),
                                                        topRight: Radius.circular(15))
                                                ),
                                                child: Row(
                                                  children: const [
                                                    SizedBox(width: 10,),
                                                    AppText(text: "Order# 588425 (1/1)",
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                                                width: double.infinity,
                                                height: 410,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: AppColors.borderColor,width: 2),
                                                  borderRadius: const BorderRadius.only(
                                                      bottomRight: Radius.circular(15),
                                                      bottomLeft: Radius.circular(15)),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const AppText(text: "Total Amount",
                                                          color: AppColors.textColor,
                                                          fontWeight: FontWeight.w500,),
                                                        const Spacer(),
                                                        AppText(text: "Rs. ${order.orderItems![0].unitPrice}",
                                                          fontWeight: FontWeight.w500,color: AppColors.textColor,),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8,),
                                                    const Divider(color: AppColors.borderColor,thickness: 2,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                border:Border.all(color: AppColors.textColor,width: 2),
                                                                color: Colors.white,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 2,
                                                              height: 50,
                                                              color: AppColors.textColor,
                                                            ),
                                                            Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                border:Border.all(color: AppColors.textColor,width: 2),
                                                                color: AppColors.textColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children:  [
                                                            const  AppText(text: "  Supplier",
                                                              fontSize: 15,
                                                              color: AppColors.textColor,fontWeight: FontWeight.w500,),
                                                            AppText(text: "  ${order.orderItems![0].product!.owner ==null
                                                                ?"-":order.orderItems![0].product!.owner!.firstName}",
                                                              color: AppColors.textColor,),
                                                            const SizedBox(height: 17),
                                                            Row(
                                                              children: [
                                                                const AppText(text: "  Customer", fontSize: 15,
                                                                  color: AppColors.textColor,fontWeight: FontWeight.w500,),
                                                                const SizedBox(width: 180,),
                                                                Image.asset("assets/whatsapp.png",width: 40,height: 40,),

                                                              ],
                                                            ),
                                                            AppText(text: "  ${order.user?.firstName}",
                                                              color: AppColors.textColor,),
                                                            AppText(text: "  ${order.shippingAddress?.phoneNo}",
                                                              color: AppColors.textColor,),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children:  [
                                                          Row(
                                                            children: [
                                                              AppText(text: " house number: ${order.shippingAddress?.phoneNo},",
                                                                color: AppColors.textColor,
                                                                fontSize: 12,
                                                              ),
                                                              Flexible(
                                                                child: AppText(text: " street number: ${order.shippingAddress?.streetNo},",
                                                                  color: AppColors.textColor,
                                                                  fontSize: 12,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              AppText(text: " sector: ${order.shippingAddress?.block},",
                                                                color: AppColors.textColor,
                                                                fontSize: 12,
                                                              ),
                                                              Flexible(
                                                                child: AppText(text: " Mashoor jagha: ${order.shippingAddress?.nearestLandmark}",
                                                                  color: AppColors.textColor,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider(color: AppColors.borderColor,thickness: 2,),
                                                    ListTile(
                                                      leading: ClipRRect(
                                                        borderRadius: BorderRadius.circular(10),
                                                        child: ImageLoader(imageUrl: "${Urls.productsImageUrl}${order.orderItems![0].product!.images![0]}",)
                                                      ),
                                                      title: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          GetBuilder<AllProductsController>(
                                                              init:AllProductsController(),
                                                              builder: (_){
                                                                return  InkWell(
                                                                    onTap:(){
                                                                      AppNavigations.to(context,
                                                                          nextScreen:  ProgressOrder(
                                                                            prodPrice: "${order.orderItems![0].unitPrice}",
                                                                            prodProfit: "${order.orderItems![0].userProfit}",
                                                                            prodQuantity:order.orderItems![0].qty!.toInt(),
                                                                            prodTitle: order.orderItems![0].product!.description.toString(),
                                                                            image: "${Urls.productsImageUrl}${order.orderItems![0].product!.images![0]}",
                                                                          ));
                                                                    },
                                                                    child: const AppText(text: "Cancel Item >",
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight.w500,
                                                                      color: Colors.red,
                                                                    ));
                                                              }),
                                                          AppText(text: "Item ID : ${order.orderItems![0].sId}",color: AppColors.orderTextColor,fontSize: 8,),
                                                          Container(
                                                              height: 20,
                                                              width: double.infinity,
                                                              child: AppText(text: order.orderItems![0].product!.description.toString(),fontSize: 13,color: AppColors.textColor,)),
                                                          AppText(text: "Profit: ${order.orderItems![0].userProfit}",
                                                            fontSize: 13,color: Colors.black26,fontWeight: FontWeight.w500,),
                                                        ],
                                                      ),
                                                      trailing:AppText(text: "x${order.orderItems![0].qty}",
                                                        fontSize: 20,color: AppColors.textColor,fontWeight: FontWeight.w600,),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 28.0),
                                                      child: Align(
                                                        alignment: Alignment.center,
                                                        child: Container(
                                                          width: 150,
                                                          height: 30,
                                                          decoration:  BoxDecoration(
                                                            color: AppColors.primaryColor,
                                                            borderRadius: BorderRadius.circular(12),
                                                          ),
                                                          child: const Center(
                                                            child: AppText(text: "Awaiting Stock Confirmation",
                                                              fontSize: 8,
                                                              color: Colors.white,),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 20,),
                                            ],
                                          ),
                                        );
                                      }),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 30,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 300,
                                      width: double.infinity,
                                      child: Center(
                                        child: Image.asset("assets/images/poster4.png"),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const AppText(
                                      text: "No Orders Placed yet ",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const AppText(
                                      overflow: TextOverflow.visible,
                                      maxLines: null,
                                      fontSize: 13,
                                      text:
                                      "Explore and promote products to your customers. Once they like something, place orders and let us take care of the rest!",
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    AppButton(
                                      onTap: () {
                                        AppNavigations.off(
                                          context,
                                          nextScreen: MainPage(
                                            currentIndex: 2,
                                          ),
                                        );
                                      },
                                      text: "Explore Products",
                                      textColor: AppColors.roundButtonColor,
                                      borderColor: AppColors.borderColor,
                                      btnColor: Theme.of(context).scaffoldBackgroundColor,
                                    ),
                                  ],
                                ),
                              );
                            }),
                      // if(_.selectedIndex == 0)
                      //   GetBuilder<ProductDetailsViewController>(
                      //         init: ProductDetailsViewController(),
                      //         builder: (controller){
                      //           if(_.ordersList.isNotEmpty){
                      //             return  SizedBox(
                      //               width: Get.width,
                      //               height: Get.height*0.75,
                      //               child:_.loading.value
                      //                   ?Shimmer.fromColors(
                      //                 baseColor: Colors.grey[300]!,
                      //                 highlightColor: Colors.grey[100]!,
                      //                 child:  ListView.builder(
                      //                     itemCount: _.ordersList.length,
                      //                     itemBuilder: (BuildContext context, int index){
                      //                       return Padding(
                      //                         padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      //                         child: Column(
                      //                           children: [
                      //                             Container(
                      //                               width: double.infinity,
                      //                               height: 60,
                      //                               decoration: const BoxDecoration(
                      //                                   color: AppColors.textColor,
                      //                                   borderRadius: BorderRadius.only(
                      //                                       topLeft: Radius.circular(15),
                      //                                       topRight: Radius.circular(15))
                      //                               ),
                      //                               child: Row(
                      //                                 children: const [
                      //                                   SizedBox(width: 10,),
                      //                                   AppText(text: "            ",
                      //                                     color: Colors.white,
                      //                                     fontWeight: FontWeight.w500,),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                             Container(
                      //                               padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      //                               width: double.infinity,
                      //                               height: 410,
                      //                               decoration: BoxDecoration(
                      //                                 border: Border.all(color: AppColors.borderColor,width: 2),
                      //                                 borderRadius: const BorderRadius.only(
                      //                                     bottomRight: Radius.circular(15),
                      //                                     bottomLeft: Radius.circular(15)),
                      //                               ),
                      //                               child: Column(
                      //                                 mainAxisAlignment: MainAxisAlignment.start,
                      //                                 crossAxisAlignment: CrossAxisAlignment.start,
                      //                                 children: [
                      //                                   Row(
                      //                                     mainAxisAlignment: MainAxisAlignment.start,
                      //                                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                                     children: const [
                      //                                       AppText(text:  "        ",
                      //                                         color: AppColors.textColor,
                      //                                         fontWeight: FontWeight.w500,),
                      //                                       Spacer(),
                      //                                       AppText(text: "   ",
                      //                                         fontWeight: FontWeight.w500,color: AppColors.textColor,),
                      //                                     ],
                      //                                   ),
                      //                                   const SizedBox(height: 8,),
                      //                                   const Divider(color: AppColors.borderColor,thickness: 2,),
                      //                                   Row(
                      //                                     mainAxisAlignment: MainAxisAlignment.start,
                      //                                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                                     children: [
                      //                                       Column(
                      //                                         children: [
                      //                                           Container(
                      //                                             width: 20,
                      //                                             height: 20,
                      //                                             decoration: BoxDecoration(
                      //                                               shape: BoxShape.circle,
                      //                                               border:Border.all(color: AppColors.textColor,width: 2),
                      //                                               color: Colors.white,
                      //                                             ),
                      //                                           ),
                      //                                           Container(
                      //                                             width: 2,
                      //                                             height: 50,
                      //                                             color: AppColors.textColor,
                      //                                           ),
                      //                                           Container(
                      //                                             width: 20,
                      //                                             height: 20,
                      //                                             decoration: BoxDecoration(
                      //                                               shape: BoxShape.circle,
                      //                                               border:Border.all(color: AppColors.textColor,width: 2),
                      //                                               color: AppColors.textColor,
                      //                                             ),
                      //                                           ),
                      //                                         ],
                      //                                       ),
                      //                                       Column(
                      //                                         mainAxisAlignment: MainAxisAlignment.start,
                      //                                         crossAxisAlignment: CrossAxisAlignment.start,
                      //                                         children:  [
                      //                                           const  AppText(text: "    ",
                      //                                             fontSize: 15,
                      //                                             color: AppColors.textColor,fontWeight: FontWeight.w500,),
                      //                                           const AppText(text: "        ",
                      //                                             color: AppColors.textColor,),
                      //                                           const SizedBox(height: 17),
                      //                                           Row(
                      //                                             children: [
                      //                                               const AppText(text: "      ", fontSize: 15,
                      //                                                 color: AppColors.textColor,fontWeight: FontWeight.w500,),
                      //                                               const SizedBox(width: 180,),
                      //                                               Image.asset("assets/whatsapp.png",width: 40,height: 40,),
                      //
                      //                                             ],
                      //                                           ),
                      //                                         ],
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                   const Divider(color: AppColors.borderColor,thickness: 2,),
                      //                                   ListTile(
                      //                                     leading: ClipRRect(
                      //                                       borderRadius: BorderRadius.circular(10),
                      //                                       // child: Image.network(AppConstants.dummyImage,),
                      //                                       child: Image.network(AppConstants.dummyImage),
                      //                                     ),
                      //                                     title: Column(
                      //                                       mainAxisAlignment: MainAxisAlignment.start,
                      //                                       crossAxisAlignment: CrossAxisAlignment.start,
                      //                                       children: const [
                      //                                         AppText(text: "  "),
                      //                                         AppText(text: "    ",),
                      //                                         AppText(text: "   ",),
                      //                                       ],
                      //                                     ),
                      //                                     trailing:const AppText(text: "    ",),
                      //                                   ),
                      //                                   Padding(
                      //                                     padding: const EdgeInsets.only(left: 28.0),
                      //                                     child: Align(
                      //                                       alignment: Alignment.center,
                      //                                       child: Container(
                      //                                         width: 150,
                      //                                         height: 30,
                      //                                         decoration:  BoxDecoration(
                      //                                           color: Colors.blue,
                      //                                           borderRadius: BorderRadius.circular(12),
                      //                                         ),
                      //                                         child: const Center(
                      //                                           child: AppText(text: "     ",
                      //                                             fontSize: 8,
                      //                                             color: Colors.white,),
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                             const SizedBox(height: 20,),
                      //                           ],
                      //                         ),
                      //                       );
                      //                     }),
                      //               ):
                      //                  ListView.builder(
                      //                   itemCount: _.ordersList.length,
                      //                   itemBuilder: (BuildContext context, int index){
                      //                     var order = _.ordersList[index];
                      //                     return Padding(
                      //                       padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      //                       child: Column(
                      //                         children: [
                      //                           Container(
                      //                             width: double.infinity,
                      //                             height: 60,
                      //                             decoration: const BoxDecoration(
                      //                                 color: AppColors.textColor,
                      //                                 borderRadius: BorderRadius.only(
                      //                                     topLeft: Radius.circular(15),
                      //                                     topRight: Radius.circular(15))
                      //                             ),
                      //                             child: Row(
                      //                               children: const [
                      //                                 SizedBox(width: 10,),
                      //                                 AppText(text: "Order# 588425 (1/1)",
                      //                                   color: Colors.white,
                      //                                   fontWeight: FontWeight.w500,),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                           Container(
                      //                             padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                      //                             width: double.infinity,
                      //                             height: 410,
                      //                             decoration: BoxDecoration(
                      //                               border: Border.all(color: AppColors.borderColor,width: 2),
                      //                               borderRadius: const BorderRadius.only(
                      //                                   bottomRight: Radius.circular(15),
                      //                                   bottomLeft: Radius.circular(15)),
                      //                             ),
                      //                             child: Column(
                      //                               mainAxisAlignment: MainAxisAlignment.start,
                      //                               crossAxisAlignment: CrossAxisAlignment.start,
                      //                               children: [
                      //                                 Row(
                      //                                   mainAxisAlignment: MainAxisAlignment.start,
                      //                                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                                   children: [
                      //                                     const AppText(text: "Total Amount",
                      //                                       color: AppColors.textColor,
                      //                                       fontWeight: FontWeight.w500,),
                      //                                     const Spacer(),
                      //                                     AppText(text: "Rs. ${_.ordersList[index].orderItems![0].unitPrice}",
                      //                                       fontWeight: FontWeight.w500,color: AppColors.textColor,),
                      //                                   ],
                      //                                 ),
                      //                                 const SizedBox(height: 8,),
                      //                                 const Divider(color: AppColors.borderColor,thickness: 2,),
                      //                                 Row(
                      //                                   mainAxisAlignment: MainAxisAlignment.start,
                      //                                   crossAxisAlignment: CrossAxisAlignment.start,
                      //                                   children: [
                      //                                     Column(
                      //                                       children: [
                      //                                         Container(
                      //                                           width: 20,
                      //                                           height: 20,
                      //                                           decoration: BoxDecoration(
                      //                                             shape: BoxShape.circle,
                      //                                             border:Border.all(color: AppColors.textColor,width: 2),
                      //                                             color: Colors.white,
                      //                                           ),
                      //                                         ),
                      //                                         Container(
                      //                                           width: 2,
                      //                                           height: 50,
                      //                                           color: AppColors.textColor,
                      //                                         ),
                      //                                         Container(
                      //                                           width: 20,
                      //                                           height: 20,
                      //                                           decoration: BoxDecoration(
                      //                                             shape: BoxShape.circle,
                      //                                             border:Border.all(color: AppColors.textColor,width: 2),
                      //                                             color: AppColors.textColor,
                      //                                           ),
                      //                                         ),
                      //                                       ],
                      //                                     ),
                      //                                     Column(
                      //                                       mainAxisAlignment: MainAxisAlignment.start,
                      //                                       crossAxisAlignment: CrossAxisAlignment.start,
                      //                                       children:  [
                      //                                         const  AppText(text: "  Supplier",
                      //                                           fontSize: 15,
                      //                                           color: AppColors.textColor,fontWeight: FontWeight.w500,),
                      //                                         AppText(text: "  ${order.orderItems![0].product!.owner ==null
                      //                                             ?"-":order.orderItems![0].product!.owner!.firstName}",
                      //                                           color: AppColors.textColor,),
                      //                                         const SizedBox(height: 17),
                      //                                         Row(
                      //                                           children: [
                      //                                             const AppText(text: "  Customer", fontSize: 15,
                      //                                               color: AppColors.textColor,fontWeight: FontWeight.w500,),
                      //                                             const SizedBox(width: 180,),
                      //                                             Image.asset("assets/whatsapp.png",width: 40,height: 40,),
                      //
                      //                                           ],
                      //                                         ),
                      //                                         AppText(text: "  ${order.user?.firstName}",
                      //                                           color: AppColors.textColor,),
                      //                                         AppText(text: "  ${order.shippingAddress?.phoneNo}",
                      //                                           color: AppColors.textColor,),
                      //                                       ],
                      //                                     ),
                      //                                   ],
                      //                                 ),
                      //                                 Padding(
                      //                                   padding: const EdgeInsets.only(left: 20.0),
                      //                                   child: Column(
                      //                                     mainAxisAlignment: MainAxisAlignment.start,
                      //                                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                                     children:  [
                      //                                       Row(
                      //                                         children: [
                      //                                           AppText(text: " house number: ${order.shippingAddress?.phoneNo},",
                      //                                             color: AppColors.textColor,
                      //                                             fontSize: 12,
                      //                                           ),
                      //                                           Flexible(
                      //                                             child: AppText(text: " street number: ${order.shippingAddress?.streetNo},",
                      //                                               color: AppColors.textColor,
                      //                                               fontSize: 12,
                      //                                               overflow: TextOverflow.ellipsis,
                      //                                             ),
                      //                                           ),
                      //                                         ],
                      //                                       ),
                      //                                       Row(
                      //                                         children: [
                      //                                           AppText(text: " sector: ${order.shippingAddress?.block},",
                      //                                             color: AppColors.textColor,
                      //                                             fontSize: 12,
                      //                                           ),
                      //                                           Flexible(
                      //                                             child: AppText(text: " Mashoor jagha: ${order.shippingAddress?.nearestLandmark}",
                      //                                               color: AppColors.textColor,
                      //                                               fontSize: 12,
                      //                                             ),
                      //                                           ),
                      //                                         ],
                      //                                       ),
                      //                                     ],
                      //                                   ),
                      //                                 ),
                      //                                 const Divider(color: AppColors.borderColor,thickness: 2,),
                      //                                 ListTile(
                      //                                   leading: ClipRRect(
                      //                                     borderRadius: BorderRadius.circular(10),
                      //                                     // child: Image.network(AppConstants.dummyImage,),
                      //                                     child: Image.network("${Urls.productsImageUrl}${order.orderItems![0].product!.images![0]}"),
                      //                                   ),
                      //                                   title: Column(
                      //                                     mainAxisAlignment: MainAxisAlignment.start,
                      //                                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                                     children: [
                      //                                       GetBuilder<AllProductsController>(
                      //                                           init:AllProductsController(),
                      //                                           builder: (_){
                      //                                             return  InkWell(
                      //                                                 onTap:(){
                      //                                                   AppNavigations.to(context,
                      //                                                       nextScreen:  ProgressOrder(
                      //                                                         prodPrice: "${order.orderItems![0].unitPrice}",
                      //                                                         prodProfit: "${order.orderItems![0].userProfit}",
                      //                                                         prodQuantity:order.orderItems![0].qty!.toInt(),
                      //                                                         prodTitle: order.orderItems![0].product!.description.toString(),
                      //                                                         image: order.orderItems![0].product!.images![0],
                      //                                                       ));
                      //                                                 },
                      //                                                 child: const AppText(text: "Cancel Item >",
                      //                                                   fontSize: 13,
                      //                                                   fontWeight: FontWeight.w500,
                      //                                                   color: Colors.red,
                      //                                                 ));
                      //                                           }),
                      //                                       AppText(text: "Item ID : ${order.orderItems![0].sId}",color: AppColors.orderTextColor,fontSize: 8,),
                      //                                       Container(
                      //                                           height: 20,
                      //                                           width: double.infinity,
                      //                                           child: AppText(text: order.orderItems![0].product!.description.toString(),fontSize: 13,color: AppColors.textColor,)),
                      //                                       AppText(text: "Profit: ${order.orderItems![0].userProfit}",
                      //                                         fontSize: 13,color: Colors.black26,fontWeight: FontWeight.w500,),
                      //                                     ],
                      //                                   ),
                      //                                   trailing:AppText(text: "x${order.orderItems![0].qty}",
                      //                                     fontSize: 20,color: AppColors.textColor,fontWeight: FontWeight.w600,),
                      //                                 ),
                      //                                 Padding(
                      //                                   padding: const EdgeInsets.only(left: 28.0),
                      //                                   child: Align(
                      //                                     alignment: Alignment.center,
                      //                                     child: Container(
                      //                                       width: 150,
                      //                                       height: 30,
                      //                                       decoration:  BoxDecoration(
                      //                                         color: AppColors.primaryColor,
                      //                                         borderRadius: BorderRadius.circular(12),
                      //                                       ),
                      //                                       child: const Center(
                      //                                         child: AppText(text: "Awaiting Stock Confirmation",
                      //                                           fontSize: 8,
                      //                                           color: Colors.white,),
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                           const SizedBox(height: 20,),
                      //                         ],
                      //                       ),
                      //                     );
                      //                   }),
                      //             );
                      //           }
                      //             if(_.ordersList.isEmpty){
                      //             return Padding(
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 30,
                      //               ),
                      //               child: Column(
                      //                 children: [
                      //                   SizedBox(
                      //                     height: 300,
                      //                     width: double.infinity,
                      //                     child: Center(
                      //                       child: Image.asset("assets/images/poster4.png"),
                      //                     ),
                      //                   ),
                      //                   const SizedBox(
                      //                     height: 15,
                      //                   ),
                      //                   const AppText(
                      //                     text: "No Orders Placed yet ",
                      //                     fontSize: 17,
                      //                     fontWeight: FontWeight.w500,
                      //                   ),
                      //                   const SizedBox(
                      //                     height: 15,
                      //                   ),
                      //                   const AppText(
                      //                     overflow: TextOverflow.visible,
                      //                     maxLines: null,
                      //                     fontSize: 13,
                      //                     text:
                      //                     "Explore and promote products to your customers. Once they like something, place orders and let us take care of the rest!",
                      //                   ),
                      //                   const SizedBox(
                      //                     height: 15,
                      //                   ),
                      //                   AppButton(
                      //                     onTap: () {
                      //                       AppNavigations.off(
                      //                         context,
                      //                         nextScreen: MainPage(
                      //                           currentIndex: 2,
                      //                         ),
                      //                       );
                      //                     },
                      //                     text: "Explore Products",
                      //                     textColor: AppColors.roundButtonColor,
                      //                     borderColor: AppColors.borderColor,
                      //                     btnColor: Theme.of(context).scaffoldBackgroundColor,
                      //                   ),
                      //                 ],
                      //               ),
                      //             );
                      //           }
                      //            else{
                      //             return const Center();
                      //           }
                      //         }),
                    ],
                  );
                },
              ),
            ),
        ),
      ),
    );
  }
}
