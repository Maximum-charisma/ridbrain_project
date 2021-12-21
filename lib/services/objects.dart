import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ridbrain_project/services/get_driver.dart';

AuthAnswer authAnswerFromJson(String str) =>
    AuthAnswer.fromJson(json.decode(str));

class AuthAnswer {
  AuthAnswer({
    required this.error,
    required this.message,
    required this.token,
  });

  int error;
  String message;
  String token;

  factory AuthAnswer.fromJson(Map<String, dynamic> json) => AuthAnswer(
        error: json["error"] ?? 1,
        message: json["message"] ?? "",
        token: json["token"] ?? "",
      );
}

TokenAnswer tokenAnswerFromJson(String str) =>
    TokenAnswer.fromJson(json.decode(str));

class TokenAnswer {
  TokenAnswer({
    required this.error,
    required this.status,
  });

  int error;
  int status;

  factory TokenAnswer.fromJson(Map<String, dynamic> json) => TokenAnswer(
        error: json["error"] ?? 1,
        status: json["status"] ?? 0,
      );
}

class Company {
  Company({
    required this.companyId,
    required this.companyName,
    required this.companyPhone,
    required this.companyLocation,
    required this.companyNote,
    required this.companyWeb,
  });

  int companyId;
  String companyName;
  CompanyLocation companyLocation;
  String companyPhone;
  String companyNote;
  String companyWeb;
}

class CompanyLocation {
  CompanyLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  String address;
  double latitude;
  double longitude;
}

class Record {
  Record({
    required this.recordId,
    required this.recordDate,
    required this.recordStatus,
    required this.recordNote,
    required this.company,
    required this.recordColor,
    this.driver,
  });

  int recordId;
  int recordDate;
  List<RecordStatus> recordStatus;
  String recordNote;
  Company company;
  int recordColor;
  Driver? driver;

  Color getColor() {
    switch (recordColor) {
      case 2:
        return Colors.red.shade100;
      case 3:
        return Colors.green.shade100;
      case 4:
        return Colors.blue.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  String driverName() {
    if (driver == null) {
      return "Водитель не назначен";
    }
    return driver!.driverName;
  }
}

class RecordStatus {
  RecordStatus({
    required this.status,
    required this.date,
  });

  int status;
  int date;

  String getLabel() {
    switch (status) {
      case 2:
        return "Принята";
      case 3:
        return "На загрузке";
      case 4:
        return "На выгрузке";
      case 5:
        return "Выполнена";
      default:
        return "Ожидание";
    }
  }
}


class User {
  User({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userStatus,
    required this.userRole,
  });

  int userId;
  String userName;
  String userEmail;
  int userStatus;
  int userRole;
}
