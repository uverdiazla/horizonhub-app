import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'oauth2_library.dart';

class LoginNativeManager {
  final OAuth2Library oauthLibrary;

  LoginNativeManager(this.oauthLibrary);
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> startLoginProcess(String email, BuildContext context) async {
    // Logic for initiating the native login process
    return await _oauthLogin(email, context);
  }

  Future<bool> startLogoutProcess() async {
    // Lógica para iniciar el proceso de inicio de sesión
    // Registra el evento de escucha si es necesario, según tu lógica específica para dispositivos web.

    return await _oauthLogout();
  }

  Future<bool> _oauthLogin(String email, BuildContext context) async {
    final token = await oauthLibrary.helper.getToken();
    if (token == null || !token.isValid()) {
      return false;
    }

    oauthLibrary.helper.scopes?.removeLast();

    bool res = await _checkIfEqualsEmail(email, context);

    if (!res) {
      return false;
    }

    return true;
  }

  Future<bool> _oauthLogout() async {
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
                title: Text('Error'),
                content: Text('El email no coincide, cierra sesión en Microsoft y vuelve a iniciar sesión.'),
                actions: [
                  TextButton(
                    child: Text('Cerrar'),
                    onPressed: () async => {
                      Navigator.of(context).pop(),
                      // cancelar el token
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
