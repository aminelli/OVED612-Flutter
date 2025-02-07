import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../actions/todo_actions.dart';
import '../models/app_state.dart';
import '../models/todo.dart';
import '../services/todo_api_service.dart';

ThunkAction<AppState> apiFetchTodosAction() {
  return (Store<AppState> store) async {
    final apiService = TodoApiService();
    final todos = await apiService.fetchTodos();
    store.dispatch(SetTodosAction(todos));
  };
}

ThunkAction<AppState> apiAddTodoAction(Todo todo) {
  return (Store<AppState> store) async {
    final apiService = TodoApiService();
    final newTodo = await apiService.addTodo(todo);
    store.dispatch(AddTodoAction(newTodo));
  };
}

ThunkAction<AppState> apiUpdateTodoAction(Todo todo) {
  return (Store<AppState> store) async {
    final apiService = TodoApiService();
    final updateTodo = await apiService.updateTodo(todo);
    store.dispatch(EditTodoAction(updateTodo));
  };
}

ThunkAction<AppState> apiDeleteTodoAction(String id) {
  return (Store<AppState> store) async {
    final apiService = TodoApiService();
    final success = await apiService.deleteTodo(id);
    if (success) {
      store.dispatch(RemoveTodoAction(id));
    }    
  };
}
