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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.price.toString(), 
              style: TextStyle(
                color: Colors.grey, 
                fontSize: 20
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              width: double.infinity,
              child: Text(
                product.description, 
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}