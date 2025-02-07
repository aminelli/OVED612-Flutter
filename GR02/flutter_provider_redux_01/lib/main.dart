import 'package:flutter/material.dart';
import 'package:flutter_provider_redux_01/actions/category_actions.dart';
import 'package:flutter_provider_redux_01/models/todo.dart';
import 'package:flutter_provider_redux_01/redux/category_thunk_actions.dart';
import 'package:flutter_provider_redux_01/redux/todo_thunk_actions.dart';
import 'package:flutter_provider_redux_01/storage/storage_service.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'actions/todo_actions.dart';
import 'models/app_state.dart';
import 'screens/todos_screen.dart';
import 'store/store.dart';

void main() async {
  final store = createStore();

  // Precaricamento dati dallo storage locale
  /*
  final storageService = StorageService();
  final todos = await storageService.loadTodos();
  final categories = await storageService.loadCategories();
  store.dispatch(SetTodosAction(todos));
  store.dispatch(SetCategoriesAction(categories));
  */

  store.dispatch(apiFetchCategoryAction());
  store.dispatch(apiFetchTodosAction());

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
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TodosScreen(),
      ),
    );
  }
}
