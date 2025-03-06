// ignore_for_file: unused_field
import 'package:horizon_hub/core/models/company_dto.dart';
import 'package:oauth2_client/oauth2_client.dart';
import 'package:oauth2_client/oauth2_helper.dart';

class OAuth2Library {
  final String _authorizeUrl;
  final String _tokenUrl;
  final String _redirectUri;
  final String _customUriScheme;
  final String _clientId;
  final List<String> _scopes;

  final OAuth2Client _client;
  late final OAuth2Helper _helper;

  // Singleton instance
  static OAuth2Library? _instance;

  factory OAuth2Library({
    required String authorizeUrl,
    required String tokenUrl,
    required String redirectUri,
    required String customUriScheme,
    required String clientId,
    required List<String> scopes,
  }) {
    _instance ??= OAuth2Library._internal(
      authorizeUrl,
      tokenUrl,
      redirectUri,
      customUriScheme,
      clientId,
      scopes,
    );
    return _instance!;
  }

  OAuth2Library._internal(
    this._authorizeUrl,
    this._tokenUrl,
    this._redirectUri,
    this._customUriScheme,
    this._clientId,
    this._scopes,
  ) : _client = OAuth2Client(
          authorizeUrl: _authorizeUrl,
          tokenUrl: _tokenUrl,
          redirectUri: _redirectUri,
          customUriScheme: _customUriScheme,
        ) {
    _helper = OAuth2Helper(_client, clientId: _clientId, scopes: _scopes);
  }

  OAuth2Client get client => _client;
  OAuth2Helper get helper => _helper;

  // Method to remove the existing singleton instance
  static void removeInstance() {
    _instance = null;
  }

  // Method to check if an instance exists
  static bool isInstanceCreated() {
    return _instance != null;
  }

  static Future<bool> isUserLoggedIn() async {
    if (_instance == null) {
      return false;
    }
    var accessToken = await _instance!.helper.getTokenFromStorage();
    return accessToken != null &&
        !accessToken.isExpired() &&
        accessToken.isValid();
  }

  static Future<bool> isUserLoggedInStatic() async {
    if (_instance == null) {
      return false;
    }
    var accessToken = await _instance!.helper.getTokenFromStorage();
    return accessToken != null &&
        !accessToken.isExpired() &&
        accessToken.isValid();
  }

  //Method to retrieve the instance without arguments
  static OAuth2Library getInstance() {
    if (_instance == null) {
      throw Exception(
          'OAuth2Library instance not created. Call OAuth2Library.createInstance() first.');
    }
    return _instance!;
  }

  // Method to recreate a new instance with different configurations
  static void recreateInstance({
    required String authorizeUrl,
    required String tokenUrl,
    required String redirectUri,
    required String customUriScheme,
    required String clientId,
    required List<String> scopes,
  }) {
    //destroy the previous instance
    removeInstance();
    _instance = OAuth2Library(
      authorizeUrl: authorizeUrl,
      tokenUrl: tokenUrl,
      redirectUri: redirectUri,
      customUriScheme: customUriScheme,
      clientId: clientId,
      scopes: scopes,
    );
  }

  static void recreateInstanceFromCompanySettings(
      Company companySettings) {
    recreateInstance(
      authorizeUrl: companySettings.authUrl ?? '',
      tokenUrl: companySettings.authTokenUrl ?? '',
      redirectUri: companySettings.authRedirectUrl ?? '',
      customUriScheme: companySettings.schema ?? '',
      clientId: companySettings.authClientId ?? '',
      scopes: companySettings.authScope?.split(' ') ?? [],
    );
  }

  // recreate instance from company settings if is mobile, replace redirect url for authRedirectUrlMobile
  static void recreateInstanceFromCompanySettingsMobile(Company companySettings) {
    var scopes = companySettings.authScope?.split(' ') ?? [];
    scopes.add('offline_access');
    recreateInstance(
      authorizeUrl: companySettings.authUrl ?? '',
      tokenUrl: companySettings.authTokenUrl ?? '',
      redirectUri: companySettings.authRedirectUrlMobile ?? '',
      customUriScheme: companySettings.schema ?? '',
      clientId: companySettings.authClientId ?? '',
      scopes: scopes,
    );
  }

  // recreate settings for logout
  static void recreateInstanceFromCompanySettingsForLogout(Company companySettings) {
    recreateInstance(
      authorizeUrl: 'https://login.microsoftonline.com/common/oauth2/v2.0/logout',
      tokenUrl: companySettings.authTokenUrl ?? '',
      redirectUri: companySettings.authRedirectUrl ?? '',
      customUriScheme: companySettings.schema ?? '',
      clientId: companySettings.authClientId ?? '',
      scopes: companySettings.authScope?.split(' ') ?? [],
    );
  }

  // recreate instance from company settings if is mobile, replace redirect url for authRedirectUrlMobile
  static void recreateInstanceFromCompanySettingsMobileForLogout(Company companySettings) {
    recreateInstance(
      authorizeUrl: 'https://login.microsoftonline.com/common/oauth2/v2.0/logout',
      tokenUrl: companySettings.authTokenUrl ?? '',
      redirectUri: companySettings.authRedirectUrlMobile ?? '',
      customUriScheme: companySettings.schema ?? '',
      clientId: companySettings.authClientId ?? '',
      scopes: companySettings.authScope?.split(' ') ?? [],
    );
  }
}
