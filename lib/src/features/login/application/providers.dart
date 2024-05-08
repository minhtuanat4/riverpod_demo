import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_weather_example_flutter/common/model/login_model.dart';
import 'package:open_weather_example_flutter/src/features/login/data/login_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'providers.g.dart';

final userProvider = Provider((ref) => '');
final passwordProvider = Provider((ref) => '');
final otpProvider = Provider((ref) => '');
final secureTypeIdProvider = Provider((ref) => 0);

class LoginRequestInfo {
  LoginRequestInfo(this._ref);

  final Ref _ref;
  String get user => _ref.read(userProvider);
  String get pass => _ref.read(passwordProvider);
  String get otp => _ref.read(otpProvider);
  int get secureTypeId => _ref.read(secureTypeIdProvider);
}

@riverpod
class Login extends _$Login {
  String isTouch = 'isTouch';
  @override
  LoginModel? build() {
    return null;
  }

  Future<void> login() async {
    final loginRequestInfo = LoginRequestInfo(ref);
    final res = await ref.read(loginRepositoryProvider).login(
        user: loginRequestInfo.user,
        pass: loginRequestInfo.pass,
        otp: loginRequestInfo.otp,
        secureTypeID: loginRequestInfo.secureTypeId);
    state = res;
  }

  void update(LoginModel value) {
    state = value;
  }
}
