// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? responseCode;
  String? description;
  String? loginModelExtends;
  String? accountName;
  int? accountId;
  int? balance;
  String? accessToken;
  String? fullName;
  int? accountType;
  String? cuid;
  String? secureDataInfo;
  int? secureTypeId;
  String? asteriskNumber;

  LoginModel({
    this.responseCode,
    this.description,
    this.loginModelExtends,
    this.accountName,
    this.accountId,
    this.balance,
    this.accessToken,
    this.fullName,
    this.accountType,
    this.cuid,
    this.secureDataInfo,
    this.secureTypeId,
    this.asteriskNumber,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        responseCode: json['ResponseCode'],
        description: json['Description'],
        loginModelExtends: json['Extend'],
        accountName: json['AccountName'],
        accountId: json['AccountID'],
        balance: json['Balance'],
        accessToken: json['AccessToken'],
        fullName: json['FullName'],
        accountType: json['AccountType'],
        cuid: json['CUID'],
        secureDataInfo: json['SecureDataInfo'],
        secureTypeId: json['SecureTypeID'],
        asteriskNumber: json['AsteriskNumber'],
      );

  Map<String, dynamic> toJson() => {
        'ResponseCode': responseCode,
        'Description': description,
        'Extend': loginModelExtends,
        'AccountName': accountName,
        'AccountID': accountId,
        'Balance': balance,
        'AccessToken': accessToken,
        'FullName': fullName,
        'AccountType': accountType,
        'CUID': cuid,
        'SecureDataInfo': secureDataInfo,
        'SecureTypeID': secureTypeId,
        'AsteriskNumber': asteriskNumber,
      };
}
