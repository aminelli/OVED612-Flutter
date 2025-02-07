import '../actions/todo_actions.dart';
import '../models/app_state.dart';
import '../models/todo.dart';

AppState todoReducer(AppState currentState, dynamic action) {
  AppState newState = currentState.copyWith(
      todos: _todoListReducer(currentState.todos, action));

  /*
  AppState newState = AppState(
      todos: _todoListReducer(currentState.todos, action),
      categories: currentState.categories);
  */
  return newState;
}

List<Todo> _todoListReducer(List<Todo> todos, dynamic action) {
  if (action is AddTodoAction) {
    
    return List.from(todos)..add(action.todo);

  } else if (action is EditTodoAction) {
 
    return todos.map((todo) => todo.id == action.todo.id ? action.todo : todo).toList();
 
  } else if (action is RemoveTodoAction) {
      return todos.where((todo) => todo.id != action.id).toList();

  } /* else if (action is ToggleTodoAction) {

    return todos.map(
      (todo) => todo.id == action.todo.id ? todo.copyWith(completed: !todo.completed) : todo
    ).toList();

  } */ else if (action is SetTodosAction) {
    return action.todos;
  }

  return todos;
}
