import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_riverpod_01/notifiers/todos_notifier.dart';

import '../models/category.dart';

class CategoryListNotifier extends StateNotifier<List<Category>> {
  CategoryListNotifier() : super([]);

  void addCategory(Category category) {
    state = [...state, category];
  }

  void removeCategory(String id, TodoListNotifier todoListNotifier) {
    if (!todoListNotifier.isCategoryInUse(id)) {
      state = state.where((category) => category.id != id).toList();
    } else {
      throw Exception('La categoria è associata ad almeno un todo');
    }
  }

  void updateCategory(Category updateCategory) {
    state = state.map((category) {
      if (category.id == updateCategory.id) {
        return updateCategory.copyWith();
      }
      return category;
    }).toList();
  }

  
}
