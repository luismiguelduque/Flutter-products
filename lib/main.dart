import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './screens/products_overview.dart';
import './screens/product_detail.dart';
import './screens/cart_detail.dart';
import './screens/orders_list.dart';
import './screens/user_products.dart';
import './screens/edit_product.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My shop',
        home: ProductsOverview(),
        routes: {
          ProductDetail.routName : (ctx) => ProductDetail(),
          CartDetail.routeName : (ctx) => CartDetail(),
          OrdersList.routeName :  (ctx) => OrdersList(),
          UserProducts.routeName : (ctx) => UserProducts(),
          EditProduct.routeName : (ctx) => EditProduct(),
        },
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato'
        ),
      ),
    );
  }
}