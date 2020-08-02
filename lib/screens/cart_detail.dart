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
                  OrderButton(cartProvider: cartProvider),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartProvider,
  }) : super(key: key);

  final Cart cartProvider;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text("ORDER NOW"),
      textColor: Theme.of(context).primaryColor,
      onPressed: (widget.cartProvider.totalAmount <= 0 || _isLoading) ? null : () async{
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Orders>(context, listen: false).addOrder(
          widget.cartProvider.items.values.toList(), 
          widget.cartProvider.totalAmount
        );
        setState(() {
          _isLoading = false;
        });
        widget.cartProvider.clear();
      },
    );
  }
}