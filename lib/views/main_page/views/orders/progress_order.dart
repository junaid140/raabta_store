import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import '../../../../constants/app_constants.dart';
import '../../../../constants/app_spacings.dart';
import '../../../../controllers/cancelOrder_controller/cancel_order_controller.dart';

class ProgressOrder extends StatelessWidget {
  final String prodTitle;
  final String prodPrice;
  final int? prodQuantity;
  final String prodProfit;
  final String image;
  const ProgressOrder({Key? key,
    this.prodTitle='',
    this.prodPrice='',
    this.prodQuantity ,
  this.prodProfit= '',
    this.image = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          leading: InkWell(onTap: (){
           Navigator.pop(context);
          },
            child: const Icon(Icons.arrow_back_rounded,color: AppColors.textColor,),
          ),
          title: const AppText(text: "Cancel Order",fontSize: 14,fontWeight: FontWeight.w500,),
          centerTitle: false,
        ),
        body: Container(
          padding: AppSpacings.defaultPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: AppColors.gradientBorder
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),
                    Container(
                      height: 80,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: NetworkImage(image),fit: BoxFit.cover)
                      ),
                    ),
                    SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width:Get.width*0.5,
                            child: AppText(text: prodTitle,fontSize: 13,color: AppColors.textColor,fontWeight: FontWeight.w500,)),
                        AppText(text: int.parse(prodPrice.toString()).toStringAsFixed(1),color: Colors.blue,
                          fontWeight: FontWeight.w500,fontSize: 13,),
                        AppText(text: "Quality: $prodQuantity",fontSize: 13,color: AppColors.orderTextColor,),
                        AppText(text: "Profit: $prodProfit",fontSize: 13,color: AppColors.orderTextColor,),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              const AppText(text: "What is the biggest reason for your wish to cancel?",
                fontSize: 11,fontWeight: FontWeight.w600,color: AppColors.textColor,),
              const SizedBox(height: 10,),
              GetBuilder<CancelOrderController>(
                  init: CancelOrderController(),
                  builder: (_){
                return Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            value: _.value1, onChanged: (newValue){
                          _.setValue1(newValue);
                          _.setValue2(false);
                          _.setValue3(false);
                          _.setValue4(false);
                          _.setValue5(false);
                          _.setValue6(false);
                        }),
                        AppText(text: "Ghalati se order kardiya",
                          fontSize: 13,color: AppColors.textColor,),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            value: _.value2, onChanged: (newValue){
                          _.setValue2(newValue);
                          _.setValue1(false);
                          _.setValue3(false);
                          _.setValue4(false);
                          _.setValue5(false);
                          _.setValue6(false);
                        }),
                        const AppText(text: "Ghalat item order kardiya",
                          fontSize: 13,color: AppColors.textColor,),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            value: _.value3, onChanged: (newValue){
                          _.setValue3(newValue);
                          _.setValue2(false);
                          _.setValue1(false);
                          _.setValue4(false);
                          _.setValue5(false);
                          _.setValue6(false);
                        }),
                        AppText(text: "Customer ne cancel kardiya",fontSize: 13,color: AppColors.textColor,),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            value: _.value4, onChanged: (newValue){
                          _.setValue3(false);
                          _.setValue2(false);
                          _.setValue1(false);
                          _.setValue4(newValue);
                          _.setValue5(false);
                          _.setValue6(false);
                        }),
                        const AppText(text: "Ghalat quantity",fontSize: 13,color: AppColors.textColor,),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            value: _.value5, onChanged: (newValue){
                          _.setValue3(false);
                          _.setValue2(false);
                          _.setValue1(false);
                          _.setValue4(false);
                          _.setValue5(newValue);
                          _.setValue6(false);
                        }),
                        const AppText(text: "Test order",fontSize: 13,color: AppColors.textColor,),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            value: _.value6, onChanged: (newValue){
                          _.setValue3(false);
                          _.setValue2(false);
                          _.setValue1(false);
                          _.setValue4(false);
                          _.setValue5(false);
                          _.setValue6(newValue);
                        }),
                        const AppText(text: "Other",fontSize: 13,color: AppColors.textColor,),
                      ],
                    ),
                    const SizedBox(height: 100,),
                    const AppButton(text: "Cancel",fontSize: 14,)
                  ],
                );
              }),
            ],
          ),
        ),
        ),
      ),
    ),);
  }
}
