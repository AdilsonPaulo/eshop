import 'package:f08_eshop_app/model/product.dart';

class item_quant {
  final String id;
  int quantidade;
  final Product item;

  item_quant({
    required this.quantidade,
    required this.item,
  }):id = item.id;

  Map<String, dynamic> toJson() {
    return {
      'quantidade': quantidade,
      'item': item.toJson(),
    };
  }

  factory item_quant.fromJson(Map<String, dynamic> json) {
  var itemJson = json['item'];
  var productId = itemJson != null && itemJson['name'] != null ? itemJson['name'] : ''; 

  return item_quant(
    quantidade: json['quantidade'],
    item: Product.fromJson(productId, itemJson ?? {}),
  );
}

}