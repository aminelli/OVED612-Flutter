import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NativeMessageWidget(),
    );
  }
}


class NativeMessageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  => _NativeViewWidgetState()
}


class _NativeViewWidgetState extends State<NativeMessageWidget> {
  String _nativeMessage = "Loading....";
 
  static const platform = MethodChannel("com.example.flutter_application_1/native");

  Future<void> _getNativeMessage() async {
    String message;
    try {
      message = await platform.invokeMethod("getNativeMessage");
    } on PlatformException catch(e) {
      message = "Errore sul canale";
    }

    setState(() {
      _nativeMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_nativeMessage);
  }

  @override
  void initState() {
    super.initState();
    _getNativeMessage();
  }
  
}


