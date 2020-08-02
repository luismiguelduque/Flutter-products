import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../screens/edit_product.dart';

class UserProductItem extends StatelessWidget {

  UserProductItem({
    this.id,
    this.title,
    this.imageUrl
  });

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: Icon(Icons.edit),
              onPressed: (){
                Navigator.of(context).pushNamed(EditProduct.routeName, arguments: id);
              },
            ),
            IconButton(
              color: Theme.of(context).errorColor,
              icon: Icon(Icons.delete),
              onPressed: () async {
                try{
                  await Provider.of<Products>(context, listen: false).deleteProduct(id);
                }catch(error){
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text("Deliting failed", textAlign: TextAlign.center,),
                    )
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}