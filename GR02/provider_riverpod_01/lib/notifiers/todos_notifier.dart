import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_riverpod_01/models/todo.dart';

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void removeTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void updateTodo(Todo updateTodo) {
    state = state.map((todo) {
      return todo.id == updateTodo.id ? updateTodo : todo;
    }).toList();
  }

  void toggleTodo(Todo todo) {
    updateTodo(todo.copyWith(completed: !todo.completed));
  }

  bool isCategoryInUse(String categoryId) {
    return state.any((todo) => todo.categoryId == categoryId);
  }
}
