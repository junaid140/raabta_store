import 'package:flutter/material.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? textColor, borderColor, btnColor;
  final double? borderRadius;

  final double? width, height, fontSize;
  const AppButton({
    Key? key,
    required this.text,
    this.borderRadius,
    this.onTap,
    this.btnColor,
    this.textColor,
    this.width,
    this.height,
    this.fontSize,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: width,
        height: height ?? 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius??10),
          color: btnColor ?? AppColors.primaryColor,
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: Center(
          child: AppText(
            text: text,
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final double? height, width, fontSize;
  final Color? btnColor, textColor, borderColor;
  final String text;
  final VoidCallback? onTap;
  final Widget? trailing;
  const RoundButton({
    super.key,
    this.btnColor,
    this.fontSize,
    this.height,
    required this.text,
    this.textColor,
    this.width,
    this.onTap,
    this.borderColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 40,
        width: width ?? 100,
        decoration: BoxDecoration(
          color: btnColor ?? AppColors.roundButtonColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: borderColor ?? AppColors.roundButtonColor,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: text,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: textColor ?? Colors.white,
              ),
              trailing ?? const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
