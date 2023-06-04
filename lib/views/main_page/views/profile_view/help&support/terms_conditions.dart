import 'package:flutter/material.dart';
import 'package:markaz_clone/constants/app_colors.dart';

import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/my_app_bar.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: const AppText(
              text: "Terms and Conditions",
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
            padding: const EdgeInsets.all(18),
            child: Column(
              children: const [
                AppText(
                  text: "Terms And Conditios",
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 30,
                ),
                AppText(
                  text:
                      "Adipisicing ut dolore aliquip irure cupidatat velit nisi tempor. Dolore ullamco exercitation deserunt ipsum sint dolore. Officia mollit sit occaecat deserunt pariatur esse nulla id. Cupidatat mollit duis elit ex ea occaecat sunt commodo elit cupidatat aliqua aute consequat officia. Anim et anim nostrud occaecat veniam velit duis ullamco nostrud eiusmod do cillum duis.",
                  overflow: TextOverflow.visible,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
