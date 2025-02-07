import '../models/todo.dart';

// Classe per gestire l'action per l'aggiunta di un todo
class AddTodoAction {
  final Todo todo;

  AddTodoAction(this.todo);
}

// Classe per gestire l'action per la rimozione di un todo
class RemoveTodoAction {
  final String id;

  RemoveTodoAction(this.id);
}

class EditTodoAction {
  final Todo todo;

  EditTodoAction(this.todo);
}

class SetTodosAction {
  final List<Todo> todos;

  SetTodosAction(this.todos);
}

/*
class ToggleTodoAction {
  final Todo todo;

  ToggleTodoAction(this.todo);
}
*/
