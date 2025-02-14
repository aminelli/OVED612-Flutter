import 'package:firebase_01/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routing/routing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
      ChangeNotifierProvider(
        create: (contex) => ApplicationState(),
        builder: ((context, child) => const App()),
      ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Evento San Valentino',
      theme: ThemeData.dark(),
      routerConfig: appRouter,
    );
  }
}

