// ignore_for_file: sort_child_properties_last

import 'package:f08_eshop_app/model/cart.dart';
import 'package:f08_eshop_app/model/product_list.dart';
import 'package:f08_eshop_app/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    //PEGANDO CONTEUDO PELO PROVIDERct>();

    return ClipRRect(
      //corta de forma arredondada o elemento de acordo com o BorderRaius
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onLongPress: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirmação"),
                    content: Text('Deseja adicionar esse item ao carrinho?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Adicionar'),
                        onPressed: () {
                          Provider.of<Cart>(
                            context,
                            listen: false,
                          ).addProduct(product);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
                );
          },
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {
              //adicionando metodo ao clique do botão
              product.toggleFavorite();
              Provider.of<ProductList>(
                context,
                listen: false,
              ).editProduct(product);
            },
            //icon: Icon(Icons.favorite),
            //pegando icone se for favorito ou não
            icon: Consumer<Product>(
              builder: (context, product, child) => Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
            //isFavorite ? Icons.favorite : Icons.favorite_border),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              onPressed: () { 
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Confirmação"),
                    content: Text('Deseja remover esse item da loja?'),
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
                          Provider.of<ProductList>(context, listen: false).removeProduct(product);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
                );},
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
