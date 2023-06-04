import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_spacings.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../controllers/cart_controller/cart_controllers.dart';
import '../../../../modals/cart_modals/cart_modal.dart';
import '../single_product_details/product_details_view.dart';
import '../../main_page.dart';
import '../cart_address/cart_address_page.dart';
import 'cart_manager.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
    CartRep cartRep = CartRep(prefs: SharedPreferences.getInstance());

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar:  MyAppBar(
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_rounded,color: AppColors.textColor,),
            ),
            isPaddingEnable: false,
            title: const AppText(text: 'Cart',
              color: AppColors.textColor,fontWeight: FontWeight.w500,fontSize: 17,),
            centerTitle: false,
          ),
          body: FutureBuilder<List<CartItem>>(
            future: cartRep.getCartItems(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  padding: AppSpacings.defaultPadding,
                  child:   const Center(child: CircularProgressIndicator(),),
                );
              }
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                final cartItems = snapshot.data!;
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return GetBuilder<CartController>(
                            init: CartController(),
                            builder: (controller){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        controller.changeSelectedValue(index);
                                        AppNavigations.to(context,
                                            nextScreen: ProductDetailsView(
                                          productId: cartItem.id,
                                        ));
                                      },
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: GradientBoxBorder(
                                            width: 3,
                                            gradient: LinearGradient(
                                                colors: index == controller.isSelected.value
                                                    ? [Colors.green, Colors.yellow]
                                                    : [Colors.black12, Colors.black12
                                                ]),
                                          ),

                                        ),
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  height: 80,
                                                  decoration:  BoxDecoration(
                                                      image:  DecorationImage(image: NetworkImage("${cartItem.imageUrl}"),fit: BoxFit.cover),
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                ),
                                                const SizedBox(height: 10,),
                                                InkWell(
                                                  onTap: (){
                                                    cartRep.removeFromCart(cartItem);
                                                    setState(() {});
                                                  },
                                                  child: Row(
                                                    children:const  [
                                                      Icon(Icons.delete_outline_rounded,color: AppColors.textColor,size: 17,),
                                                      AppText(text: " Remove",
                                                        color: AppColors.textColor,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 13,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 30,),
                                            SizedBox(
                                              width: 200,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AppText(text: "Name: ${cartItem.title}",
                                                    color: AppColors.textColor,
                                                    fontWeight: FontWeight.w500,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  const AppText(text: "Size:",
                                                    color: AppColors.orderTextColor,
                                                    fontSize: 13,fontWeight: FontWeight.w500,),
                                                  AppText(text: "Rs.${cartItem.price}",color: Colors.blue,fontWeight: FontWeight.w500,),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                  ],
                                ),
                              );
                            });
                      },
                    ),
                     Padding(
                       padding: const EdgeInsets.only(
                         bottom: 30,
                         left: 15,
                         right: 15,
                       ),
                       child: AppButton(
                         fontSize: 14,
                         text: "Order Now",
                         onTap: (){
                           AppNavigations.to(context, nextScreen: CartAddAddress(cartItems: cartItems, ));
                       },),
                     ),
                  ],
                );
              }
              else{
                return Padding(
                  padding: AppSpacings.defaultPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/cart.png",height:200,width: 200,),
                      const SizedBox(height: 70,),
                      const AppText(text: 'No items in cart',
                        fontWeight: FontWeight.bold,fontSize: 22,color: AppColors.textColor,),
                      const SizedBox(height: 20,),
                      AppButton(
                        onTap: () {
                          AppNavigations.off(
                            context,
                            nextScreen: MainPage(
                              currentIndex: 2,
                            ),
                          );
                        },
                        text: "Check items",
                        textColor: AppColors.roundButtonColor,
                        borderColor: AppColors.borderColor,
                        btnColor: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
