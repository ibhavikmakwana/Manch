import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_playground/core/supabase/build_config.dart';

void configureMainApp() {
  final storage = FlutterSecureStorage();
  final localStorage = LocalStorage(hasAccessToken: () {
    return storage.containsKey(key: supabasePersistSessionKey);
  }, accessToken: () {
    return storage.read(key: supabasePersistSessionKey);
  }, removePersistedSession: () {
    return storage.delete(key: supabasePersistSessionKey);
  }, persistSession: (String value) {
    return storage.write(key: supabasePersistSessionKey, value: value);
  });
  Supabase.initialize(
    url: BuildConfig.baseUrl,
    anonKey: BuildConfig.baseKey,
    localStorage: localStorage,
  );
}
