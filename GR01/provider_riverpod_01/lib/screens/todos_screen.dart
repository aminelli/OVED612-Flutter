import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_riverpod_01/main.dart';

import '../enums/enums.dart';
import '../models/todo.dart';
import '../providers/categories_provider.dart';
import '../providers/todos_provider.dart';
import '../windgets/todo_item.dart';
import 'categories_screen.dart';

class TodosScreen extends ConsumerWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoListProvider);
    final categoryList = ref.watch(categoryListProvider);
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista Todo'),
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                ref.read(themeProvider.notifier).state = !isDarkMode;
              },
            ),
            IconButton(
              icon: Icon(Icons.category),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoriesScreen()));
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _showDialog(context, ref, FormViewState.add, null);
          },
        ),
        body: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              final todo = todoList[index];
              final category = categoryList
                  .firstWhere((category) => category.id == todo.categoryId);

              return TodoItem(
                todo: todo,
                category: category,
                onDelete: () =>
                    ref.read(todoListProvider.notifier).removeTodo(todo.id),
                onEdit: () {
                  _showDialog(context, ref, FormViewState.edit, todo);
                },
                onToggle: () =>
                    ref.read(todoListProvider.notifier).toggleTodo(todo),
              );
            }));
  }

  void _showDialog(BuildContext context, WidgetRef ref, FormViewState formState,
      Todo? todo) {
    final bool isEdit = formState == FormViewState.edit;
    final controller = isEdit
        ? TextEditingController(text: todo?.title)
        : TextEditingController();

    String? selectedCategoryId = todo?.categoryId;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? "Modifica Todo" : "Nuovo Todo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(hintText: "Todo"),
              ),
              SizedBox(height: 16),
              Consumer(builder: (context, ref, child) {
                final categories = ref.watch(categoryListProvider);
                return DropdownButtonFormField<String>(
                  value: selectedCategoryId,
                  hint: Text("Selezionare una categoria"),
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      child: Text(category.name),
                      value: category.id,
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedCategoryId = value;
                  },
                );
              })
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Annulla")),
            TextButton(
              onPressed: () {
                if (controller.text.isNotEmpty && selectedCategoryId != null) {
                  if (isEdit) {
                    ref.read(todoListProvider.notifier).updateTodo(todo!
                        .copyWith(
                            title: controller.text,
                            categoryId: selectedCategoryId));
                  } else {
                    ref.read(todoListProvider.notifier).addTodo(Todo(
                        categoryId: selectedCategoryId!,
                        title: controller.text,
                        id: DateTime.now().toString(),
                        completed: false));
                  }
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("La categoria e il todo sono obbligatori"))
                      );
                }
              },
              child: Text("Conferma"),
            )
          ],
        );
      },
    );
  }
}
