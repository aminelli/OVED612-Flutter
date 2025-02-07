import 'package:flutter/material.dart';
import 'package:flutter_provider_redux_01/actions/category_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/category.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Lista Categorie')),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _addCategory(context);
            }),
        body: StoreConnector<AppState, Store<AppState>>(
            converter: (store) => store,
            builder: (context, store) {
              final todos = store.state.todos;
              final categories = store.state.categories;

              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isCategoryInUse =
                      todos.any((todo) => todo.categoryId == category.id);

                  return ListTile(
                      title: Text(category.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editCategory(context, store, category);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: isCategoryInUse
                                ? null
                                : () {
                                    _removeCategory(context, store, category);
                                  },
                          ),
                        ],
                      ));
                },
              );
            }));
  }

  void _addCategory(BuildContext context) {
    Store<AppState> store = StoreProvider.of<AppState>(context);
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Aggiungi categoria'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(labelText: "Categoria"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Annulla'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
                child: Text('Aggiungi'),
                onPressed: () {
                  final newCategory = Category(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: controller.text);
                  store.dispatch(AddCategoryAction(newCategory));
                  Navigator.pop(context);
                })
          ],
        );
      },
    );
  }

  void _editCategory(
    BuildContext context, 
    Store<AppState> store, 
    Category category
    ) {
    
    //Store<AppState> store = StoreProvider.of<AppState>(context);
    TextEditingController controller = TextEditingController(text: category.name);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifica categoria'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(labelText: "Categoria"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Annulla'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
                child: Text('Conferma'),
                onPressed: () {
                  final updateCategory = category.copyWith(name: controller.text);
                  store.dispatch(EditCategoryAction(updateCategory));
                  Navigator.pop(context);
                })
          ],
        );
      },
    );

      }
  void _removeCategory(
      BuildContext context, Store<AppState> store, Category category) {
    store.dispatch(RemoveCategoryAction(category.id));
  }
}
