import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/src/api/api.dart';
import 'package:open_weather_example_flutter/src/api/api_keys.default.dart';
import 'package:open_weather_example_flutter/src/common/api_service.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/forecast/forecast.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/weather.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'weather_repository.g.dart';

/// Weather Repository using the http client. Calls API methods and parses responses.
class HttpWeatherRepository {
  HttpWeatherRepository({
    required this.api,
    required this.apiService,
  });
  final OpenWeatherMapAPI api;
  final ApiService apiService;

  Future<Forecast> getForecast({required String city}) => apiService.getData(
        uri: api.forecast({'city': city}),
        builder: (data) => Forecast.fromJson(data),
      );

  Future<Weather> getWeather({required String city}) => apiService.getData(
        uri: api.weather({'city': city}),
        builder: (data) => Weather.fromJson(data),
      );
}

@riverpod
HttpWeatherRepository httpWeatherRepository(HttpWeatherRepositoryRef ref) {
  const apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: APIKeys.openWeatherAPIKey,
  );
  return HttpWeatherRepository(
      api: OpenWeatherMapAPI(apiKey), apiService: ref.read(apiServiceProvider));
} 
// /// Providers used by rest of the app
// final weatherRepositoryProvider = Provider<HttpWeatherRepository>((ref) {
//   /// Use the API key passed via --dart-define,
//   /// or fallback to the one defined in api_keys.dart
//   // set key to const
//   const apiKey = String.fromEnvironment(
//     'API_KEY',
//     defaultValue: APIKeys.openWeatherAPIKey,
//   );
//   return HttpWeatherRepository(
//       api: OpenWeatherMapAPI(apiKey), apiService: ref.read(apiServiceProvider));
// });
