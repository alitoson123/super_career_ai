class BackendUrls {
  BackendUrls._();

  /// Base URL
  static const String baseUrl = 'http://76.13.55.54:8000';

  // Auth Endpoints
  static const String authGoogleRegister = '$baseUrl/api/auth/google/register/';
  static const String authGoogleLogin = '$baseUrl/api/auth/google/login/';
  static const String login = '$baseUrl/api/login/';
  static const String register = '$baseUrl/api/register/';

  // Matching Endpoints
  static const String jobMatches = '$baseUrl/api/opportunities/jobs/';
  static const String projectMatches = '$baseUrl/api/opportunities/projects/';

  // Custom Proposal Endpoint
  static const String customProposal =
      '$baseUrl/api/matching/generate-proposal/';
}
