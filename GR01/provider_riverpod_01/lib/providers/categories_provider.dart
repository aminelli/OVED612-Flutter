import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_riverpod_01/notifiers/categories_notifier.dart';

import '../models/category.dart';

final categoryListProvider = StateNotifierProvider<CategoryListNotifier, List<Category>>(
  (ref) {
    return CategoryListNotifier();
  },
);
