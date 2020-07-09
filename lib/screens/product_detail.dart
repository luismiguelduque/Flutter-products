import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetail extends StatelessWidget {

  static const routName = "product-detail";

  @override
  Widget build(BuildContext context) {

    final productId = ModalRoute.of(context).settings.arguments as String;
    final productsData = Provider.of<Products>(context, listen: false);
    final product = productsData.findById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}