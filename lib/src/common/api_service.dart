import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/src/common/loading_provider.dart';
import 'package:open_weather_example_flutter/src/features/weather/data/api_exception.dart';
// class ApiService {
//   Future<T> getData<T>({
//     required Uri uri,
//     required T Function(dynamic data) builder,
//   }) async {
//     try {
//       final response = await http.Client().get(uri);
//       switch (response.statusCode) {
//         case 200:
//           final data = json.decode(response.body);
//           return builder(data);
//         case 401:
//           throw InvalidApiKeyException();
//         case 404:
//           throw CityNotFoundException();
//         default:
//           throw UnknownException();
//       }
//     } on SocketException catch (_) {
//       throw NoInternetConnectionException();
//     }
//   }
// }

class VTCServices {
  static const String APP_SERVICE = '/mobileapis-appvtcpay/';
  static const String EVENT_HAIKHE = '/PickingStarFruitEvent/';
  static const String EVENT_SERVICE = '/mobileapis-appvtcpay-events/';
}

class EnvironmentType {
  static const int web = 1;
  static const int app = 2;
}

enum RequestMethod { requestPost, requestGet }

enum RequestFromBaseUrl { requestFromVTCPay, requestFromVTCPayFollow }

/// Providers used by rest of the app
final apiServiceProvider = Provider<ApiService>((ref) {
  /// Use the API key passed via --dart-define,
  /// or fallback to the one defined in api_keys.dart
  // set key to const

  return ApiService(ref);
});

class ApiService {
  final ProviderRef<ApiService> ref;
  HttpClient httpClient = HttpClient();

  ///Stream chứa thông tin avatar
  // ignore: close_sinks
  StreamController<String?> linkAvatarStreamController =
      StreamController<String?>.broadcast();

  ApiService(this.ref);
  Stream<String?> get linkAvatar => linkAvatarStreamController.stream;

  ///Stream chứa thông tin balance
  // ignore: close_sinks
  StreamController<int> balanceStreamController =
      StreamController<int>.broadcast();
  Stream<int> get balance => balanceStreamController.stream;

  // ApiServiceOld({BuildContext? context}) : bcontext = context {

  // }

  void streamChangeBalance({required int balance}) {
    if (balance >= 0) {
      balanceStreamController.add(balance);
    }
  }

  ///Các tham số đã có, k cần truyền: AccountName; AccessToken; RequestID; DeviceID; DeviceDetail; deviceType
  Future<T> getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      ref.read(loadingProvider.notifier).state = true;
      final response = await http.Client().get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          ref.read(loadingProvider.notifier).state = false;
          return builder(data);
        case 401:
          ref.read(loadingProvider.notifier).state = false;
          throw InvalidApiKeyException();
        case 404:
          throw CityNotFoundException();
        default:
          ref.read(loadingProvider.notifier).state = false;
          throw UnknownException();
      }
    } on SocketException catch (_) {
      ref.read(loadingProvider.notifier).state = false;
      throw NoInternetConnectionException();
    }
  }
}
