import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../actions/todo_actions.dart';
import '../models/app_state.dart';
import '../reducers/category_reducer.dart';
import '../reducers/todo_reducer.dart';

AppState rootReducer(AppState currentState, dynamic action) {
  return AppState(
    todos: todoReducer(currentState, action).todos,
    categories: categoryReducer(currentState, action).categories,
  );
}

Store<AppState> createStore() {
  return Store<AppState>(
    rootReducer,
    initialState: AppState.initialState(),
    // middleware: [thunkMiddleware, exampleMiddleware, loggingMiddleware],
    middleware: [thunkMiddleware],

  );
}

void loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  /*
  print("Action: $action");

   if (action is SetTodosAction) {
    // ...
  }


  print("State before action: ${store.state}");
  next(action);     
  print("State after action: ${store.state}");
  */
}


void exampleMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is SetTodosAction) {
    // ...
  }

  next(action);

  if (action is SetTodosAction) {
    // ...
  }
}
