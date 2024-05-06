import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:open_weather_example_flutter/common/debug/debug.dart';
import 'package:open_weather_example_flutter/common/device_info.dart';
import 'package:open_weather_example_flutter/common/model/login_model.dart';
import 'package:open_weather_example_flutter/common/name_hive_keys.dart';
import 'package:open_weather_example_flutter/common/resource/definition.dart';
import 'package:open_weather_example_flutter/common/utils/utils.dart';

///Class quản lý thông tin người dùng
///các biến, thông tin người dùng lưu vào sharedpreference cũng lấy ở đây cho tiện
class UserManagement {
  static final UserManagement _shared = UserManagement._initialState();

  factory UserManagement() {
    return _shared;
  }

  final Box _boxHive = Hive.box(nameBoxHive);

  String? accessToken = '';
  String? accountName = '';
  LoginModel? loginInfo;

  @protected
  String? _oneSignalID = '';
  String? get oneSignalID => _oneSignalID;

  String _deviceSystemVersion = '';
  String _deviceOsVersion = '29'; // Android10+
  String get deviceInfo =>
      'Hệ điều hành: ${Platform.operatingSystem}\nPhiên bản: $_deviceSystemVersion';
  String get deviceOs => _deviceOsVersion;
  Future<void> _getDeviceSystemVersion() async {
    if (Platform.isAndroid) {
      _deviceSystemVersion =
          'Android ${(await DeviceInfoPlugin().androidInfo).version.release}';
      _deviceOsVersion =
          '${(await DeviceInfoPlugin().androidInfo).version.sdkInt}';
    } else {
      _deviceSystemVersion =
          (await DeviceInfoPlugin().iosInfo).systemName ?? '';
      _deviceOsVersion = (await DeviceInfoPlugin().iosInfo).systemVersion ?? '';
    }
  }

  @protected
  String? _deviceName = '';

  String? get deviceName => _deviceName;

  /// Lấy device name
  Future<void> _getDeviceName() async {
    if (_deviceName == null || _deviceName!.isEmpty) {
      _deviceName = await DeviceInfo.deviceName;
      _deviceName = _deviceName!.replaceAll(':', '');
      _deviceName = Utils.cleanUpVietnamese(_deviceName)!.replaceAll(' ', '');
      _deviceName = Uri.encodeFull(_deviceName!);
      if (_deviceName!.length > 50) {
        _deviceName = _deviceName!.substring(0, 50);
      }
    }
  }

  @protected
  String? _systemVersion = '';

  String? get systemVersion => _systemVersion;

  /// Lấy system version
  Future<void> _getSystemVersion() async {
    if (_systemVersion == null || _systemVersion!.isEmpty) {
      _systemVersion = await DeviceInfo.systemVersion;
      _systemVersion = _systemVersion!.replaceAll(':', '');
      _systemVersion = Uri.encodeFull(_systemVersion!);
      if (_systemVersion!.length > 50) {
        _systemVersion = _systemVersion!.substring(0, 50);
      }
    }
  }

  /// Lấy device serial
  Future<String> getSeviceSerial(String accountName) async {
    final deviceSerial = await Utils.genOrGetGuid(accountName)
      ..replaceAll('-', '');

    return deviceSerial;
  }

  /// aGuid: chỉ dùng cho android, trường hợp người dùng clean data trong app info thì gen lại, coi như 1 thiết bị mới
  Future<String?> getAGuid(String accountName) async {
    return await _boxHive.get(
      '${NameHiveKeys.aGuid}$accountName',
    );
  }

  void setAGuid(String accountName, {String? data}) {
    if (data == null) {
      _boxHive.delete(
        '${NameHiveKeys.aGuid}$accountName',
      );
    } else {
      _boxHive.put(
        '${NameHiveKeys.aGuid}$accountName',
        data,
      );
    }
  }

  Future<String?> getAccountLogin() async {
    return await _boxHive.get(
      NameHiveKeys.accountLogin,
    );
  }

  void setAccountLogin(String? data) {
    _boxHive.put(
      NameHiveKeys.accountLogin,
      data,
    );
  }

  Future<void> getOneSignalID() async {
    if (_oneSignalID == null || _oneSignalID!.isEmpty) {
      final deviceState = await OneSignal.shared.getDeviceState();
      final oneSignalId = deviceState?.userId ?? '';
      _oneSignalID = oneSignalId;
      Debug.logMessage(message: 'PlayerID:$_oneSignalID');
    }
  }

  void resetDataWhenLogout() {
    _oneSignalID = '';
    loginInfo = null;
    setLoginInfo();
  }

  void setLoginInfo({String? data}) {
    if (data == null) {
      _boxHive.delete(NameHiveKeys.loginInfo);
      loginInfo = null;
    } else {
      _boxHive.put(NameHiveKeys.loginInfo, data);
      loginInfo = loginModelFromJson(data);
    }
  }

  Future<LoginModel?> _getLoginInfo() async {
    final _loginInfo = await _boxHive.get(NameHiveKeys.loginInfo);
    if (loginInfo != null) {
      final loginModel = loginModelFromJson(_loginInfo!);
      loginInfo = loginModel;
      return loginModel;
    }
    return null;
  }

  /// Initial State
  UserManagement._initialState();

  GlobalKey<NavigatorState>? navigatorKey;

  /// Preload data
  Future<void> preloadData() async {}
}
