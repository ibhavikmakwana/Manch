import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreference {
  static SharedPreference? _instance;

  static SharedPreference? get instance =>
      _instance == null ? _instance = SharedPreference._() : _instance;

  SharedPreference._() {
    storage = FlutterSecureStorage();
  }

  late FlutterSecureStorage storage;

  // Read value
  Future<String?> value(String key) async => await storage.read(key: key);

  // Read all values
  Future<Map<String, String>> get allValues async => await storage.readAll();

  // Delete value
  Future<void> delete(String key) async => await storage.delete(key: key);

  // Delete all
  Future<void> get deleteAll async => await storage.deleteAll();

  // Write value
  Future<void> write(String key, String value) async =>
      await storage.write(key: key, value: value);
}
