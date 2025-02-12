import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_riverpod_01/notifiers/todos_notifier.dart';

import '../models/todo.dart';

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
  (ref) {
    return TodoListNotifier();
  },
);
