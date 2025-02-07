import 'category.dart';
import 'todo.dart';

class AppState {
  final List<Todo> todos;
  final List<Category> categories;

  AppState({required this.todos, required this.categories});

  /*-
  AppState.initialState()
      : todos = [
        Todo(id: '1', title: 'Cucina', completed: false, categoryId: '1'),
      ],
        categories = [
          Category(id: '1', name: 'Lavoro'),
          Category(id: '2', name: 'Personale'),
        ];
  */
AppState.initialState()
      : todos = [],
        categories = [];

}
