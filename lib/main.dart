import 'package:flutter/material.dart';
import 'package:products_shop/screens/splash_screen.dart';

import 'package:provider/provider.dart';

import './screens/products_overview.dart';
import './screens/product_detail.dart';
import './screens/cart_detail.dart';
import './screens/orders_list.dart';
import './screens/user_products.dart';
import './screens/edit_product.dart';
import './screens/auth_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previosProducts) => Products(auth.token, auth.userId, previosProducts==null ? [] : previosProducts.items),
          create: (ctx) => Products(null, null, []),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previosOrders) => Orders(auth.token, auth.userId, previosOrders==null ? [] : previosOrders.orders),
          create: (ctx) => Orders(null, null, []),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My shop',
          home: auth.isAuth 
            ? ProductsOverview() 
            : FutureBuilder(
              future: auth.tryAutoLogIn(),
              builder: (ctx, snapShot) {
                if(snapShot.connectionState == ConnectionState.waiting){
                  return SplashScreen();
                }else{
                  return AuthScreen();
                }
              },
            ),
          routes: {
            ProductDetail.routName : (ctx) => ProductDetail(),
            CartDetail.routeName : (ctx) => CartDetail(),
            OrdersList.routeName :  (ctx) => OrdersList(),
            UserProducts.routeName : (ctx) => UserProducts(),
            EditProduct.routeName : (ctx) => EditProduct(),
            AuthScreen.routeName : (ctx) => AuthScreen(),
          },
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'
          ),
        ),
      ),
    );
  }
}