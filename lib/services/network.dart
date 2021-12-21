import 'package:ridbrain_project/services/check_token.dart';
import 'package:ridbrain_project/services/get_driver.dart';
import 'package:http/http.dart' as http;

class Network {
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

  static Future<GetDriver> getDriver(login, pass) async {
    try {
      final responce = await http.post(
          Uri.parse("https://server.roman.com.ru/app/scripts/user_auth.php"),
          body: {"login": login, "pass": pass});

      final GetDriver driver = getDriverFromJson(responce.body);
      return driver;
    } catch (e) {
      throw Exception(e);
    }
  }
}
