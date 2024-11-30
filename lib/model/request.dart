import 'package:f08_eshop_app/model/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Request with ChangeNotifier {
  final String id;
  final List<item_quant> produtos;
  final double value;
  final String address;

  Request(
      {required this.id,
      required this.produtos,
      required this.value,
      required this.address});

   Request.fromRequest(Request _request)
      : id = _request.id,
        produtos = List.from(_request.produtos),
        value = _request.value,
        address = _request.address;

  Map<String, dynamic> toJson() {
    return {
      'produtos': produtos.map((item) => item.toJson()).toList(),
      'value': value,
      'address': address,
    };
  }

  factory Request.fromJson(String id, Map<String, dynamic> json) {
    return Request(
      id: id,
      produtos: (json['produtos'] as List<dynamic>)
          .map((item) => item_quant.fromJson(item))
          .toList(),
      value: json['value'],
      address: json['address'],
    );
  }
}
