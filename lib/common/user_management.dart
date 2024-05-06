import 'dart:async';

import 'package:flutter/material.dart';

///Class quản lý thông tin người dùng
///các biến, thông tin người dùng lưu vào sharedpreference cũng lấy ở đây cho tiện
class UserManagement {
  static final UserManagement _shared = UserManagement._initialState();

  factory UserManagement() {
    return _shared;
  }

  /// Initial State
  UserManagement._initialState();

  GlobalKey<NavigatorState>? navigatorKey;

  /// Preload data
  Future<void> preloadData() async {}
}
