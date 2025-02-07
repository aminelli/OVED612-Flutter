
import '../models/category.dart';

class AddCategoryAction {
  final Category category;
  AddCategoryAction(this.category);
}

class EditCategoryAction {
  final Category category;
  EditCategoryAction(this.category);
}

class RemoveCategoryAction {
  final String id;
  RemoveCategoryAction(this.id);
}


class SetCategoriesAction {
  final List<Category> categories;
  SetCategoriesAction(this.categories);
}