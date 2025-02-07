import 'dart:convert';

import '../models/category.dart';
import 'package:http/http.dart' as http;

class CategoryApiService {
  final String baseUrl;

  CategoryApiService({this.baseUrl = "http://localhost:3000"});

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Category> list =
          body.map((dynamic item) => Category.fromJson(item)).toList();
      return list;
    } else {
      throw Exception('Failed to load categories');
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
      return Category.fromJson(body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<Category> updateCategory(Category category) async {
    final response = await http.put(
      Uri.parse('$baseUrl/categories/${category.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(category.toJson()),
    );

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      return Category.fromJson(body);
    } else {
      throw Exception('Failed to load categories');
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
      throw Exception('Failed to load categories');
    }
  }
}
