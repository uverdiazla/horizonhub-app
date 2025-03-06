import 'package:horizon_hub/core/models/company_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OAuthPreferences {
  final SharedPreferences _prefs;

  OAuthPreferences._(this._prefs);

  factory OAuthPreferences.getInstance(SharedPreferences prefs) {
    return _instance ??= OAuthPreferences._(prefs);
  }

  static OAuthPreferences? _instance;

  void recreateInstance(SharedPreferences prefs) {
    _instance = OAuthPreferences._(prefs);
  }

  bool hasInstance() {
    return _instance != null;
  }

  Future<void> setOAuthSettings({
    String? authorizeUrl,
    String? tokenUrl,
    String? redirectUri,
    String? customUriScheme,
    String? clientId,
    List<String>? scopes,
  }) async {
    await _prefs.setString('authorizeUrl', authorizeUrl ?? '');
    await _prefs.setString('tokenUrl', tokenUrl ?? '');
    await _prefs.setString('redirectUri', redirectUri ?? '');
    await _prefs.setString('customUriScheme', customUriScheme ?? '');
    await _prefs.setString('clientId', clientId ?? '');
    await _prefs.setStringList('scopes', scopes ?? []);
  }

  String? get authorizeUrl => _prefs.getString('authorizeUrl');
  String? get tokenUrl => _prefs.getString('tokenUrl');
  String? get redirectUri => _prefs.getString('redirectUri');
  String? get customUriScheme => _prefs.getString('customUriScheme');
  String? get clientId => _prefs.getString('clientId');
  List<String>? get scopes => _prefs.getStringList('scopes');

  void setOAuthSettingsFromCompanySettings(Company companySettings) {
    setOAuthSettings(
      authorizeUrl: companySettings.authUrl,
      tokenUrl: companySettings.authTokenUrl,
      redirectUri: "com.henutsen.retail://oauth2redirect",
      customUriScheme: companySettings.schema,
      clientId: companySettings.authClientId,
      scopes: companySettings.authScope?.split(' '),
    );
  }
}
