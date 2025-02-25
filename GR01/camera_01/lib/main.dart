import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


void _logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}


List<CameraDescription> _cameras = <CameraDescription>[];



Future<void> main() async  {
  // Fetch the available cameras before initializing the app.
  try {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
  } on CameraException catch (e) {
    _logError(e.code, e.description);
  }
  runApp(const CameraApp());
}


class CameraApp extends StatelessWidget {
  /// Default Constructor
  const CameraApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}
