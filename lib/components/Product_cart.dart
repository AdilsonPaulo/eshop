// ignore_for_file: prefer_const_constructors

import 'package:f08_eshop_app/model/cart.dart';
import 'package:f08_eshop_app/model/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCart extends StatelessWidget{
  final item_quant product;

  const ProductCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Cart>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(product.item.title),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: (){
              provider.addProduct(product.item);
            }, icon: Icon(Icons.add_circle_outlined, color: Colors.pink,)),
            SizedBox(
              width: 10,
            ),
            Text(product.quantidade.toString()),
            SizedBox(
              width: 10,
            ),
            IconButton(onPressed: (){
              if(product.quantidade == 1){
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirmação"),
                    content: Text('Deseja remover esse produto do carrinho?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Remover'),
                        onPressed: () {
                          provider.removeProduct(product.item);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
                );
              }
              else{
                provider.removeProduct(product.item);
              }
            }, icon: Icon(Icons.remove_circle_outlined, color: Colors.pink,))
          ],
        )
      ],
    );
  }

}