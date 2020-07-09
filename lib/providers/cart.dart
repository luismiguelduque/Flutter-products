import 'package:flutter/material.dart';

class CartItem {

  CartItem({
    @required this.id, 
    @required this.title, 
    @required this.quantity, 
    @required this.price
  });

  final String id;
  final String title;
  final int quantity;
  final double price;
}

class Cart with ChangeNotifier {
  
  Map<String, CartItem> _items;

  Map<String, CartItem> get items{
    return {..._items};
  }

  void addItem(String productId, double price, String title){
    if(_items.containsKey(productId)){
      _items.update(
        productId, (existingItem) => CartItem(
          id:  existingItem.id,
          title:  existingItem.title,
          quantity: existingItem.quantity+1,
          price: existingItem.price,
        ),
      );
    }else{
      _items.putIfAbsent(
        productId, ()=> CartItem(
          id: DateTime.now().toString(), 
          title: title, 
          quantity: 1, 
          price: price
        )
      );
    }
  }

}