import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {

  UserProductItem({
    this.title,
    this.imageUrl
  });

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
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
              onPressed: (){},
            ),
            IconButton(
              color: Theme.of(context).errorColor,
              icon: Icon(Icons.delete),
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}