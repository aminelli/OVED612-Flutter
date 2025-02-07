
import '../actions/category_actions.dart';
import '../models/app_state.dart';
import '../models/category.dart';

AppState categoryReducer(AppState currentState, dynamic action) {
  AppState newState = currentState.copyWith(
      categories: _categoryListReducer(currentState.categories, action)
  );

  return newState;
}


List<Category> _categoryListReducer(List<Category> categories, dynamic action) {
 
  if (action is AddCategoryAction) {
    
    return List.from(categories)..add(action.category);

  } else if (action is EditCategoryAction) {
 
    return categories.map((category) => category.id == action.category.id ? action.category : category).toList();
 
  } else if (action is RemoveCategoryAction) {
      return categories.where((category) => category.id != action.id).toList();

  } else if(action is SetCategoriesAction) {
    return action.categories;
  }

  return categories;
}
