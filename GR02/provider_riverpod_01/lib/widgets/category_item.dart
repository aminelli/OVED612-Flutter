import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/todo.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CategoryItem({super.key, required this.category, required this.onDelete, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return ListTile(      
      title: Text(category.name),
       trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
