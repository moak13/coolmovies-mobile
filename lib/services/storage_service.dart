import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final Logger _logger = Logger();

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveResponse<T>(
    String key,
    T response,
  ) async {
    final prefs = await _getPrefs();

    try {
      String jsonResponse = jsonEncode(response);
      await prefs.setString(key, jsonResponse);
    } catch (e, s) {
      _logger.e(
        'unable to save response',
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<T?> getResponse<T>(
    String key, {
    T Function(dynamic)? fromJson,
  }) async {
    final prefs = await _getPrefs();
    try {
      String? jsonResponse = prefs.getString(key);
      if (jsonResponse != null) {
        final decoded = jsonDecode(jsonResponse);
        if (fromJson != null) {
          return fromJson(decoded);
        }
        return decoded as T;
      }
    } catch (e, s) {
      _logger.e('Unable to get response for key: $key',
          error: e, stackTrace: s);
    }
    return null;
  }

  Future<void> clearResponse(String key) async {
    final prefs = await _getPrefs();

    try {
      await prefs.remove(key);
    } catch (e, s) {
      _logger.e(
        'unable to clear response',
        error: e,
        stackTrace: s,
      );
    }
  }
}
