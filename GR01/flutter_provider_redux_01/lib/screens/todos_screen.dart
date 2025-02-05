import 'package:flutter/material.dart';
import 'package:flutter_provider_redux_01/actions/todo_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/app_state.dart';
import '../models/category.dart';
import '../models/todo.dart';
import 'categories_screen.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista ToDo'),
          actions: [
            IconButton(
              icon: Icon(Icons.category),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)  => CategoriesScreen())
                );
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              _addTodo(context);
            }),
        body: StoreConnector<AppState, Store<AppState>>(
            converter: (store) => store,
            builder: (context, store) {
              final todos = store.state.todos;
              final categories = store.state.categories;

              return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    final category = categories.firstWhere(
                        (category) => category.id == todo.categoryId,
                        orElse: () =>
                            Category(id: '', name: 'Nessuna Categoria'));

                    return ListTile(
                      title: Text(todo.title),
                      subtitle: Text(category.name),
                      leading: Checkbox(
                          value: todo.completed,
                          onChanged: (value) {
                            //store.dispatch(ToggleTodoAction(todo));
                            _toggleTodo(context, store, todo);
                          }),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editTodo(context, store, todo);
                              }),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // store.dispatch(RemoveTodoAction(todo.id));
                                _removeTodo(context, store, todo);
                              })
                        ],
                      ),
                    );
                  });
            }));
  }

  void _addTodo(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final categories = store.state.categories;

    if (categories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Prima di aggiungere un ToDo, aggiungi una categoria'),
      ));
      return;
    }

    String? selectedCategoryId = categories.first.id;
    TextEditingController controller = TextEditingController();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Aggiungi ToDo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: "Todo"),
                  ),
                  DropdownButton<String>(
                      value: selectedCategoryId,
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                            value: category.id, child: Text(category.name));
                      }).toList(),
                      onChanged: (value) => selectedCategoryId = value)
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Annulla'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text('Salva'),
                  onPressed: () {
                    final newTodo = Todo(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: controller.text,
                      categoryId: selectedCategoryId!,
                      completed: false,
                    );
                    store.dispatch(AddTodoAction(newTodo));
                    Navigator.pop(context);
                  },
                )
              ]);
        });
  }

  void _editTodo(BuildContext context, Store<AppState> store, Todo todo) {
    final store = StoreProvider.of<AppState>(context);
    final categories = store.state.categories;

    String? selectedCategoryId = todo.categoryId;
    TextEditingController controller = TextEditingController(text: todo.title);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Modifica ToDo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: "Todo"),
                  ),
                  DropdownButton<String>(
                      value: selectedCategoryId,
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                            value: category.id, child: Text(category.name));
                      }).toList(),
                      onChanged: (value) => selectedCategoryId = value)
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Annulla'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text('Salva'),
                  onPressed: () {
                    final updateTodo = todo.copyWith(
                      title: controller.text,
                      categoryId: selectedCategoryId!,
                    );
                    store.dispatch(EditTodoAction(updateTodo));
                    Navigator.pop(context);
                  },
                )
              ]);
        });
  }

  void _removeTodo(BuildContext context, Store<AppState> store, Todo todo) {
    store.dispatch(RemoveTodoAction(todo.id));
  }

  void _toggleTodo(BuildContext context, Store<AppState> store, Todo todo) {
    store.dispatch(ToggleTodoAction(todo));
  }
}
