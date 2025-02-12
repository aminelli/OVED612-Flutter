import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/todo.dart';
import '../notifiers/todos_notifier.dart';

final todoListProvider =
    StateNotifierProvider<TodoListNotifier, List<Todo>>(
      (ref) {
        return TodoListNotifier();
      },
);
