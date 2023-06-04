import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/constants/app_constants.dart';
import 'package:markaz_clone/modals/follow_shops_modal/get_followed_shop_modal.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/views/main_page/main_page.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../controllers/follow_controller/follow_controllers.dart';
import '../../../../../utils/app_urls.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/my_app_bar.dart';

class FollowedShops extends StatelessWidget {
  const FollowedShops({
    Key? key,
    this.numberOfFollowedShops = 0,
  }) : super(key: key);
  final int numberOfFollowedShops;

  @override
  Widget build(BuildContext context) {
    final FollowController followedShop = Get.put(FollowController());
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: const AppText(
              text: "Followed Shops",
              fontWeight: FontWeight.w500,
              color: Colors.black,
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
          body: FutureBuilder<List<Docs>>(
              future: followedShop.getFollowedShops(),
              builder: (BuildContext context , snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                 return ListView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child:  ListTile(
                          leading:const CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            backgroundImage: NetworkImage(AppConstants.dummyImage),
                          ),
                          title: Container(
                            width: 300,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey,
                            ),
                          ),
                          subtitle: Container(
                            width: 100,
                            height: 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                if(snapshot.hasData&&snapshot.data!=null&&snapshot.data!.isNotEmpty){
                   return SizedBox(
                     width: double.infinity,
                     height: Get.height*0.9,
                     child: ListView.builder(
                         itemCount: snapshot.data!.length,
                         itemBuilder: (context,index){
                           var data = snapshot.data![index];
                           return ListTile(
                             onTap: () {},
                             leading:  CircleAvatar(
                               backgroundColor: AppColors.primaryColor,
                               backgroundImage: NetworkImage("${Urls.suppliers}${data.supplier!.image}"),
                             ),
                             title:  AppText(
                               text: "${data.supplier!.firstName} ${data.supplier!.lastName}",
                               color: AppColors.textColor,
                               fontWeight: FontWeight.w500,
                             ),
                             subtitle: AppText(
                               text: data.supplier!.email.toString(),
                             color: AppColors.orderTextColor,
                             ),
                           );
                         }),
                   );
                }
                return Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18.0,right: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/follow.png",height: 150,width: 150,),
                        const SizedBox(height: 20,),
                        const AppText(
                          text: "No Shop has been followed.",
                        ),
                        const SizedBox(
                          height: 30,
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
                          borderColor: Colors.grey.withOpacity(0.7),
                          btnColor: Theme.of(context).scaffoldBackgroundColor,
                          textColor: Colors.black,
                          text: "Explore Products",
                        )
                      ],
                    ),
                  ),
                );
              }),

        ),
      ),
    );
  }
}
