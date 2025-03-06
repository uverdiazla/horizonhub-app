import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'oauth2_library.dart';
import "package:flutter_secure_storage/flutter_secure_storage.dart";
class LoginWebManager {
  final OAuth2Library oauthLibrary;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  LoginWebManager(this.oauthLibrary);

  Future<bool> startLoginProcess(String email, BuildContext context) async {
    return await _oauthLogin(email, context);
  }

  Future<bool> startLogoutProcess() async {
    return await _oauthLogout();
  }

  Future<bool> _oauthLogin(String email, BuildContext context) async {
    final token = await oauthLibrary.helper.getToken();
    if (token == null || !token.isValid()) {
      return false;
    }

    bool res = await _checkIfEqualsEmail(email, context);

    if (!res) {
      return false;
    }

    await secureStorage.write(key: 'auth_token', value: token.accessToken);

    return true;
  }

  Future<bool> _oauthLogout() async {
    await secureStorage.delete(key: 'auth_token');
    await oauthLibrary.helper.getToken();
    return true;
  }


  _checkIfEqualsEmail(String email, BuildContext context) async {
    final token = await oauthLibrary.helper.getTokenFromStorage();
    if (token == null || !token.isValid()) {
      return false;
    }
    final Map<String, dynamic> decodedToken = Jwt.parseJwt(token.accessToken!);
    final String emailToken = decodedToken['unique_name'];

    if (emailToken != email) {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text('El email no coincide, cierra sesión en Microsoft y vuelve a iniciar sesión.'),
                actions: [
                  TextButton(
                    child: const Text('Cerrar'),
                    onPressed: () async => {
                      Navigator.of(context).pop(),
                      await oauthLibrary.helper.disconnect(),
                      //processLogout(),
                    },
                  )
                ],
              );
            }
        );
      }
      return false;
    }

    return true;
  }
}
