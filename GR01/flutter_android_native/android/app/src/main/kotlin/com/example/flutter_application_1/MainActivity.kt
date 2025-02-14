package com.example.flutter_application_1

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    private val CHANNELL = "com.example.flutter_application_1/native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getNativeMessage") {
                val message = getMessageFromNativeCode()
                result.success(message)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getMessageFromNativeCode(): String {
        return "Ciao dal codice nativo Android!"
    }
    
}