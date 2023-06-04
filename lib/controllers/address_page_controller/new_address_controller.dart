import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:markaz_clone/utils/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:markaz_clone/widgets/get_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../modals/addres_modals/get_address_modal.dart';
import '../../modals/addres_modals/new_address_modal.dart';
import '../../modals/addres_modals/update_address_modal.dart';

class NewAddressController extends GetxController{

  int selectedIndex = 0;
  changeIndex(int index) {
    selectedIndex = index;
    update();
  }

  bool isClicked = false;
  setBoolValue(newValue){
    isClicked = newValue;
    update();
  }


  String countryValue = '';
  String stateValue  = '';
  String cityValue = '' ;
  setCountryValue (String value){
    countryValue =value;
    update();
  }
  setStateValue (String value){
    stateValue =value;
    update();
  }
  setCityValue (String value){
    cityValue =value;
    update();
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController sectorController = TextEditingController();
  TextEditingController landMarkController = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController city = TextEditingController();
  final name = FocusNode();
  final number = FocusNode();
  final house = FocusNode();
  final street = FocusNode();
  final sector = FocusNode();
  final landMarks = FocusNode();
  final cityFocus = FocusNode();
  final cityIdFocus = FocusNode();
  final areaFocus = FocusNode();
  bool isPakistaniPhoneNumber(String phone) {
    RegExp regExp = RegExp(r'^\03\d{10}$');
    return regExp.hasMatch(phone);
  }

  bool isEnabled = false;
  @override
  void onInit() {
    super.onInit();
    nameController.addListener(onTextChange);
    phoneController.addListener(onTextChange);
    houseController.addListener(onTextChange);
    streetController.addListener(onTextChange);
    sectorController.addListener(onTextChange);
    landMarkController.addListener(onTextChange);
    city.addListener(onTextChange);
    getAddressController;
  }

  void onTextChange(){
    isEnabled = nameController.text.isNotEmpty;
    isEnabled = phoneController.text.isNotEmpty;
    isEnabled = houseController.text.isNotEmpty;
    isEnabled = streetController.text.isNotEmpty;
    isEnabled = sectorController.text.isNotEmpty;
    isEnabled = landMarkController.text.isNotEmpty;
    isEnabled = city.text.isNotEmpty;
    update();
  }
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    houseController.dispose();
    phoneController.dispose();
    sectorController.dispose();
    streetController.dispose();
    landMarkController.dispose();
    name.dispose();
    house.dispose();
    number.dispose();
    street.dispose();
    sector.dispose();
    landMarks.dispose();
    city.dispose();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value){
    _isLoading= value;
    update();
  }
  Future<PostAddressModal?> newAddressController(
    String user,
    String customerName,
    String phoneNo,
    String houseNo,
    String streetNo,
    String block,
    String nearestLandmark,
    String city,
      String area,
      String cityId
  )async{
    setLoading(true);
    try{
      setLoading(true);
      var url = Uri.parse(Urls.newAddressUrl);
      var token = await GetToken().getToken();
      final response =await http.post(url,
          body: jsonEncode(<String, String>{
            'user': user,
            'customerName': customerName,
            'phoneNo': phoneNo,
            'houseNo': houseNo,
            'streetNo': streetNo,
            'block': block,
            'nearestLandmark': nearestLandmark,
            'city': city,
            'area':area,
            'cityId':cityId
          }),
          headers: {
            "Authorization":"Bearer $token",
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if(response.statusCode==200){
        setLoading(false);
        return PostAddressModal.fromJson(json.decode(response.body));

      }else{
        setLoading(false);
        debugPrint(response.body);
        return throw Exception("Failed");
      }
    }catch(e){
      setLoading(false);
      debugPrint(e.toString());
    }
    setLoading(false);
    return null;

  }


  RxInt isSelected = RxInt(-1);

  Future<void> changeSelectedValue(int index)async {
    isSelected.value = index;
    selectedAddress.value = myAddressList.value.data?.docs?[index];
    selectedContainer = true;
    onSelectedValue();
    update();
  }
  var selectedAddress = Rx<Docs?>(null);
  bool selectedContainer = false;
  onSelectedValue(){
    selectedContainer = isSelected.value.isGreaterThan(-1);
    update();
  }

  var myAddressList = GetMyAddressModal().obs;
  Future<List<Docs>> getAddressController(String keyword)async{
    var token = await GetToken().getToken();
   var response = await http.get(Uri.parse("${Urls.myAddressUrl}?keyword=$keyword"),headers: {
     "Authorization":"Bearer $token",
     "Content-Type":"application/json",
   });
   if(response.statusCode== 200){
     var data = GetMyAddressModal.fromJson(json.decode(response.body));
     myAddressList.value = data;
     return data.data?.docs??[];
   }else{
     debugPrint(response.body);
      throw Exception("Failed");

   }
  }

  Future<UpdateAddressModal?> upDateAddress(
      String id,
      String customerName,
      String phoneNo,
      String houseNo,
      String streetNo,
      String block,
      String nearestLandmark,
      String city,
      String area,
      String cityId
      )async{
    try{
      setLoading(true);
      final token = await GetToken().getToken();
      SharedPreferences pref = await SharedPreferences.getInstance();
      var userId = pref.getString("userId");
      final response = await http.put(Uri.parse("${Urls.newAddressUrl}/$id"),headers: {
        "Authorization":"Bearer $token",
        'Content-Type': 'application/json',
      },
        body: json.encode({
          "user":userId,
          "phoneNo":phoneNo,
          "houseNo":houseNo,
          "streetNo":streetNo,
          "block":block,
          "nearestLandmark":nearestLandmark,
          "city":city,
          "area":area,
          "cityId":cityId,
        }),

      );
      if(response.statusCode==200){
        setLoading(false);
        debugPrint(response.body);
        final data = UpdateAddressModal.fromJson(json.decode(response.body));
        myAddressList.refresh();
        return data;
      }else{
        setLoading(false);
        debugPrint(response.body);
      }
    }catch(e){
      setLoading(false);
      debugPrint(e.toString());
    }
    setLoading(false);
    return null;
  }
}