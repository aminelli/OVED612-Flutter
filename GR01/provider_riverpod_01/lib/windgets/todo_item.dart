import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Category category;

  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onToggle;

  const TodoItem(
      {super.key,
      required this.todo,
      required this.category,
      required this.onDelete,
      required this.onEdit,
      required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.completed, 
        onChanged: (value) => onToggle(),
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.completed ? TextDecoration.lineThrough : null
        )
      ),
      subtitle: Text(category.name),
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
