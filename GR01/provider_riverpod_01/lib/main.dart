import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/todos_screen.dart';


final themeProvider = StateProvider<bool>((ref) => false);

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Riverpod Demo',
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: TodosScreen(),
    );
  }
}

