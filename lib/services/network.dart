import 'package:flutter/material.dart';
import 'package:ridbrain_project/services/check_token.dart';
import 'package:http/http.dart' as http;
import 'package:ridbrain_project/services/constants.dart';
import 'package:ridbrain_project/services/objects.dart';
import 'package:ridbrain_project/services/snack_bar.dart';

class Network {
  Network(this.context);
  final BuildContext context;

  void _showAnswer(int status, String message) {
    StandartSnackBar.show(
      context,
      message,
      status == 0 ? SnackBarStatus.success() : SnackBarStatus.warning(),
    );
  }

  Future<String?> _request({
    required String url,
    Map<String, String>? params,
  }) async {
    var response = await http.post(
      Uri.parse(apiUrl + url),
      body: params,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  static Future<bool> checkToken(token) async {
    try {
      final responce = await http.post(
          Uri.parse("https://server.roman.com.ru/app/scripts/check_token.php"),
          body: {"token": token});

      final CheckToken checkToken = checkTokenFromJson(responce.body);
      if (checkToken.status != 0) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<DriverAnswer> getDriver(login, pass) async {
    try {
      final responce = await http.post(
          Uri.parse("https://server.roman.com.ru/app/scripts/user_auth.php"),
          body: {"login": login, "pass": pass});

      print(responce.body);

      final DriverAnswer driver = driverAnswerFromJson(responce.body);
      return driver;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Record>> getRecords(token) async {
    try {
      final responce = await http.post(
          Uri.parse("https://server.roman.com.ru/app/scripts/get_records.php"),
          body: {"token": token});

      final RecordsAnswer records = recordsAnswerFromJson(responce.body);
      return records.records;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<bool> changeRecordStatus(String token, String recordId,
      String recordStatus, String recordHistory) async {
    try {
      final responce = await http.post(
          Uri.parse(
            "https://server.roman.com.ru/app/scripts/change_record_status.php",
          ),
          body: {
            "token": token,
            "record_id": recordId,
            "record_status": recordStatus,
            "record_history": recordHistory
          });

      print(responce);

      final MessageAnswer message = messageAnswerFromJson(responce.body);
      return message.error == 0;
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Record>> getActiveRecords(token) async {
    try {
      final responce = await http.post(
          Uri.parse(
              "https://server.roman.com.ru/app/scripts/get_active_records.php"),
          body: {"token": token});

      final RecordsAnswer records = recordsAnswerFromJson(responce.body);
      return records.records;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> confirmRecord(
    String token,
    String recordId,
    String driver,
    String recordHistory,
  ) async {
    var address = 'confirm_record.php';

    var data = await _request(url: address, params: {
      "token": token,
      "record_id": recordId,
      "driver": driver,
      "record_history": recordHistory,
    });

    print(data);

    if (data != null) {
      var answer = messageAnswerFromJson(data);
      _showAnswer(answer.error, answer.message);

      return answer.error == 0;
    } else {
      return false;
    }
  }

  Future<bool> changePass(
    String token,
    String oldPass,
    String newPass,
  ) async {
    var address = 'change_pass.php';

    var data = await _request(url: address, params: {
      "token": token,
      "old_pass": oldPass,
      "new_pass": newPass,
    });

    print(data);

    if (data != null) {
      var answer = messageAnswerFromJson(data);
      _showAnswer(answer.error, answer.message);

      return answer.error == 0;
    } else {
      return false;
    }
  }

  static Future addCoordinates(
    String token,
    String driverId,
    String latitude,
    String longitude,
  ) async {
    await http.post(
      Uri.parse("https://server.roman.com.ru/app/scripts/add_coordinate.php"),
      body: {
        "token": token,
        "driver_id": driverId,
        "latitude": latitude,
        "longitude": longitude,
      },
    );
  }
}
