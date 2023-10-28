package com.platemate.user

import android.content.Context
import android.content.Intent
import android.widget.Toast
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun onDestroy() {
        flutterEngine?.platformViewsController?.onDetachedFromJNI()
        super.onDestroy()
    }

    companion object {
        fun createIntent(context: Context, initialRoute: String = "/"): Intent {
            return Intent(context, MainActivity::class.java)
                    .putExtra("initial_route", initialRoute)
                    .putExtra("background_mode", "opaque")
                    .putExtra("destroy_engine_with_activity", true)
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.platemate.user/toast"
        ).setMethodCallHandler { call, result ->
            if (call.method == "toast") {
                val message = call.argument<String>("message")
                val isLong = call.argument<Boolean>("isLong")
                Toast.makeText(
                    applicationContext,
                    message,
                    if (isLong!!) Toast.LENGTH_LONG else Toast.LENGTH_SHORT
                ).show()
                result.success(true)
            } else {
                result.notImplemented()
            }
        }
    }
}
