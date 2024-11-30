// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:f08_eshop_app/components/Product_cart.dart';
import 'package:f08_eshop_app/model/cart.dart';
import 'package:f08_eshop_app/model/request.dart';
import 'package:f08_eshop_app/model/request_list.dart';
import 'package:f08_eshop_app/utils/app_routes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemsPage extends StatelessWidget {
  const CartItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(builder: (context, carrinho, child) {
      return ListView.builder(
        itemCount: carrinho.items.length,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: ProductCart(product: carrinho.items.elementAt(index)));
        },
      );
    });
  }
}

class _CartTotal extends StatelessWidget {
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var hugeStyle =
        Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 48);

    return SizedBox(
      height: 200,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<Cart>(builder: (context, carrinho, child) {
              return Text(carrinho.total.toStringAsFixed(2), style: hugeStyle);
            }),
            const SizedBox(width: 24),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Informe o Endereço'),
                      content: TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Endereço',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancelar'),
                        ),
                        Consumer<Cart>(builder: (context, carrinho, child) {
                          return ElevatedButton(
                            onPressed: () {
                              if (addressController.text.isNotEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Confirmação'),
                                        content: Text(
                                            'Deseja enviar para esse endereço?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Provider.of<RequestList>(
                                                        context,
                                                        listen: false)
                                                    .addRequest(Request(
                                                        address:
                                                            addressController
                                                                .text,
                                                        id: '',
                                                        produtos:
                                                            carrinho.items,
                                                        value: carrinho.total));
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Sim')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Não')),
                                        ],
                                      );
                                    });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'O endereço não pode ser vazio!')),
                                );
                              }
                            },
                            child: Text('Confirmar'),
                          );
                        })
                      ],
                    );
                  },
                );
              },
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              child: const Text('COMPRAR'),
            ),
          ],
        ),
      ),
    );
  }
}
