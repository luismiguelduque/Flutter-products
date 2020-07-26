import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_product.dart';

class UserProducts extends StatelessWidget {

  static const routeName = "/user-products";

  @override
  Widget build(BuildContext context) {

    final productsProvider = Provider.of<Products>(context);

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Your products"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(EditProduct.routeName);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsProvider.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                title: productsProvider.items[i].title,
                imageUrl: productsProvider.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}