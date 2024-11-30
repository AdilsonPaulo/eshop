import 'dart:convert';
import 'dart:math';
import 'package:f08_eshop_app/model/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:f08_eshop_app/model/request.dart';

class RequestList with ChangeNotifier{
  final _baseUrl = 'https://ddm20242-5edc3-default-rtdb.firebaseio.com/';
  
  List<Request> _requests = [];

  List<Request> get requests => [..._requests];

   Future<void> fetchRequests() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/requests.json'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<Request> loadedRequests = [];

        data.forEach((id, requestData) {
          loadedRequests.add(
            Request.fromJson(id, requestData),
          );
        });

        _requests = loadedRequests;
        notifyListeners();
      } else {
        throw Exception("Falha ao buscar os dados do servidor");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addRequest(Request request) async {
    try {
      final response = await http.post(
        Uri.parse(('$_baseUrl/requests.json')),
        headers: {"Content-Type": "application/json"},
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 200) {
        final id = json.decode(response.body)['name'];
        final newRequest = Request(
          id: id,
          produtos: request.produtos,
          value: request.value,
          address: request.address,
        );

        _requests.add(newRequest);
        notifyListeners();
      } else {
        throw Exception("Falha ao adicionar o request");
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> editRequest(Request request) async {
  Map<String, dynamic> requestData = {
    'id': request.id,
    'produtos': request.produtos.map((item) => item.toJson()).toList(),
    'value': request.value,
    'address': request.address,
  };

  try {
    var response = await http.patch(
      Uri.parse('$_baseUrl/requests/${request.id}.json'),
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception("Erro ao editar requisição");
    }
  } catch (e) {
    throw e;
  }
}

  Future<void> saveRequest(Map<String, Object> data) {
  bool hasId = data['id'] != null;

  final request = Request(
    id: hasId ? data['id'] as String : Random().nextDouble().toString(),
    produtos: (data['produtos'] as List)
        .map((item) => item_quant.fromJson(item as Map<String, dynamic>))
        .toList(),
    value: data['value'] as double,
    address: data['address'] as String,
  );

  if (hasId) {
    // Se já tem id, faça a atualização (implementação fictícia de updateRequest)
    return editRequest(request);
  } else {
    return addRequest(request);
  }
}
}