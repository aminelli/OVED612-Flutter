import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';

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
      /*
      if (todo.id == updateTodo.id) {
        return updateTodo;
      }
      return todo;
      */ 
      return todo.id == updateTodo.id ? updateTodo : todo;
    }).toList();
  }

  /*
  void toggleTodo(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(completed: !todo.completed);
      }
      return todo;
    }).toList();
  }
  */

  void toggleTodo(Todo todo) {
    updateTodo(todo.copyWith(completed: !todo.completed));
  }

  bool isCategoryInUse(String categoryId) {
    return state.any((todo) => todo.categoryId == categoryId);
  }
  
}
