/*
 * BSD 2-Clause License
 *
 * Copyright (c) 2021, Bhavik Makwana
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
///
/// While Running a flutter run or flutter build you need to pass following
/// arguments
///
/// --dart-define=BASE_URL=url_here --dart-define=BASE_KEY=key_here --dart-define=OAUTH_CLIENT_ID=client_id_here
///
///
/// which will look like below:
///
/// flutter run --dart-define=BASE_URL=url_here --dart-define=BASE_KEY=key_here --dart-define=OAUTH_CLIENT_ID=client_id_here
///
class BuildConfig {
  static String get baseUrl => _getBaseUrl();
  static String get baseKey => _getBaseKey();
  static String get oAuthClientId => _getOAuthClientId();
  static String _getBaseUrl() => const String.fromEnvironment('BASE_URL');

  static String _getBaseKey() => const String.fromEnvironment('BASE_KEY');

  static String _getOAuthClientId() =>
      const String.fromEnvironment('OAUTH_CLIENT_ID');

  // Image Kit
  static String get imageKitUrlEndpoint => _getImageKitUrlEndpoint();
  static String get imageKitPublicKey => _getImageKitPublicKey();
  static String _getImageKitUrlEndpoint() =>
      const String.fromEnvironment('IMAGE_KIT_URL_ENDPOINT');
  static String _getImageKitPublicKey() =>
      const String.fromEnvironment('IMAGE_KIT_PUBLIC_KEY');
}
