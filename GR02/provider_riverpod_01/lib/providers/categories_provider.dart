
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/category.dart';
import '../notifiers/categories_notifier.dart';

final categoryListProvider = StateNotifierProvider<CategoryListNotifier, List<Category>>(
  (ref) {
    return CategoryListNotifier();
  },
);  