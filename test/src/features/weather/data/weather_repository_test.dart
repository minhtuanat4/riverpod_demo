import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_example_flutter/common/model/login_model.dart';
import 'package:open_weather_example_flutter/common/resource/definition.dart';
import 'package:open_weather_example_flutter/src/common/api_service.dart';
import 'package:open_weather_example_flutter/src/features/login/data/login_repository.dart';
import 'package:open_weather_example_flutter/src/features/weather/domain/weather/weather.dart';

// class MockHttpClient extends Mock implements http.Client {}

const encodeLoginJsonResponse = '''
{AccountName: null, AccountID: 0, Balance: 0, AccessToken: null, FullName: null, AccountType: 0, CUID: null, SecureDataInfo: null, SecureTypeID: 0, AsteriskNumber: null, ResponseCode: -600, Description: Dữ liệu đầu vào không hợp lệ, vui lòng kiểm tra lại!, Extend: null}''';
const encodedWeatherJsonResponse = '''
{
  "coord": {
    "lon": -122.08,
    "lat": 37.39
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 282.55,
    "feels_like": 281.86,
    "temp_min": 280.37,
    "temp_max": 284.26,
    "pressure": 1023,
    "humidity": 100
  },
  "visibility": 16093,
  "wind": {
    "speed": 1.5,
    "deg": 350
  },
  "clouds": {
    "all": 1
  },
  "dt": 1560350645,
  "sys": {
    "type": 1,
    "id": 5122,
    "message": 0.0139,
    "country": "US",
    "sunrise": 1560343627,
    "sunset": 1560396563
  },
  "timezone": -25200,
  "id": 420006353,
  "name": "Mountain View",
  "cod": 200
  }  
''';

final expectedWeatherFromJson = Weather(
  weatherParams: WeatherParams(temp: 282.55, tempMin: 280.37, tempMax: 284.26),
  weatherInfo: [
    WeatherInfo(
      description: 'clear sky',
      icon: '01d',
      main: 'Clear',
    )
  ],
  dt: 1560350645,
);
final expectedLoginFromJson = LoginModel();

void main() {
  final dio = Dio();
  String baseUrl;
  setUp(() {
    baseUrl = baseEPosUrlAlpha;
  });
  // test('repository with mocked http client, success', () async {
  //   final mockHttpClient = MockHttpClient();
  //   final api = OpenWeatherMapAPI('apiKey');
  //   final weatherRepository = HttpWeatherRepository(
  //     api: api,
  //   );

  //   when(() => mockHttpClient.get(api.weather({'city': 'London'}))).thenAnswer(
  //       (_) => Future.value(http.Response(encodedWeatherJsonResponse, 200)));
  //   final weather = await weatherRepository.getWeather(city: 'London');
  //   // expectations
  //   expect(weather, expectedWeatherFromJson);
  // });
  test('', () async {
    final loginRepository = LoginRepository();
    final apiService = ApiService();
    // final userManagement = UserManagement();

    when(() => apiService.postData(
              builder: (data) =>
                  data != null ? LoginModel.fromJson(data) : null,
              api: '/v1.0/Account/AuthenticateApp',
              body: {
                'AccountName': 'user',
                'Password': 'pass',
                'OneSignalID': 'userManagement.oneSignalID',
                'SecureCode': 'otp',
                'SecureTypeID': 2
              },
            ))
        .thenAnswer((_) => Future.value(
            LoginModel.fromJson(json.decode(encodeLoginJsonResponse))));

    final loginModel = await loginRepository.login(
        user: 'user', pass: 'pass', otp: 'otp', secureTypeID: 2);

    expect(loginModel, expectedLoginFromJson);
  });

  // test('repository with mocked http client, failure', () async {
  //   final mockHttpClient = MockHttpClient();
  //   final api = OpenWeatherMapAPI('apiKey');
  //   final weatherRepository = HttpWeatherRepository(
  //     api: api,
  //   );
  //   when(() => mockHttpClient.get(api.weather({'city': 'London'})))
  //       .thenAnswer((_) => Future.value(http.Response('{}', 401)));
  //   // expectations
  //   expect(() => weatherRepository.getWeather(city: 'London'),
  //       throwsA(isA<APIException>()));
  // });
}
