import 'package:supabase/supabase.dart';
import 'package:supabase_playground/core/supabase/build_config.dart';

class SBClient {
  static SBClient? _instance;

  static SBClient? get instance =>
      _instance == null ? _instance = SBClient._() : _instance;

  SBClient._() {
    client = SupabaseClient(
      '${BuildConfig.baseUrl}',
      '${BuildConfig.baseKey}',
    );
  }

  late SupabaseClient client;
}
