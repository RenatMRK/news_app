import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Simple env loader wrapper. Call `Env.load()` early in app bootstrap.
class Env {
  static Future<void> load({String? envFile}) async {
    final file = envFile ?? _defaultForFlavor();
    await dotenv.load(fileName: file);
    if (kDebugMode) {
      // ignore: avoid_print
      print('Loaded env: $file');
    }
  }

  static String _defaultForFlavor() {
    // Default to development if not provided.
    return '.env.development';
  }

  static String? get(String key) => dotenv.env[key];
}
