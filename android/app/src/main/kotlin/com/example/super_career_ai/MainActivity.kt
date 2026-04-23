package com.example.super_career_ai

import android.content.res.Resources
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
  private val channelName = "super_career_ai/google_sign_in_config"

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
      .setMethodCallHandler { call, result ->
        when (call.method) {
          "getDefaultWebClientId" -> {
            val clientId = getStringResource("default_web_client_id")
            result.success(clientId)
          }
          else -> result.notImplemented()
        }
      }
  }

  private fun getStringResource(name: String): String? {
    return try {
      val res: Resources = resources
      val id = res.getIdentifier(name, "string", packageName)
      if (id == 0) null else getString(id)
    } catch (_: Exception) {
      null
    }
  }
}
