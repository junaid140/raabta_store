
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/modals/cart_modals/cart_modal.dart';
import 'package:markaz_clone/modals/cities_modal/cities_modals.dart';
import 'package:markaz_clone/services/form_fields_focus.dart';
import 'package:markaz_clone/widgets/app_formfield.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/flutter_toast.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constants/app_spacings.dart';
import '../../../../controllers/address_page_controller/new_address_controller.dart';
import '../../../../controllers/cities_controller/cities_controllers.dart';
import 'cart_old_address.dart';

class CartAddAddress extends StatefulWidget {

  final List<CartItem> cartItems;

  CartAddAddress({
    Key? key,
     required this.cartItems,
  }) : super(key: key);

  @override
  State<CartAddAddress> createState() => _CartAddAddressState();
}

class _CartAddAddressState extends State<CartAddAddress> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GetAllCities getAllCities = Get.put(GetAllCities());
  List<Docs>? cities;
  String? selectedCityId;
  String? selectedCityName;

  @override
  void initState() {
    super.initState();
    fetchCities();
  }

  Future<void> fetchCities() async {
    final citiesData = await getAllCities.getCities();
    if (citiesData != null) {
      setState(() {
        cities = citiesData.data?.docs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primaryColor,
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: MyAppBar(height: 80,
              title: const AppText(
                text: "Enter Address",
                fontSize: 14,
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
              bottom: TabBar(
                dividerColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                labelColor: Colors.black,
                indicatorColor: Colors.black,
                tabs: const [
                  AppText(text: "New",fontWeight: FontWeight.w500,),
                  AppText(text: "Old",fontWeight: FontWeight.w500,),
                ],
              ),
            ),
            body: GetBuilder<NewAddressController>(
              init: NewAddressController(),
              builder: (controller) {
                return TabBarView(
                  children: [
                    // For new address
                    SingleChildScrollView(
                      child: Form(
                        key: _key,
                        child: Container(
                          padding: AppSpacings.defaultPadding,
                          child: Column(
                            children: [
                              AppFormfield(
                                focusNode: controller.name,
                                controller:
                                controller.nameController,
                                hintText: "Customer Name",
                                hintFontSize: 13.0,
                                labelText: "Customer Name",
                                labelFontSize: 13.0,
                                onFieldSubmitted: (value) {
                                  FormFieldFocusNode.focusField(
                                      context,
                                      controller.name,
                                      controller.number);
                                },
                                validator: (value) {
                                  return value!.isEmpty
                                      ? "Please enter name"
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppFormfield(
                                focusNode: controller.number,
                                controller:
                                controller.phoneController,
                                hintText: "Phone Number",
                                keyboardType:
                                TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "number is required";
                                  }
                                  if (controller
                                      .isPakistaniPhoneNumber(
                                      value)) {
                                    return "Please enter valid phone number";
                                  }
                                  return null;
                                },
                                hintFontSize: 13.0,
                                labelText: "Phone Number",
                                labelFontSize: 13.0,
                                onFieldSubmitted: (value) {
                                  FormFieldFocusNode.focusField(
                                      context,
                                      controller.number,
                                      controller.house);
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppFormfield(
                                focusNode: controller.house,
                                controller:
                                controller.houseController,
                                hintText:
                                "House/Makan/Apartment Number",
                                hintFontSize: 13.0,
                                labelText:
                                "House/Makan/Apartment Number",
                                labelFontSize: 13.0,
                                onFieldSubmitted: (value) {
                                  FormFieldFocusNode.focusField(
                                      context,
                                      controller.house,
                                      controller.street);
                                },
                                validator: (value) {
                                  return value!.isEmpty
                                      ? "Please enter House Number"
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppFormfield(
                                focusNode: controller.street,
                                controller:
                                controller.streetController,
                                hintText:
                                "Street/Gali Number/Road Name",
                                hintFontSize: 13.0,
                                labelText:
                                "Street/Gali Number/Road Name",
                                labelFontSize: 13.0,
                                onFieldSubmitted: (value) {
                                  FormFieldFocusNode.focusField(
                                      context,
                                      controller.street,
                                      controller.sector);
                                },
                                validator: (value) {
                                  return value!.isEmpty
                                      ? "Please enter street number"
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppFormfield(
                                focusNode: controller.sector,
                                controller:
                                controller.sectorController,
                                hintText:
                                "Sector/Block/Area Name",
                                hintFontSize: 13.0,
                                labelText:
                                "Sector/Block/Area Name",
                                labelFontSize: 13.0,
                                onFieldSubmitted: (value) {
                                  FormFieldFocusNode.focusField(
                                      context,
                                      controller.sector,
                                      controller.landMarks);
                                },
                                validator: (value) {
                                  return value!.isEmpty
                                      ? "Please enter sector name"
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppFormfield(
                                focusNode: controller.landMarks,
                                controller:
                                controller.landMarkController,
                                hintText:
                                "Nearest Landmark/Mashoor Jagha",
                                hintFontSize: 13.0,
                                labelText:
                                "Nearest Landmark/Mashoor Jagha",
                                labelFontSize: 13.0,
                                onFieldSubmitted: (value) {
                                  FormFieldFocusNode.focusField(
                                      context,
                                      controller.landMarks,
                                      controller.areaFocus);

                                },
                                validator: (value) {
                                  return value!.isEmpty
                                      ? "Please enter nearest landmarks"
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppFormfield(
                                focusNode: controller.areaFocus,
                                controller:
                                controller.city,
                                hintText:
                                "City",
                                hintFontSize: 13.0,
                                labelText:
                                "City",
                                labelFontSize: 13.0,
                                onFieldSubmitted: (value) {
                                  FormFieldFocusNode.focusField(
                                      context,
                                      controller.areaFocus,
                                      controller.cityIdFocus);
                                },
                                validator: (value) {
                                  return value!.isEmpty
                                      ? "Please enter area"
                                      : null;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              cities == null
                                  ? Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  margin:
                                  const EdgeInsets.only(left: 2, right: 2),
                                  decoration:  BoxDecoration(
                                      color: Color(0xff01bc87),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              )
                                  : Column(
                                children: [
                                  DropdownButtonFormField<Docs>(

                                    items: cities!
                                        .map<DropdownMenuItem<Docs>>(
                                          (doc) => DropdownMenuItem<Docs>(
                                        value: doc,
                                        child: Text(doc.name ?? ''),
                                      ),
                                    )
                                        .toList(),
                                    onChanged: (selectedCity) {
                                      setState(() {
                                        selectedCityId = selectedCity?.id;
                                        selectedCityName = selectedCity?.name;
                                      });
                                    },
                                    value: cities!.isNotEmpty ? cities![0] : null,
                                    decoration: InputDecoration(
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
                                      labelText: 'Select a area',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                    ),

                                    validator: (val){
                                      if(val==null){
                                        return "Select any area";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onTap: controller.isEnabled ? () async{
                                  SharedPreferences
                                  pref = await SharedPreferences.getInstance();
                                  var getUserId = pref.getString("userId");
                                  if (_key.currentState!.validate()) {
                                    controller.newAddressController(
                                      getUserId.toString(),
                                      controller.nameController.text.toString(),
                                      controller.phoneController.text.toString(),
                                      controller.houseController.text.toString(),
                                      controller.streetController.text.toString(),
                                      controller.streetController.text.toString(),
                                      controller.landMarkController.text.toString(),
                                      controller.city.text.toString(),
                                      selectedCityName ?? '',
                                      selectedCityId??'',
                                    ).then((value) {
                                      ToastMessage.showMessage("Address successfully created ");
                                    }).onError((error, stackTrace) {
                                      ToastMessage.showMessage("Something went wrong!");
                                    });
                                  }
                                } : null,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  width: Get.width,
                                  height: 55.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: controller.isEnabled
                                        ? AppColors.primaryColor
                                        : Colors.black12,
                                  ),
                                  child: controller.isLoading?
                                  const Center(
                                    child: LoadingIndicator(
                                      indicatorType: Indicator.ballBeat,
                                      strokeWidth: 4,
                                      colors: [
                                        Colors.white,
                                        Colors.white,
                                        Colors.white,
                                      ],),
                                  )
                                      : const Center(
                                    child: AppText(
                                      text: "Save",
                                      color:  Colors.white,
                                      fontSize:  17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),


                    // For old Address

                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15,right: 15,top: 10),
                            child: AppFormfield(
                              controller:
                              controller.searchController,
                              prefixIcon:
                              Icon(Icons.search_rounded),
                              hintText: "Find an address...",
                              hintFontSize: 13,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: AppText(
                                text: "Customer Addresses",
                                color: AppColors.textColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          CartOldAddressView(
                            cartItems: widget.cartItems,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
