// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import '../../../../../../controllers/payment_methods/payment_method_controller.dart';
import '../../../../../../widgets/app_button.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/my_app_bar.dart';
import 'add_payment_method.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =Get.put(PaymentMethodController());
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(height: 90,
            title: const AppText(
              text: "Payment Methods",
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 14,
            ),
            centerTitle: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          body: Column(
            children: [
              FutureBuilder(
                  future: controller.allPaymentMethods(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting){
                      return AppText(text: "Loading");
                    }if(snapshot.hasData && snapshot.data!.data!.docs!=null){
                      return ListView.builder(
                        shrinkWrap: true,
                          itemCount: snapshot.data!.data!.docs!.length,
                          itemBuilder: (context,index){
                          var data = snapshot.data!.data!.docs![index];
                            return InkWell(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                                padding: AppSpacings.defaultPadding,
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: AppColors.borderColor,
                                      width: 2,
                                    )
                                ),
                                child: Center(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: AssetImage("assets/jazzcash.png"),
                                                fit: BoxFit.fill)
                                        ),
                                      ),
                                      const SizedBox(width: 20,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AppText(text: data.name.toString(),
                                            fontWeight: FontWeight.w500,),
                                          AppText(
                                            text: "032102679".toString(),
                                            color: AppColors.orderTextColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,),
                                        ],
                                      ),
                                      const SizedBox(width: 80,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap:()async{
                                              AppNavigations.off(context, nextScreen: AddPaymentMethod());
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: const [
                                                Icon(Icons.edit,
                                                  color: AppColors.orderTextColor,),
                                                AppText(text: "Edit",
                                                  color: AppColors.orderTextColor,),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],

                                  ),
                                ),
                              ),
                            );
                          });
                    }
                    return AppText(text: "Error");

                  }),

              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: AppButton(
                  width: MediaQuery.of(context).size.width*0.9,
                  onTap: () {
                    AppNavigations.off(context, nextScreen:  AddPaymentMethod());
                  },
                  borderColor: Colors.grey.withOpacity(0.7),
                  btnColor: Theme.of(context).scaffoldBackgroundColor,
                  textColor: Colors.black,
                  text: "Add payment method",
                ),
              ),
              // FutureBuilder<List<PaymentModal>>(
              //   future: cartRep.getCartItems(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     }
              //     if (snapshot.hasData) {
              //       final cartItems = snapshot.data!;
              //       return GetBuilder<PaymentMethodController>(
              //           init: PaymentMethodController(),
              //           builder: (controller){
              //             return Expanded(
              //               child: ListView.builder(
              //                 itemCount: cartItems.length,
              //                 itemBuilder: (context, index) {
              //                   final cartItem = cartItems[index];
              //                   return ;
              //                 },
              //               ),
              //             );
              //           });
              //     } else {
              //       return Column(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: [
              //           const SizedBox(height: 170,),
              //           SvgPicture.asset(
              //             "assets/wallet.svg",
              //             height: 150,
              //           ),
              //           const AppText(
              //             overflow: TextOverflow.visible,
              //             text:
              //             "No payment Method have been please add a payment method.",
              //           ),
              //           const SizedBox(
              //             height: 20,
              //           ),
              //         ],
              //       );
              //   }
              //   },
              // ),
            ],
          ),


          // Padding(
          //   padding: AppSpacings.defaultPadding,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       GetBuilder<OtpController>(
          //           init: OtpController(),
          //           builder:(controller){
          //             return Column(
          //               children: [
          //                 if(controller.isClicked == true)
          //                   Container(child: widget.container),
          //                 if(controller.isClicked== false)

          //               ],
          //             );
          //           } ),
          //       const Spacer(),
          //       Row(
          //         children: [
          //           AppButton(
          //             width: MediaQuery.of(context).size.width*0.9,
          //             onTap: () {
          //               AppNavigations.off(context, nextScreen:  AddPaymentMethod());
          //             },
          //             borderColor: Colors.grey.withOpacity(0.7),
          //             btnColor: Theme.of(context).scaffoldBackgroundColor,
          //             textColor: Colors.black,
          //             text: "Add payment method",
          //           ),
          //         ],
          //       )
          //     ],
          //   ),
          // ),
        ),
      ),
    );
  }
}
