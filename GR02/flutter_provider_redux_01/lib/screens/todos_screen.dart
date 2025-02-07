import 'package:flutter/material.dart';
import 'package:flutter_provider_redux_01/redux/todo_thunk_actions.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../actions/todo_actions.dart';
import '../components/drop-down-categories.dart';
import '../models/app_state.dart';
import '../models/category.dart';
import '../models/todo.dart';
import 'categories_screen.dart';

class TodosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Todo'),
        actions: [
          IconButton(
            icon: Icon(Icons.category),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()));
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
                    orElse: () => Category(id: '1', name: 'Nessuna Categoria'));

                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text(category.name),
                  leading: Checkbox(
                      value: todo.completed,
                      onChanged: (value) {
                        _toggleTodo(context, store, todo);
                      }),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editTodo(context, store, todo);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // store.dispatch(RemoveTodoAction(todo.id));
                          _removeTodo(context, store, todo);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }

  void _addTodo(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final categories = store.state.categories;

    if (categories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Nessuna categoria disponibile'),
      ));
      return;
    }

    String? selectedCategoryId = categories.first.id;
    TextEditingController titleController = TextEditingController();
    //ValueNotifier<String?> selectedCategoryIdNotifier =  ValueNotifier<String?>(selectedCategoryId);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nuovo Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Todo'),
              ),
              DropdownButtonFormField<String>(
                value: selectedCategoryId,
                hint: Text("Seleziona una categoria"),
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedCategoryId = newValue;
                },
              ),
              /*
              DropdownButtonCategories(
                categories: categories,
                defaultValue: selectedCategoryId,
                onChanged: (value) {
                  selectedCategoryId = value;
                },
              ),
              */
              /*
              ValueListenableBuilder<String?>(
                  valueListenable: selectedCategoryIdNotifier,
                  builder: (context, value, child) {
                    return DropdownButton<String>(
                      value: value,
                      hint: Text("Seleziona una categoria"),
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        selectedCategoryIdNotifier.value = newValue;
                        selectedCategoryId = newValue;
                      },
                    );
                  }) 
                  */
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
                    id: null, // DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    categoryId: selectedCategoryId!);
                store.dispatch(apiAddTodoAction(newTodo));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _editTodo(BuildContext context, Store<AppState> store, Todo todo) {
    final categories = store.state.categories;

    String? selectedCategoryId = todo.categoryId;
    TextEditingController titleController =
        TextEditingController(text: todo.title);

    // ValueNotifier<String?> selectedCategoryIdNotifier =  ValueNotifier<String?>(selectedCategoryId);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Modifica Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Todo'),
              ),
              DropdownButtonFormField<String>(
                value: selectedCategoryId,
                hint: Text("Seleziona una categoria"),
                items: categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (newValue) {
                  selectedCategoryId = newValue;
                },
              ),
              /*
              DropdownButtonCategories(
                categories: categories,
                defaultValue: selectedCategoryId,
                onChanged: (value) {
                  selectedCategoryId = value;
                },
              ),
              */
              /*
              ValueListenableBuilder<String?>(
                  valueListenable: selectedCategoryIdNotifier,
                  builder: (context, value, child) {
                    return DropdownButton<String>(
                      value: value,
                      hint: Text("Seleziona una categoria"),
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.id,
                          child: Text(category.name),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        selectedCategoryIdNotifier.value = newValue;
                        selectedCategoryId = newValue;
                      },
                    );
                  })*/
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
                    title: titleController.text,
                    categoryId: selectedCategoryId!);
                //store.dispatch(EditTodoAction(updateTodo));
                store.dispatch(apiUpdateTodoAction(updateTodo));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _removeTodo(BuildContext context, Store<AppState> store,Todo todo) async {
    store.dispatch(RemoveTodoAction(todo.id!));
  }

  void _toggleTodo(BuildContext context, Store<AppState> store,Todo todo) {
    //store.dispatch(ToggleTodoAction(todo));
    final updateTodo = todo.copyWith(completed: !todo.completed);
    store.dispatch(apiUpdateTodoAction(updateTodo));
  }
}
