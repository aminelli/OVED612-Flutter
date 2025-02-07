import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'actions/category_actions.dart';
import 'actions/todo_actions.dart';
import 'models/app_state.dart';
import 'redux/category_thunk_actions.dart';
import 'redux/todo_thunk_actions.dart';
import 'screens/todos_screen.dart';
import 'storage/storage_service.dart';
import 'store/store.dart';

void main() async {
  final store = createStore();

  // Precaricamento dati dallo storage
  /*
  final storageService = StorageService();
  final todos = await storageService.loadTodos();
  final categories = await storageService.loadCategories();
  store.dispatch(SetTodosAction(todos));
  store.dispatch(SetCategoriesAction(categories));
  */
  
  store.dispatch(apiFetchTodosAction());
  store.dispatch(apiFetchCategoriesAction());

  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({super.key, required this.store});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
            title: 'TODOS',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: TodosScreen()));
  }
}
