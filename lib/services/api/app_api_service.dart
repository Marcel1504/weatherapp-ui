class AppApiService {
  static const String _apiUrl = String.fromEnvironment("API_URL", defaultValue: "");

  Uri restUrl(String url) {
    return Uri.parse(_apiUrl + url);
  }
}
