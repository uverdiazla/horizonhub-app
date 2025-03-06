// ignore: avoid_web_libraries_in_flutter
import 'oauth2_library.dart';

class LoginWebManager {
  final OAuth2Library oauthLibrary;

  LoginWebManager(this.oauthLibrary);

  Future<bool> startLoginProcess() async {
    // Logic for initiating the login process
    return await _oauthLogin();
  }

  void _eventListener() {
    // ignore: unused_local_variable
    // Handle the token here if needed
  }

  Future<bool> _oauthLogin() async {
    final token = await oauthLibrary.helper.getToken();
    if (token == null || !token.isValid()) {
      return false;
    }
    //APIConstants.TOKEN = token.accessToken!;
    return true;
  }
}
