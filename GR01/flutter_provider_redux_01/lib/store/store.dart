import 'package:flutter_provider_redux_01/actions/todo_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../models/app_state.dart';
import '../reducers/category_reducer.dart';
import '../reducers/todo_reducer.dart';

AppState rootReducer(AppState state, dynamic action) {
  return AppState(
      todos: todoReducer(state, action).todos,
      categories: categoryReducer(state, action).categories);
}

Store<AppState> createStore() {
  return Store<AppState>(rootReducer,
      initialState: AppState.initialState(), 
      //middleware: [thunkMiddleware, exampleMiddleware],
      middleware: [thunkMiddleware],
      );
}

void exampleMiddleware(Store<AppState> store, action, NextDispatcher next) {
  if (action is AddTodoAction) {

    //store.dispatch(EditTodoAction(action.todo));
  }

  next(action);
}
