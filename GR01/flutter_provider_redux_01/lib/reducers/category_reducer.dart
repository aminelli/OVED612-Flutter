import '../actions/category_actions.dart';
import '../models/app_state.dart';
import '../models/category.dart';

AppState categoryReducer(AppState state, dynamic action) {
 return AppState(
      todos: state.todos,
      categories: _categoryListReducer(state.categories, action)
    );
}

List<Category> _categoryListReducer(List<Category> categories, dynamic action) {
  
  if (action is AddCategoryAction) {
    return List.from(categories)..add(action.category);
  
  } else if (action is RemoveCategoryAction) {
    
    return categories.where((todo) => todo.id != action.id).toList();
  
  } else if (action is EditCategoryAction) {
    
    return categories
        .map((category) => category.id == action.category.id ? action.category : category)
        .toList();
  
  }

  return categories;
}