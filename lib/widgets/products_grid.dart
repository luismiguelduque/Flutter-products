import 'package:flutter/material.dart';
import 'package:products_shop/providers/product.dart';

import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {

  ProductsGrid(this.showFavorites);

  bool showFavorites;

  @override
  Widget build(BuildContext context) {

    final productsProvider = Provider.of<Products>(context);
    final products = showFavorites ? productsProvider.favoriteItems : productsProvider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: products[i],
        child: ProductItem(),
      ) ,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        childAspectRatio: 3/2, 
        crossAxisSpacing: 10, 
        mainAxisSpacing: 10
      ),
    );
  }
}