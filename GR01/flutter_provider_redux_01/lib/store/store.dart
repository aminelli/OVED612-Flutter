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
  return Store<AppState>(
    rootReducer,
    initialState: AppState.initialState(),
    middleware: [thunkMiddleware]
  );
}

