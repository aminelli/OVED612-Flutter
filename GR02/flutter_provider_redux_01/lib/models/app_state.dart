import 'category.dart';
import 'todo.dart';

class AppState {
  final List<Todo> todos;
  final List<Category> categories;

  AppState({required this.todos, required this.categories});

  /*
  AppState.initialState()
      : todos = [
        Todo(id: "1", title: "Fare Spesa", completed: false, categoryId: "1"),
        Todo(id: "2", title: "Cibo Gatti", completed: false, categoryId: "1"),
        Todo(id: "3", title: "Chiamare Boss", completed: false, categoryId: "2")
      ],
      categories = [
        Category(id: "1", name: "Personale"),
        Category(id: "2", name: "Lavoro")
      ];
*/

  AppState.initialState()
      : todos = [],
      categories = [];

  AppState copyWith({List<Todo>? todos, List<Category>? categories}) {
    return AppState(
      todos: todos ?? this.todos,
      categories: categories ?? this.categories,
    );
  }
}
