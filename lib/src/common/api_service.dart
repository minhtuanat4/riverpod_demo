import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_example_flutter/common/config/app_config.dart';
import 'package:open_weather_example_flutter/common/user_management.dart';
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
final apiServiceProvider = Provider<ApiService>(ApiService.new);

class ApiService {
  final ProviderRef<ApiService> ref;
  HttpClient httpClient = HttpClient();

  final dio = Dio();
  final String accessToken = '';

  ///Stream chứa thông tin avatar
  // ignore: close_sinks
  StreamController<String?> linkAvatarStreamController =
      StreamController<String?>.broadcast();

  ApiService(this.ref);

  void configureDio() {
    final bcontextMain = UserManagement().navigatorKey!.currentContext!;
    dio.options.baseUrl = AppConfig.of(bcontextMain)!.vtcEPosUrl;
    dio.options.headers = <String, String>{
      'content-type': 'application/json; charset=utf-8',
      'vtc-request-system': '6d692e7d03b39ee92d142ee8cfc80b8c',
      'Authorization': 'Bearer $accessToken',
    };
    dio.options.connectTimeout = const Duration(seconds: 15);
    dio.options.receiveTimeout = const Duration(seconds: 12);
  }

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

  final userManagement = UserManagement();

  Future<T> postData<T>({
    required String api,
    required Map<String, dynamic> body,
    required T Function(dynamic data) builder,
  }) async {
    ref.read(loadingProvider.notifier).state = true;
    final _deviceName = userManagement.deviceName;
    final _systemVersion = userManagement.systemVersion;
    String _deviceSerial = '';
    if (body.containsKey('AccountName') && body['AccountName'] != null) {
      _deviceSerial = await userManagement.getSeviceSerial(body['AccountName']);
    }
    final _devicebrowser =
        Platform.isIOS ? 'VTCAPP-ios;OS:ios' : 'VTCAPP-Android;OS:Android';
    final oSName = Platform.isIOS ? 'IOS' : 'Android';
    if (!body.containsKey('AccountName')) {
      final loginModel = userManagement.loginInfo;
      body['AccountName'] = loginModel?.accountName;
      if ((loginModel?.accessToken ?? '').isNotEmpty) {
        body['AccessToken'] = loginModel?.accessToken;
      }
    }
    final deviceDetail =
        'fingerprint:$_deviceSerial-$_deviceSerial;devicebrowser:$_devicebrowser-$_systemVersion;device:$_deviceName;devicetype:Mobile;resolution:Mobile';
    body['BranchID'] = 1;
    body['OSName'] = oSName;
    body['RequestID'] = DateTime.now().millisecondsSinceEpoch.toString();
    body['DeviceID'] = _deviceSerial;
    body['DeviceDetail'] = deviceDetail;

    body['DeviceType'] = Platform.isIOS
        ? 3
        : Platform.isAndroid
            ? 4
            : -1;
    body['EnvironmentType'] = 2;
    body['ClientIP'] = '192.168.1.1';

    try {
      final response = await dio.post(
        api,
        data: body,
        options: Options(method: 'POST'),
      );
      ref.read(loadingProvider.notifier).state = false;
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.data);
          return builder(data);
        case 401:
          throw InvalidApiKeyException();
        case 404:
          throw CityNotFoundException();
        default:
          throw UnknownException();
      }
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      throw NoInternetConnectionException();
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
      ref.read(loadingProvider.notifier).state = false;
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          throw InvalidApiKeyException();
        case 404:
          throw CityNotFoundException();
        default:
          throw UnknownException();
      }
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      throw NoInternetConnectionException();
    }
  }
}
