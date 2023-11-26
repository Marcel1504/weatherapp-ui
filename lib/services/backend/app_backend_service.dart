class AppBackendService {
  static const String _apiUrl = String.fromEnvironment("API_URL", defaultValue: "");
  static const String _assistantUrl = String.fromEnvironment("ASSISTANT_URL", defaultValue: "");

  Uri apiUrl(String url) {
    return Uri.parse(_apiUrl + url);
  }

  Uri assistantUrl(String url) {
    return Uri.parse(_assistantUrl + url);
  }
}
