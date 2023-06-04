// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:markaz_clone/widgets/flutter_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../modals/cart_modals/cart_modal.dart';


class CartRep {
  static const CART_KEY = 'cart';
  final Future<SharedPreferences> _prefs;


  CartRep({required Future<SharedPreferences> prefs}) : _prefs = prefs;

  Future<List<CartItem>> getCartItems() async {
    final prefs = await _prefs;
    final cartJson = prefs.getStringList(CART_KEY) ?? [];
    return cartJson.map((e) => CartItem.fromJson(jsonDecode(e))).toList();
  }

  Future<void> addToCart(CartItem cartItem) async {
    final prefs = await _prefs;
    final cartJson = prefs.getStringList(CART_KEY) ?? [];
    final cartList = cartJson.map((e) => CartItem.fromJson(jsonDecode(e))).toList();
    bool productExistsInCart = cartList.any((item) => item.id == cartItem.id);
    if(productExistsInCart){
      ToastMessage.showMessage("Product is already in the cart");
    }else{
      cartList.add(cartItem);
      final updatedCartJson = cartList.map((e) => jsonEncode(e)).toList();
      await prefs.setStringList(CART_KEY, updatedCartJson);
    }
  }

  Future<void> removeFromCart(CartItem cartItem) async {
    final prefs = await _prefs;
    final cartJson = prefs.getStringList(CART_KEY) ?? [];
    final cartList = cartJson.map((e) => CartItem.fromJson(jsonDecode(e))).toList();
    cartList.removeWhere((item) => item.id == cartItem.id);
    final updatedCartJson = cartList.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList(CART_KEY, updatedCartJson);
  }

  Future<void> clearCart() async {
    final prefs = await _prefs;
    await prefs.remove(CART_KEY);
  }

}
