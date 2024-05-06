import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_weather_example_flutter/common/user_management.dart';
import 'package:uuid/uuid.dart';

mixin Utils {
  static String generateMd5(String data) {
    const md5 = crypto.md5;
    return md5.convert(utf8.encode(data)).toString();
  }

  static String formatMoney(
    int? number, {
    String format = '#,###',
    String locationlize = 'vi_VN',
  }) {
    return number == null
        ? '0'
        : NumberFormat(format, locationlize).format(number).toString();
  }

  static Size getSizes(GlobalKey key) {
    try {
      final renderBoxRed = key.currentContext!.findRenderObject() as RenderBox;
      final sizeRed = renderBoxRed.size;
      return sizeRed;
    } catch (e) {
      return Size.zero;
    }
  }

  static Future<String> genOrGetGuid(String accountName) async {
    var aGuid = await UserManagement().getAGuid(accountName);
    if (aGuid == null || aGuid.isEmpty) {
      const uuid = Uuid();
      aGuid = uuid.v4();
      UserManagement().setAGuid(accountName, data: aGuid);
    }
    return aGuid;
  }

  static Future<bool> checkNetwork() async {
    var isConnected = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }

  static String? cleanUpVietnamese(String? input) {
    if (input == null) {
      return null;
    }
    var res = input;
    const before =
        'áàảãạ ăắằẳẵặ âấầẩẫậ ÁÀẢÃẠ ĂẮẰẲẴẶ ÂẤẦẨẪẬ đ Đ éèẻẽẹ êếềểễệ ÉÈẺẼẸ ÊẾỀỂỄỆ íìỉĩị ÍÌỈĨỊ óòỏõọ ôốồổỗộ ơớờởỡợ ÓÒỎÕỌ ÔỐỒỔỖỘ ƠỚỜỞỠỢ úùủũụ ưứừửữự ÚÙỦŨỤ ƯỨỪỬỮỰ ýỳỷỹỵ ÝỲỶỸỴ';
    const after =
        'aaaaa aaaaaa aaaaaa AAAAA AAAAAA AAAAAA d D eeeee eeeeee EEEEE EEEEEE iiiii IIIII ooooo oooooo oooooo OOOOO OOOOOO OOOOOO uuuuu uuuuuu UUUUU UUUUUU yyyyy YYYYY';

    for (var i = 0; i < before.length; i++) {
      final b = before.substring(i, i + 1);
      final a = after.substring(i, i + 1);
      if (!b.contains(' ')) {
        res = res.replaceAll(b, a);
      }
    }
    return res;
  }

  static String formatDate({
    required DateTime date,
    String format = 'dd/MM/yyyy HH:mm',
  }) {
    final formater = DateFormat(format);
    return formater.format(date);
  }

  static String convertToDatetime(int datetime) {
    final f = DateFormat('yyyy/MM/dd HH:mm');
    final date = DateTime.fromMillisecondsSinceEpoch(datetime);
    return f.format(date);
  }

  static String getCurrentDate() {
    final f = DateFormat('dd/MM/yyyy');
    final date = DateTime.now();
    return f.format(date);
  }

  static String getCurrentTime() {
    final f = DateFormat('dd/MM/yyyy hh:MM');
    final date = DateTime.now();
    return f.format(date);
  }

  static String getCurrentTimeWithFormat(String dateFormat) {
    final f = DateFormat(dateFormat);
    final date = DateTime.now();
    return f.format(date);
  }
}
