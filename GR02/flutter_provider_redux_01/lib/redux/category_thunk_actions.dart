

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../actions/category_actions.dart';
import '../models/app_state.dart';
import '../models/category.dart';
import '../services/category_api_service.dart';

ThunkAction<AppState> apiFetchCategoryAction() {
  return (Store<AppState> store) async {
    final apiService = CategoryApiService();
    final todos = await apiService.fetchCategories();
    store.dispatch(SetCategoriesAction(todos));
  };
}

ThunkAction<AppState> apiAddCategoryAction(Category category) {
  return (Store<AppState> store) async {
    final apiService = CategoryApiService();
    final newCategory = await apiService.addCategory(category);
    store.dispatch(AddCategoryAction(newCategory));
  };
}

ThunkAction<AppState> apiUpdateCategoryAction(Category category) {
  return (Store<AppState> store) async {
    final apiService = CategoryApiService();
    final updateCategory = await apiService.updateCategory(category);
    store.dispatch(EditCategoryAction(updateCategory));
  };
}

ThunkAction<AppState> apiDeleteCategoryAction(String id) {
  return (Store<AppState> store) async {
    final apiService = CategoryApiService();
    final success = await apiService.deleteCategory(id);
    if (success) {
      store.dispatch(RemoveCategoryAction(id));
    }    
  };
}