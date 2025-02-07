import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/todo.dart';

class TodoApiService {
  final String baseUrl;

  TodoApiService({this.baseUrl = "http://localhost:3000"});

  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(Uri.parse('${baseUrl}/todos'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Todo> list =
          body.map((dynamic item) => Todo.fromJson(item)).toList();
      return list;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('${baseUrl}/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      dynamic body = jsonDecode(response.body);
      return Todo.fromJson(body);
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/${todo.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(todo.toJson()),
    );

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      return Todo.fromJson(body);
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<bool> deleteTodo(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/todos/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
