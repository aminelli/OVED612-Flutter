import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/category.dart';
import '../models/todo.dart';

class StorageService {
  static const String _todosKey = 'todos';
  static const String _categoriesKey = 'categories';

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = todos.map((todo) => jsonEncode(todo.toJson())).toList();
    prefs.setStringList(_todosKey, todosJson);
  }

  Future<void> saveCategories(List<Category> categories) async {
      final prefs = await SharedPreferences.getInstance();
      final categoriesJson = categories.map((category) => jsonEncode(category.toJson())).toList();
      prefs.setStringList(_categoriesKey, categoriesJson);
  }



  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getStringList(_todosKey) ?? [];
    final todos = todosJson.map((json) => Todo.fromJson(jsonDecode(json))).toList();
    return todos;
  }

  Future<List<Category>> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoriesJson = prefs.getStringList(_categoriesKey) ?? [];
    final categories = categoriesJson.map((json) => Category.fromJson(jsonDecode(json))).toList();
    return categories;
  }


}
