import 'dart:async';
import 'dart:convert';

import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../Shared/api.dart';
import '../Shared/user_preferences.dart';
import '../Model/product_model.dart';

class ProductProviders with ChangeNotifier {
  Timer? _debounce;
  String keyword = '';
  List<DataProduct> _product = [];
  List<DataProduct> get product => _product.where(
        (element) {
          if (keyword.isEmpty) {
            return true;
          }
          return element.name!.toLowerCase().contains(keyword.toLowerCase());
        },
      ).toList();

  String _resMessage = '';

  String get resMessage => _resMessage;

  set products(List<DataProduct> products) {
    _product = products;
    notifyListeners();
  }

  void search(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(
      const Duration(milliseconds: 300),
      () {
        keyword = query;
        notifyListeners();
      },
    );
  }

  Future<void> getProduct({
    BuildContext? context,
  }) async {
    final token = await UserPreferences().getToken();
    var url = Uri.parse(
      Api.product,
    );
    var headers = {
      'Content-type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    try {
      Response req = await get(
        url,
        headers: headers,
      );
      if (req.statusCode == 200) {
        List data = jsonDecode(req.body)['data'];
        List<DataProduct> product = [];
        for (var item in data) {
          product.add(DataProduct.fromJson(item));
        }
        _product = product;
        notifyListeners();
      }
    } catch (e) {
      _resMessage = e.toString();
      DInfo.dialogError(context!, _resMessage);
      DInfo.closeDialog(context);
      notifyListeners();
    }
  }
}
