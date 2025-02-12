import 'package:flutter/material.dart';
import '../models/category.dart';
 

class CategoryItem extends StatelessWidget {
  final Category category;

  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CategoryItem(
      {super.key,
      required this.category,
      required this.onDelete,
      required this.onEdit });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        category.name
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
          IconButton(onPressed: onDelete, icon: Icon(Icons.delete))
        ],
      ),
    );
  }
}
