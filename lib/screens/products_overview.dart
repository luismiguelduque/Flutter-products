import 'package:flutter/material.dart';


import '../widgets/products_grid.dart';

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
        ],
      ),
      body: ProductsGrid(showFavorites),
    );
  }
}

