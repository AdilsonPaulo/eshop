// ignore_for_file: prefer_const_constructors

import 'package:f08_eshop_app/model/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};
  String _title = '';
  double _price = 0.0;
  String _description = '';
  String _url = '';

  void _submitForm(Product product) {
    Provider.of<ProductList>(
      context,
      listen: false,
    ).editProduct(product).then((value) {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(product.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: product.imageUrl.isEmpty
                      ? Text('Informe a Url')
                      : Image.network(product.imageUrl),
                ),
                TextFormField(
                  initialValue: product.title.toString(),
                  decoration: InputDecoration(
                    labelText: 'Nome',
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _title = value ?? product.title;
                  },
                ),
                TextFormField(
                  initialValue: product.price.toString(),
                  decoration: InputDecoration(
                    labelText: 'Preço',
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _price = double.parse(value!) ?? product.price;
                  },
                ),
                TextFormField(
                  initialValue: product.description,
                  decoration: InputDecoration(
                    labelText: 'Descrição',
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _formData['description'] = value ?? product.description;
                  },
                ),
                TextFormField(
                  initialValue: product.imageUrl,
                  decoration: InputDecoration(
                    labelText: 'URL',
                  ),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    _url = value ?? product.imageUrl;
                  },
                ),
                ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.save();
                      Product edited = Product(
                          id: product.id,
                          title: _title,
                          description: _description,
                          price: _price,
                          isFavorite: product.isFavorite,
                          imageUrl: _url);
                      _submitForm(edited);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    child: Text(
                      "Concluído",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: product.isFavorite
          ? FloatingActionButton(
              backgroundColor: Colors.pink,
              onPressed: () {
                setState(() {
                  product.toggleFavorite();
                });
              },
              child: Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            )
          : FloatingActionButton(
              backgroundColor: Colors.pink,
              onPressed: () {
                setState(() {
                  product.toggleFavorite();
                });
              },
              child: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
            ),
    );
  }
}
