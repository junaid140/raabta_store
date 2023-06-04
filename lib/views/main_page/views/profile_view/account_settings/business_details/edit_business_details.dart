import 'package:flutter/material.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_formfield.dart';

import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/my_app_bar.dart';

class EditBusinessDetails extends StatelessWidget {
  EditBusinessDetails({Key? key}) : super(key: key);
  final TextEditingController businessName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: const AppText(
              text: "Edit Business Details",
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
          body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                AppFormfield(
                  controller: businessName,
                  prefixIcon: const Icon(
                    Icons.business_center_rounded,
                    color: Colors.grey,
                  ),
                  hintText: "BusinessName",
                  contentPadding: const EdgeInsets.all(5),
                ),
                const SizedBox(
                  height: 5,
                ),
                AppFormfield(
                  controller: address,
                  prefixIcon: const Icon(
                    Icons.location_on_sharp,
                    color: Colors.grey,
                  ),
                  hintText: "Address",
                  contentPadding: const EdgeInsets.all(5),
                ),
                const SizedBox(
                  height: 5,
                ),
                AppFormfield(
                  controller: city,
                  prefixIcon: const Icon(
                    Icons.location_city_rounded,
                    color: Colors.grey,
                  ),
                  hintText: "City",
                  contentPadding: const EdgeInsets.all(5),
                ),
                const Spacer(),
                AppButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: "Done",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
