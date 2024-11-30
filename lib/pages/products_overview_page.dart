import 'package:f08_eshop_app/pages/request_page.dart';
import 'package:flutter/material.dart';

import '../components/product_grid.dart';
import '../utils/app_routes.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewPage extends StatefulWidget {
  ProductsOverviewPage({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showOnlyFavorites = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Minha Loja'),
        leading: IconButton(
          icon: Icon(Icons.shopping_cart), // Ícone do carrinho
          onPressed: () {
            // Navega para a tela CartItemsPage ao clicar no ícone
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RequestPage()),
            );
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                );
              },
              icon: Icon(Icons.add)),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  //provider.showFavoriteOnly();
                  _showOnlyFavorites = true;
                } else {
                  //provider.showAll();
                  _showOnlyFavorites = false;
                }
              });
            },
          ),
        ],
      ),
      body: ProductGrid(_showOnlyFavorites),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.CART_SCREEN);
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
    );
  }
}
