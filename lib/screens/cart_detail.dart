import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartDetail extends StatelessWidget {

  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {

    final cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Your Cart"),),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total:", style: TextStyle(fontSize: 20),),
                  Spacer(),
                  Chip(label: Text('\$ ${cartProvider.totalAmount.toStringAsFixed(2)}', style: TextStyle(color: Colors.white,)), backgroundColor: Theme.of(context).primaryColor),
                  FlatButton(
                    child: Text("ORDER NOW"),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: (){
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cartProvider.items.values.toList(), 
                        cartProvider.totalAmount
                      );
                      cartProvider.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.itemCount,
              itemBuilder: (ctx, i){
                final item = cartProvider.items.values.toList()[i];
                return CartItem(id: item.id, productId: cartProvider.items.keys.toList()[i], title: item.title, quantity: item.quantity, price: item.price);
              },
            ),
          ),
        ],
      ),
    );
  }
}