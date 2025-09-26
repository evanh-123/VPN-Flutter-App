import 'package:flutter/services.dart';

class VpnService {
  // 1. Create a MethodChannel with the SAME channel name as Android
  static const MethodChannel channel =
      MethodChannel('com.example.vpn/xray');

      Future<String> ping() async {
        try {
          final String? result = await channel.invokeMethod<String>('ping');
          return result ?? 'No response';  // Handle null case
        } catch (e) {
          print("Error calling ping: $e");
          return 'Error: $e';  // Return error message instead of no return
        }
      }
}