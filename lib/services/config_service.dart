import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/xray_config.dart';

class ConfigService {
  static const String _configKey = 'xray_config';
  
  // Save config
  Future<bool> saveConfig(XrayConfig config) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final configJson = jsonEncode(config.toJson());
      print(configJson);
      return await prefs.setString(_configKey, configJson);
    } catch (e) {
      print('Error saving config: $e');
      return false;
    }
  }
  
  // Load config
  Future<XrayConfig?> loadConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final configJson = prefs.getString(_configKey);
      if (configJson != null) {
        return XrayConfig.fromJson(jsonDecode(configJson));
      }
      return null;
    } catch (e) {
      print('Error loading config: $e');
      return null;
    }
  }
  
  // Clear config
  Future<bool> clearConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_configKey);
    } catch (e) {
      print('Error clearing config: $e');
      return false;
    }
  }
}