// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:math';

import 'package:f08_eshop_app/model/cart_items.dart';
import 'package:f08_eshop_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Cart with ChangeNotifier {
  List<item_quant> _cartItems = [];


  List<item_quant> get items {
    return [..._cartItems];
  }

  void addProduct(Product produto){
    try {
      var itemExistente = _cartItems.firstWhere((item) => item.item == produto);
      itemExistente.quantidade += 1;
    } catch (e) {
      _cartItems.add(item_quant(quantidade: 1, item: produto));
    }
    notifyListeners();
  }

  void removeProduct(Product produto){
      var itemExistente = _cartItems.firstWhere((item) => item.item == produto);
      itemExistente.quantidade -= 1;
      if(itemExistente.quantidade <= 0){
        _cartItems.remove(itemExistente);
      }
      
      notifyListeners();
  }

  double get total {
    if (_cartItems.isEmpty) {
      return 0.0;
    }
    return _cartItems
        .map<double>((item) => item.item.price*item.quantidade)
        .toList()
        .reduce((a, b) => a + b);
  }

}
