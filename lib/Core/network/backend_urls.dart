class BackendUrls {
  BackendUrls._();

  /// Keep this file as the single source of truth for backend endpoints.
  static const String baseUrl = 'https://supercareer-backend-1.onrender.com';

  // Auth
  static const String authGoogleRegister = '$baseUrl/api/auth/google/register/';
  static const String authGoogleLogin = '$baseUrl/api/auth/google/login/';
  static const String login = '$baseUrl/api/login/';
  static const String register = '$baseUrl/api/register/';
}

