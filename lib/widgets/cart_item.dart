import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {

  CartItem({
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title
  });

  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 40,),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      onDismissed: (direction){
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text('\$ $price')
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total: \$ ${ (price*quantity) }"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}