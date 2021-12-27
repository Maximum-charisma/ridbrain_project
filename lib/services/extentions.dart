extension Times on DateTime {
  int secondsSinceEpoch() {
    return millisecondsSinceEpoch ~/ 1000;
  }
}