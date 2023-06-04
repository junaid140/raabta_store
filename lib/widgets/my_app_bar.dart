import 'package:flutter/material.dart';
import 'package:markaz_clone/constants/app_constants.dart';
import 'app_text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final Widget? title, leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool isPaddingEnable;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  const MyAppBar({
    Key? key,
    this.actions,
    this.height = 50,
    this.title,
    this.leading,
    this.centerTitle,
    this.isPaddingEnable = false,
    this.automaticallyImplyLeading = false,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isPaddingEnable
          ? const EdgeInsets.symmetric(
              horizontal: 10,
            )
          : null,
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        centerTitle: centerTitle ?? true,
        leading: leading,
        elevation: 0,
        backgroundColor: Colors.transparent,
        bottom: bottom,
        title: title ??
            const AppText(
              text: AppConstants.appName,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
