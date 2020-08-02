import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_product.dart';

class UserProducts extends StatelessWidget {

  static const routeName = "/user-products";

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts(filterByUser: true); 
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, futureSnapshot) {
          if(futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: Consumer<Products>(
                builder: (ctx, productsProvider, _) => Padding(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: productsProvider.items.length,
                    itemBuilder: (_, i) => Column(
                      children: [
                        UserProductItem(
                          id: productsProvider.items[i].id,
                          title: productsProvider.items[i].title,
                          imageUrl: productsProvider.items[i].imageUrl,
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        }
      ),
    );
  }
}