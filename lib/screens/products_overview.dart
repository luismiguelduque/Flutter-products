import 'package:flutter/material.dart';


import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/app_drawer.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import './cart_detail.dart';

enum FilterOptions {
  Faborites,
  All,
}

class ProductsOverview extends StatefulWidget {

  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {

  bool showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My shop"),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              if(selectedValue == FilterOptions.Faborites){
                setState(() {
                  showFavorites = true;
                });
              } else {
                setState(() {
                  showFavorites = false;
                });
              }
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Only favorites",),
                value: FilterOptions.Faborites,
              ),
              PopupMenuItem(
                child: Text("Show all"),
                value: FilterOptions.All,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: child, 
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.of(context).pushNamed(CartDetail.routeName);
              },
            ),
          ),
          
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(showFavorites),
    );
  }
}

