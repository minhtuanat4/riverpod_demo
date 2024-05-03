import 'package:open_weather_example_flutter/riverpod_test/base_provider.dart';
import 'package:open_weather_example_flutter/riverpod_test/model/movies_model.dart';

class MovieRepository {
  final BaseProvider provider;
  final String params;

  MovieRepository(this.provider, this.params);

  Future<MoviesModel> movies() async {
    return MoviesModel();
  }
}
