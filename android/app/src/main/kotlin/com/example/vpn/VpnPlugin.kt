package com.example.vpn

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class VpnPlugin : FlutterPlugin, MethodCallHandler {
    companion object {
        private const val CHANNEL = "com.example.vpn/xray"
    }

    private lateinit var channel: MethodChannel

    // Called when plugin is attached to Flutter engine
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler(this)
    }

    // Called when plugin is detached
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    // Handle method calls from Flutter
    override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
        "ping" -> {
            result.success("pong")
        }
        else -> {
            result.notImplemented()
        }
    }
}
}