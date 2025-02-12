import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_riverpod_01/providers/todos_provider.dart';

import '../enums/enums.dart';
import '../models/category.dart';
import '../providers/categories_provider.dart';
import '../windgets/category_item.dart';

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
          child: Icon(Icons.add),
          onPressed: () {
            _showDialog(context, ref, FormViewState.add, null);
          },
        ),
        body: ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              final category = categoryList[index];

              return CategoryItem(
                  category: category,
                  onDelete: () {
                    try {
                      ref.read(categoryListProvider.notifier).removeCategory(
                          category.id, ref.read(todoListProvider.notifier));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString()))
                      );
                    }
                  },
                  onEdit: () {
                    _showDialog(context, ref, FormViewState.edit, category);
                  });
            }));
  }

  void _showDialog(BuildContext context, WidgetRef ref, FormViewState formState,
      Category? category) {
    final bool isEdit = formState == FormViewState.edit;
    final controller = isEdit
        ? TextEditingController(text: category?.name)
        : TextEditingController();

    String? selectedCategoryId;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? "Modifica Categoria" : "Nuova Categoria"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(hintText: "Nome Categoria"),
              )
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
                if (controller.text.isNotEmpty) {
                  if (isEdit) {
                    ref.read(categoryListProvider.notifier).updateCategory(
                          category!.copyWith(name: controller.text),
                        );
                  } else {
                    ref.read(categoryListProvider.notifier).addCategory(
                          Category(
                              id: DateTime.now().toString(),
                              name: controller.text),
                        );
                  }
                }
                Navigator.of(context).pop();
              },
              child: Text("Conferma"),
            )
          ],
        );
      },
    );
  }
}
