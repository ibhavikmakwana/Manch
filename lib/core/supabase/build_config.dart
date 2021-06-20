///
/// While Running a flutter run or flutter build you need to pass following
/// arguments
///
/// --dart-define=BASE_URL=url_here --dart-define=BASE_KEY=key_here
///
///
/// which will look like below:
///
/// flutter run --dart-define=BASE_URL=url_here --dart-define=BASE_KEY=key_here
///
class BuildConfig {
  static String? get baseUrl => _getBaseUrl();
  static String? get baseKey => _getBaseHey();

  static String? _getBaseUrl() => const String.fromEnvironment('BASE_URL');

  static String? _getBaseHey() => const String.fromEnvironment('BASE_KEY');
}
