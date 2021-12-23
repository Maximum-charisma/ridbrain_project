import 'dart:async';

import 'package:geolocator/geolocator.dart';

class Location {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void sendLocation() {
    const oneSec = Duration(seconds: 5);
    Timer.periodic(
      oneSec,
      (Timer t) {
        determinePosition().then(
          (value) {
            // print(value.latitude);
          },
        );
      },
    );
  }
}
