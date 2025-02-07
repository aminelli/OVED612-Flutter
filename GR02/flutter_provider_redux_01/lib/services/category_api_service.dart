import 'dart:convert';

import '../models/category.dart';
import 'package:http/http.dart' as http;

class CategoryApiService {
  final String baseUrl;

  CategoryApiService({this.baseUrl = "http://localhost:3000"});

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/categories'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Category> categories =
          body.map((dynamic item) => Category.fromJson(item)).toList();
      return categories;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Category> addCategory(Category category) async {
    final response = await http.post(
      Uri.parse('$baseUrl/categories'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(category.toJson()),
    );

    if (response.statusCode == 201) {
      dynamic body = jsonDecode(response.body);
      Category category = Category.fromJson(body);
      return category;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<Category> updateCategory(Category todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/categories/${todo.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      Category category = Category.fromJson(body);
      return category;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<bool> deleteCategory(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/categories/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
