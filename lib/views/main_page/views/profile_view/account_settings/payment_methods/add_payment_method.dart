import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/main_page/views/profile_view/account_settings/payment_methods/payment_method.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_formfield.dart';
import 'package:markaz_clone/widgets/flutter_toast.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../../../controllers/payment_methods/payment_method_controller.dart';
import '../../../../../../modals/payment_modals/payment_modal.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/my_app_bar.dart';
import 'otp_page.dart';

class AddPaymentMethod extends StatelessWidget {

  AddPaymentMethod({Key? key}) : super(key: key);
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: MyAppBar(height: 55,
            title: const AppText(
              text: "Add Details",
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 14,
            ),
            centerTitle: false,
            leading: IconButton(
              onPressed: () {
                AppNavigations.off(context, nextScreen: const PaymentMethod());
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            isPaddingEnable: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: CircularPercentIndicator(
                  addAutomaticKeepAlive: true,
                  animation: true,
                  radius: 25.0,
                  lineWidth: 3.0,
                  percent: 0.50,
                  center:  const AppText(text: "1 of 2",fontSize: 13,color: AppColors.orderTextColor,),
                  progressColor: Colors.green,
                ),
              ),
            ],
          ),
          body: GetBuilder<PaymentMethodController>(
            init: PaymentMethodController(),
            builder: (controller){
              return Container(
                padding: AppSpacings.defaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(text: "Select your Payment Method",color: AppColors.textColor,fontWeight: FontWeight.w500,),
                    const SizedBox(height: 10,),
                    InkWell(
                      onTap: ()  {controller.upDatedIndex(0);},
                      child: Container(
                        width: double.infinity,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: controller.selectedContainerIndex == 0
                                ?Colors.green
                                :Colors.black12,
                                width: 2
                            )
                        ),
                        child:  Center(
                          child: ListTile(
                            leading: Container(
                              height: 100,
                              width: 70,
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image:const DecorationImage(image: AssetImage("assets/easyPaisa.png"),fit: BoxFit.cover)
                              ),
                            ),
                            title:const AppText(text: "Easypaisa",fontWeight: FontWeight.w500,),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    InkWell(
                      onTap: () {controller.upDatedIndex(1);},
                      child: Container(
                        width:double.infinity,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: controller.selectedContainerIndex ==1
                              ?Colors.green
                              :Colors.black12,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child:  ListTile(
                            leading: Container(
                              height: 100,
                              width: 70,
                              decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image:const DecorationImage(image: AssetImage("assets/jazzcash.png"),fit: BoxFit.cover)
                              ),
                            ),
                            title: const AppText(text: "JazzCash",fontWeight: FontWeight.w500,),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    const AppText(text: "Account details",color: AppColors.textColor,fontWeight: FontWeight.w500,),
                    const SizedBox(height: 20,),
                     Form(
                       key: _key,
                       child: AppFormfield(maxLength: 11,
                         keyboardType: TextInputType.number,
                         controller: controller.accountController,
                        labelText: "Account number",
                        labelFontSize: 13,
                        hintText: "Account number",
                        hintFontSize: 13,
                         validator: (value){
                           return value!.isEmpty?
                               "Please enter your phone number"
                               :null;
                         },
                    ),
                     ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(text: "Set as Default",color: AppColors.textColor,fontWeight: FontWeight.w500,),
                        Switch(value: controller.value, onChanged: (newValue){
                          controller.upDatedBoolValue(newValue);
                        })
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: AppButton(text: "Continue",onTap: (){
                        if(_key.currentState!.validate()&& (controller.selectedContainerIndex==0 || controller.selectedContainerIndex == 1)){
                          AppNavigations.off(context, nextScreen: OTPPage(
                            number: controller.accountController.text.toString(),
                            image:controller.selectedContainerIndex==0?"assets/easyPaisa.png":"assets/jazzcash.png" ,
                            name: controller.selectedContainerIndex==0?"Easypaisa":"JazzCash",
                          ));
                        }else{
                          ToastMessage.showMessage("Invalid Phone Number");
                        }
                      },),
                    ),
                  ],
                ),
              );
            },),
        ),
      ),
    );
  }
}
