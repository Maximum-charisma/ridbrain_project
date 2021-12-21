import 'dart:convert';

GetDriver getDriverFromJson(String str) => GetDriver.fromJson(json.decode(str));

String getDriverToJson(GetDriver data) => json.encode(data.toJson());

class GetDriver {
  GetDriver({
    required this.error,
    required this.driver,
  });

  int error;
  Driver driver;

  factory GetDriver.fromJson(Map<String, dynamic> json) => GetDriver(
        error: json["error"],
        driver: Driver.fromJson(json["driver"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "driver": driver.toJson(),
      };
}

class Driver {
  Driver({
    required this.driverToken,
    required this.driverName,
    required this.driverPhone,
    required this.driverEmail,
  });

  String driverToken;
  String driverName;
  String driverPhone;
  String driverEmail;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        driverToken: json["driver_token"],
        driverName: json["driver_name"],
        driverPhone: json["driver_phone"],
        driverEmail: json["driver_email"],
      );

  Map<String, dynamic> toJson() => {
        "driver_token": driverToken,
        "driver_name": driverName,
        "driver_phone": driverPhone,
        "driver_email": driverEmail,
      };
}
