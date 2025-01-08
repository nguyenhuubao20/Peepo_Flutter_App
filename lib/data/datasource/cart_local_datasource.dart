import 'dart:convert';

import 'package:peefo/data/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartLocalDatasource {
  // ignore: constant_identifier_names
  static const String KEY_CART_ITEMS = 'cart_items';
  final SharedPreferences _prefs;

  CartLocalDatasource(this._prefs);

  Future<void> saveItems(List<CartItemModel> items) async {
    final List<String> jsonList =
        items.map((item) => jsonEncode(item.toJson())).toList();
    await _prefs.setStringList(KEY_CART_ITEMS, jsonList);
    print('Saved items: $jsonList');
  }

  Future<List<CartItemModel>> loadItems() async {
    final List<String>? jsonList = _prefs.getStringList(KEY_CART_ITEMS);
    if (jsonList == null) return [];

    return jsonList.map((jsonString) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return CartItemModel.fromJson(json);
    }).toList();
  }

  Future<void> clearStorage() async {
    await _prefs.remove(KEY_CART_ITEMS);
  }
}
