import 'dart:async';

import 'package:open_weather_example_flutter/common/model/login_model.dart';
import 'package:open_weather_example_flutter/common/user_management.dart';
import 'package:open_weather_example_flutter/common/utils/utils.dart';
import 'package:open_weather_example_flutter/src/common/api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_repository.g.dart';

class LoginRepository {
  Future<LoginModel?> login(
          {required String user,
          required String pass,
          required String otp,
          required int secureTypeID}) =>
      ApiService().postData(
        builder: (data) => data != null ? LoginModel.fromJson(data) : null,
        api: '/v1.0/Account/AuthenticateApp',
        body: {
          'AccountName': user,
          'Password': Utils.generateMd5(pass),
          'OneSignalID': UserManagement().oneSignalID,
          'SecureCode': otp,
          'SecureTypeID': secureTypeID
        },
      );
}

@riverpod
LoginRepository loginRepository(LoginRepositoryRef ref) {
  return LoginRepository();
}
