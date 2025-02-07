import '../models/todo.dart';

class AddTodoAction {
  final Todo todo;
  AddTodoAction(this.todo);
}

class EditTodoAction {
  final Todo todo;
  EditTodoAction(this.todo);
}

/*
class ToggleTodoAction {
  final Todo todo;
  ToggleTodoAction(this.todo);
}
*/

class SetTodosAction {
  final List<Todo> todos;
  SetTodosAction(this.todos);
}

class RemoveTodoAction {
  final String id;
  RemoveTodoAction(this.id);
}



