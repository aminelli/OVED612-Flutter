import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_riverpod_01/enums/enums.dart';

import '../main.dart';
import '../models/todo.dart';
import '../providers/categories_provider.dart';
import '../providers/todos_provider.dart';
import '../widgets/todo_item.dart';
import 'categories_screen.dart';

class TodosScreen extends ConsumerWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);
    final todoList = ref.watch(todoListProvider);
    final categoryList = ref.watch(categoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Todo'),
        actions: [
          IconButton(
              icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () {
                ref.read(themeProvider.notifier).state = !isDarkMode;
              }),
          IconButton(
            icon: Icon(Icons.category),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showDialog(context, ref, FormMode.add, null);
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
              _showDialog(context, ref, FormMode.edit, todo);
            },
            onToggle: () =>
                ref.read(todoListProvider.notifier).toggleTodo(todo),
          );
        },
      ),
    );
  }

  void _showDialog(
      BuildContext context, WidgetRef ref, FormMode formMode, Todo? todo) {
    final bool isEdit = (formMode == FormMode.edit);

    final controller = TextEditingController(text: todo?.title);

    String? selectedCategoryId = todo?.categoryId;

    showDialog(
      context: context,
      builder: (context) {
        final myControls = [];
       

        final btn = TextButton(
          child: const Text('Conferma'),
          onPressed: () {
            if (controller.text.isNotEmpty && selectedCategoryId != null) {
              if (isEdit) {
                ref.read(todoListProvider.notifier).updateTodo(todo!.copyWith(
                      title: controller.text,
                      categoryId: selectedCategoryId,
                    ));
              } else {
                ref.read(todoListProvider.notifier).addTodo(Todo(
                    id: UniqueKey().toString(),
                    categoryId: selectedCategoryId!,
                    title: controller.text,
                    completed: false));
              }
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Compilare tutti i campi'),
                ),
              );
            }
          },
        );

        myControls.add(btn);
        

        return AlertDialog(
          title: Text(isEdit ? 'Modifica Todo' : 'Nuovo Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(hintText: "Testo Todo"),
                onSubmitted: (value) {
                  btn.onPressed!();
                },
              ),
              SizedBox(height: 16),
              Consumer(builder: (context, ref, child) {
                final categoryList = ref.watch(categoryListProvider);
                return DropdownButtonFormField<String>(
                  value: selectedCategoryId,
                  hint: const Text('Selezionare una Categoria'),
                  items: categoryList
                      .map((category) => DropdownMenuItem<String>(
                            value: category.id,
                            child: Text(category.name),
                          ))
                      .toList(),
                  onChanged: (value) {
                    selectedCategoryId = value;
                    btn.onPressed!();
                  },
                );
              }),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Annulla'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            btn,
          ],
        );
      },
    );
  }
}
