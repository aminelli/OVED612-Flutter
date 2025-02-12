import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_riverpod_01/notifiers/todos_notifier.dart';

import '../models/category.dart';

class CategoryListNotifier extends StateNotifier<List<Category>> {
  CategoryListNotifier() : super([Category(id: "1", name: "work")]);

  void addCategory(Category category) {
    state = [...state, category];
  }

  void updateCategory(Category updateCategory) {
    state = state.map((category) {
      return category.id == updateCategory.id ? updateCategory : category;
    }).toList();
  }

  void removeCategory(String id, TodoListNotifier todoListNotifier) {
    if (!todoListNotifier.isCategoryInUse(id)) {
      state = state.where((category) => category.id != id).toList();
    } else {
      throw Exception('La categoria è associata ad almeno un todo.');
    }
  }

}
