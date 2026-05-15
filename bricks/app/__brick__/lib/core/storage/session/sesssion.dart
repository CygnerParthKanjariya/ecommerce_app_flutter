import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum SessionKey {  isLoggedIn }

class SessionManager {
  static final storage = FlutterSecureStorage();

  static Future<void> setLoggedIn(bool b) async {
    return await storage.write(
      key: SessionKey.isLoggedIn.name,
      value: b ? "true" : "false",
    );
  }


  static Future<bool> isLoggedIn() async {
    var isLoggedIn = await storage.read(key: SessionKey.isLoggedIn.name);
    return isLoggedIn == "true";
  }


}
