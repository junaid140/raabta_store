// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:markaz_clone/constants/app_colors.dart';
import 'package:markaz_clone/services/form_fields_focus.dart';
import 'package:markaz_clone/views/main_page/views/cart_address/cart_address_page.dart';
import 'package:markaz_clone/widgets/country_state_city_picker.dart';
import 'package:markaz_clone/utils/app_navigations.dart';
import 'package:markaz_clone/widgets/app_button.dart';
import 'package:markaz_clone/widgets/app_formfield.dart';
import 'package:markaz_clone/widgets/app_text.dart';
import 'package:markaz_clone/widgets/my_app_bar.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constants/app_spacings.dart';
import '../../../../controllers/address_page_controller/new_address_controller.dart';
import '../../../../controllers/cities_controller/cities_controllers.dart';
import '../../../../modals/cart_modals/cart_modal.dart';
import '../../../../modals/cities_modal/cities_modals.dart';

class EditCartAddress extends StatefulWidget {
  final String addressId;
  final List<CartItem> cartItem;
  EditCartAddress({Key? key,
    this.addressId='',
   required this.cartItem,
  }) : super(key: key);

  @override
  State<EditCartAddress> createState() => _EditCartAddressState();
}

class _EditCartAddressState extends State<EditCartAddress> {
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
      child: SafeArea(
        child: Scaffold(
          appBar: MyAppBar(
            title: const AppText(text: "Edit your  address",fontSize: 14,),
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
          body: GetBuilder<NewAddressController>(
            init: NewAddressController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key:_key,
                      child: Container(
                        padding:AppSpacings.defaultPadding,
                        child: Column(
                          children:  [
                            AppFormfield(
                              focusNode: controller.name,
                              controller: controller.nameController,
                              hintText: "Customer Name",
                              hintFontSize: 13.0,
                              labelText: "Customer Name",
                              labelFontSize: 13.0,
                              onFieldSubmitted: (value){
                                FormFieldFocusNode.
                                focusField(context, controller.name, controller.number);
                              },
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Please enter name"
                                    : null;
                              },
                            ),
                            const  SizedBox(height: 10,),
                            AppFormfield(
                              focusNode: controller.number,
                              controller: controller.phoneController,
                              hintText: "Phone Number",
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "number is required";
                                }
                                if(controller.isPakistaniPhoneNumber(value)){
                                  return "Please enter valid phone number";
                                }
                                return  null;
                              },
                              hintFontSize: 13.0,
                              labelText: "Phone Number",
                              labelFontSize: 13.0,
                              onFieldSubmitted: (value){
                                FormFieldFocusNode.
                                focusField(context, controller.number, controller.house);
                              },
                            ),
                            const   SizedBox(height: 10,),
                            AppFormfield(
                              focusNode: controller.house,
                              controller: controller.houseController,
                              hintText: "House/Makan/Apartment Number",
                              hintFontSize: 13.0,
                              labelText: "House/Makan/Apartment Number",
                              labelFontSize: 13.0,
                              onFieldSubmitted: (value){
                                FormFieldFocusNode.
                                focusField(context, controller.house, controller.street);
                              },
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Please enter House Number"
                                    : null;
                              },
                            ),
                            const   SizedBox(height: 10,),
                            AppFormfield(
                              focusNode: controller.street,
                              controller: controller.streetController,
                              hintText: "Street/Gali Number/Road Name",
                              hintFontSize: 13.0,
                              labelText: "Street/Gali Number/Road Name",
                              labelFontSize: 13.0,
                              onFieldSubmitted: (value){
                                FormFieldFocusNode.
                                focusField(context, controller.street, controller.sector);
                              },
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Please enter street number"
                                    : null;
                              },
                            ),
                            const  SizedBox(height: 10,),
                            AppFormfield(
                              focusNode: controller.sector,
                              controller: controller.sectorController,
                              hintText: "Sector/Block/Area Name",
                              hintFontSize: 13.0,
                              labelText: "Sector/Block/Area Name",
                              labelFontSize: 13.0,
                              onFieldSubmitted: (value){
                                FormFieldFocusNode.
                                focusField(context, controller.sector, controller.landMarks);
                              },
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Please enter sector name"
                                    : null;
                              },
                            ),
                            const  SizedBox(height: 10,),
                            AppFormfield(
                              focusNode: controller.landMarks,
                              controller: controller.landMarkController,
                              hintText: "Nearest Landmark/Mashoor Jagha",
                              hintFontSize: 13.0,
                              labelText: "Nearest Landmark/Mashoor Jagha",
                              labelFontSize: 13.0,
                              onFieldSubmitted: (value){
                                FormFieldFocusNode.
                                focusField(context, controller.landMarks, controller.areaFocus);
                              },
                              validator: (value) {
                                return value!.isEmpty
                                    ? "Please enter nearest landmarks"
                                    : null;
                              },
                            ),

                            const SizedBox(height: 10,),
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
                                    ? "Please enter city"
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
                                height: 40,
                                width: double.infinity,
                                margin:
                                const EdgeInsets.only(left: 2, right: 2),
                                decoration: const BoxDecoration(
                                  color: Color(0xff01bc87),
                                ),
                              ),
                            )
                                : Column(
                              children: [
                                // TextFormField(
                                //   onChanged: (value) {
                                //     setState(() {
                                //       cities = cities!
                                //           .where((city) =>
                                //           city.name!.toLowerCase().contains(value.toLowerCase()))
                                //           .toList();
                                //     });
                                //   },
                                //   decoration: InputDecoration(
                                //     labelText: 'Search City',
                                //     border: OutlineInputBorder(),
                                //   ),
                                // ),
                                // SizedBox(height: 10),
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
                                    labelText: 'Select an area',
                                    border: OutlineInputBorder(),
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
                            const SizedBox(height: 40,),
                            InkWell(
                              onTap: controller.isEnabled?()async{
                                await  controller.upDateAddress(
                                  widget.addressId,
                                  controller.nameController.text.toString(),
                                  controller.phoneController.text.toString(),
                                  controller.houseController.text.toString(),
                                  controller.streetController.text.toString(),
                                  controller.sectorController.text.toString(),
                                  controller.landMarkController.text.toString(),
                                  controller.city.text.toString(),
                                  selectedCityName ?? '',
                                  selectedCityId??'',
                                ).then((value) {
                                  AppNavigations.off(context, nextScreen: CartAddAddress(
                                    cartItems: widget.cartItem,
                                  ));
                                  controller.nameController.clear();
                                  controller.phoneController.clear();
                                  controller.houseController.clear();
                                  controller.streetController.clear();
                                  controller.sectorController.clear();
                                  controller.landMarkController.clear();
                                });
                              }:null,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                width: Get.width,
                                height: 55.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: controller.isEnabled?AppColors.primaryColor:Colors.black12,
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
                                    text: "Next",
                                    color:  Colors.white,
                                    fontSize:  17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
