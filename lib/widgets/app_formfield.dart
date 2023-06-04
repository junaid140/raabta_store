import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:pinput/pinput.dart';

class AppFormfield extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final String? hintText, labelText;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String value)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final int? maxLength;
  final double? hintFontSize;
  final double? labelFontSize;
  final FocusNode? focusNode;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  AppFormfield({
    Key? key,
    this.controller,
    this.onSaved,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.contentPadding,
    this.onFieldSubmitted,
    this.validator,
    this.maxLength,
    this.labelText,
    this.hintFontSize,
    this.labelFontSize,
    this.focusNode,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onSaved: onSaved,
      maxLength: maxLength,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        labelStyle: GoogleFonts.poppins(fontSize: labelFontSize),
        labelText: labelText,
        prefixIcon: prefixIcon,
        counter: const SizedBox(),
        hintStyle: GoogleFonts.poppins(fontSize: hintFontSize),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      onChanged:onChanged,
    );
  }
}

class AppPinField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final void Function(String)? onCompleted;

  const AppPinField({
    super.key,
    this.validator,
    this.onCompleted,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(
          fontSize: 20,
          color: const Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(10),
    );

    return Pinput(
      controller: controller,
      textInputAction: TextInputAction.next,
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: defaultPinTheme,
      validator: validator,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: onCompleted,
    );
  }
}
