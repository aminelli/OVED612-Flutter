import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_riverpod_01/providers/todos_provider.dart';

import '../enums/enums.dart';
import '../models/category.dart';
import '../notifiers/todos_notifier.dart';
import '../providers/categories_provider.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryList = ref.watch(categoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Categorie'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _showDialog(context, ref, FormMode.add, null);
        },
      ),
      body: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          final category = categoryList[index];

          return CategoryItem(
            category: category,
            onDelete: () {
              TodoListNotifier todoListNotifier = ref.read(todoListProvider.notifier);
              try { 
                ref
                  .read(categoryListProvider.notifier)
                  .removeCategory(category.id, todoListNotifier);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                  ),
                );
              }              
            },
            onEdit: () {
              _showDialog(context, ref, FormMode.edit, category);
            },
          );
        },
      ),
    );
  }

  void _showDialog(
      BuildContext context, WidgetRef ref, FormMode formMode, Category? category) {
    final bool isEdit = (formMode == FormMode.edit);

    final controller = TextEditingController(text: category?.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Modifica Categoria' : 'Nuova Categoria'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                controller: controller,
                decoration: const InputDecoration(hintText: "Nome Categoria")
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Annulla'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Conferma'),
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  if (isEdit) {
                    ref
                        .read(categoryListProvider.notifier)
                        .updateCategory(category!.copyWith(name: controller.text));
                  } else {
                    ref.read(categoryListProvider.notifier).addCategory(Category(
                        id: UniqueKey().toString(), // Datetime.now().toString()
                        name: controller.text,
                        ));
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
            ),
          ],
        );
      },
    );
  }
}
