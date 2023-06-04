import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/controllers/main_page_controllers/main_page_controller.dart';
import 'package:markaz_clone/views/main_page/views/cart_view/cart_page.dart';
import 'package:markaz_clone/views/main_page/views/notification_view/notification_page.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import '../../utils/app_navigations.dart';

// ignore: must_be_immutable
class MainPage extends StatefulWidget {
  int currentIndex;
  MainPage({
    Key? key,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: GetBuilder<MainPageController>(
            init: MainPageController(),
            builder: (controller) {
              return Scaffold(
                appBar:  MyAppBar(
                        centerTitle: false,
                        actions: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  AppNavigations.to(context, nextScreen: NotificationsPage());
                                },
                                icon: const Icon(
                                  Icons.notifications_none_rounded,
                                  color: Colors.black,
                                ),
                              ),
                              InkWell(
                                  onTap: (){
                                    AppNavigations.to(context, nextScreen: const CartScreen());
                                  },
                                  child:const Icon(Icons.add_shopping_cart,color: AppColors.textColor,)),
                            ],
                          ),
                        ],
                      ),
                body: controller.mainPageViews[widget.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: widget.currentIndex,
                  onTap: (value) {
                    setState(() {
                      widget.currentIndex = value;
                    });
                  },
                  selectedItemColor: AppColors.primaryColor,
                  unselectedItemColor: Colors.grey,
                  showUnselectedLabels: true,
                  selectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w500
                  ),
                  unselectedLabelStyle: GoogleFonts.poppins(
                    fontSize: 10,
                  ),
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.category,
                      ),
                      label: "Category",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                      ),
                      label: "Search",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.book_online,
                      ),
                      label: "Orders",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person,
                      ),
                      label: "Profile",
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
