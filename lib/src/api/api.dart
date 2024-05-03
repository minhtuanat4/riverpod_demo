/// Uri builder class for the OpenWeatherMap API
class OpenWeatherMapAPI {
  OpenWeatherMapAPI(this.apiKey);
  final String apiKey;

  Uri weather(Map<String, dynamic> city) => _buildUri(
        endpoint: "weather",
        parametersBuilder: () => city,
      );

  Uri forecast(Map<String, dynamic> city) => _buildUri(
        endpoint: "forecast",
        parametersBuilder: () => city,
      );

  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      path: endpoint,
      queryParameters: parametersBuilder(),
    );
  }
}
