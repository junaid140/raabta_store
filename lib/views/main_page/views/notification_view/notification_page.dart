import 'package:flutter/material.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';

import '../../../../constants/app_colors.dart';


class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: AppColors.primaryColor,
    child: SafeArea(child: Scaffold(
      appBar:MyAppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: const Icon(Icons.arrow_back_rounded,color: AppColors.textColor,)),
        centerTitle: false,
        title: const AppText(
          text: "Notifications",fontWeight: FontWeight.w500,color: AppColors.textColor,),
      ),
      body: Column(
        children: const [
          ListTile(
            leading: CircleAvatar(),
            title: AppText(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
              text: "Aap ka lagaya hua order Supplier nay confirm\n kar dia hai.\n Markaz k sath karobar kerne ka shukariya",),
            subtitle: AppText(text: "Yesterday",color: AppColors.borderColor,),
          ),
        ],
      ),
    )));
  }
}
