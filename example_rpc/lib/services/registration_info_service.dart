import 'package:inject_x/inject_x.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqlite_wrapper_sample/services/database_service.dart';

class RegistrationInfo {
  String? email;
  String? password;
  String? token;

  bool get isRegistered =>
      email != null &&
      email!.isNotEmpty &&
      password != null &&
      password!.isNotEmpty &&
      token != null &&
      token!.isNotEmpty;
}

class RegistrationInfoService {
  late RegistrationInfo registrationInfo;

  Future<RegistrationInfo> getRegistrationInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    registrationInfo = RegistrationInfo()
      ..email = prefs.getString("email")
      ..password = prefs.getString("password")
      ..token = prefs.getString("token");
    _setTokenValue();
    return registrationInfo;
  }

  Future<void> setRegistrationInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", registrationInfo.email ?? "");
    prefs.setString("password", registrationInfo.password ?? "");
    prefs.setString("token", registrationInfo.token ?? "");
    _setTokenValue();
  }

  Future<void> registerOrLogin(
      {required String email, required String password, login = false}) async {
    final authClient = inject<DatabaseService>().database.authClient;
    late String token;
    if (login) {
      token = await authClient.login(email, password);
    } else {
      token = await authClient.register(email, password);
    }
    registrationInfo
      ..email = email
      ..password = password
      ..token = token;
    await setRegistrationInfo();
  }

  _setTokenValue() {
    inject<DatabaseService>().database.token = registrationInfo.token ?? "";
  }
}
