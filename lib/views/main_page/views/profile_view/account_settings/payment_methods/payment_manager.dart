import 'dart:convert';
import 'package:markaz_clone/modals/payment_modals/payment_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';



class PaymentManager {
  static const PAYMENT_KEY = 'payment';
  final Future<SharedPreferences> _prefs;

  PaymentManager({required Future<SharedPreferences> prefs}) : _prefs = prefs;

  Future<List<PaymentModal>> getCartItems() async {
    final prefs = await _prefs;
    final cartJson = prefs.getStringList(PAYMENT_KEY) ?? [];
    return cartJson.map((e) => PaymentModal.fromJson(jsonDecode(e))).toList();
  }

  Future<void> addToCart(PaymentModal paymentModal) async {
    final prefs = await _prefs;
    final cartJson = prefs.getStringList(PAYMENT_KEY) ?? [];
    final cartList = cartJson.map((e) => PaymentModal.fromJson(jsonDecode(e))).toList();
    cartList.add(paymentModal);
    final updatedCartJson = cartList.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList(PAYMENT_KEY, updatedCartJson);
  }

  Future<void> removeFromCart(PaymentModal paymentModal) async {
    final prefs = await _prefs;
    final cartJson = prefs.getStringList(PAYMENT_KEY) ?? [];
    final cartList = cartJson.map((e) => PaymentModal.fromJson(jsonDecode(e))).toList();
    cartList.removeWhere((item) => item.id == paymentModal.id);
    final updatedCartJson = cartList.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList(PAYMENT_KEY, updatedCartJson);
  }

  Future<void> editCartItem(PaymentModal editedItem) async {
    final prefs = await _prefs;
    final cartJson = prefs.getStringList(PAYMENT_KEY) ?? [];
    final cartList = cartJson.map((e) => PaymentModal.fromJson(jsonDecode(e))).toList();
    final index = cartList.indexWhere((item) => item.id == editedItem.id);
    if (index != -1) {
      cartList[index] = editedItem;
      final updatedCartJson = cartList.map((e) => jsonEncode(e)).toList();
      await prefs.setStringList(PAYMENT_KEY, updatedCartJson);
    }
  }
  Future<void> clearMethod() async {
    final prefs = await _prefs;
    await prefs.remove(PAYMENT_KEY);
  }

}
