

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../actions/category_actions.dart';
import '../models/app_state.dart';
import '../models/category.dart';
import '../services/category_api_service.dart';

ThunkAction<AppState> apiFetchCategoriesAction() {
  return (Store<AppState> store) async {
    final apiService = CategoryApiService();
    final todos = await apiService.fetchCategories();
    store.dispatch(SetCategoriesAction(todos));
  };
}

ThunkAction<AppState> apiAddCategoriesAction(Category todo) {
  return (Store<AppState> store) async {
    final apiService = CategoryApiService();
    final newCategory = await apiService.addCategory(todo);
    store.dispatch(AddCategoryAction(newCategory));
  };
}

ThunkAction<AppState> apiUpdateCategoriesAction(Category todo) {
  return (Store<AppState> store) async {
    final apiService = CategoryApiService();
    final updateCategory = await apiService.updateCategory(todo);
    store.dispatch(EditCategoryAction(updateCategory));
  };
}

ThunkAction<AppState> apiDeleteCategoriesAction(String id) {
  return (Store<AppState> store) async {
    final apiService = CategoryApiService();
    final success = await apiService.deleteCategory(id);
    if (success) {
      store.dispatch(RemoveCategoryAction(id));
    }    
  };
}