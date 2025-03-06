import 'package:horizon_hub/core/enums/auth_method.dart';


class Company {
  final int id;
  final String name;
  final AuthMethod authMethod;
  final String? authUrl;
  final String? authClientId;
  final String? authClientSecret;
  final String? schema;
  final String? authOpenIdConfigUrl;
  final String? authRedirectUrl;
  final String? authRedirectUrlMobile;
  final String? authScope;
  final String? authAudience;
  final String? authIssuer;
  final String? authTokenUrl;

  // Constructor with required and optional fields
  Company({
    required this.id,
    required this.name,
    this.authMethod = AuthMethod.azure, // Default authentication method is Azure
    this.authUrl,
    this.authClientId,
    this.authClientSecret,
    this.schema,
    this.authOpenIdConfigUrl,
    this.authRedirectUrl,
    this.authRedirectUrlMobile,
    this.authScope,
    this.authAudience,
    this.authIssuer,
    this.authTokenUrl,
  });

  // Factory method to create a Company instance from JSON
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      authMethod: AuthMethod.values.firstWhere(
            (e) => e.toString() == 'AuthMethod.${json['authMethod']}',
        orElse: () => AuthMethod.azure, // Default to Azure if not found
      ),
      authUrl: json['authUrl'],
      authClientId: json['authClientId'],
      authClientSecret: json['authClientSecret'],
      schema: json['schema'],
      authOpenIdConfigUrl: json['authOpenIdConfigUrl'],
      authRedirectUrl: json['authRedirectUrl'],
      authRedirectUrlMobile: json['authRedirectUrlMobile'],
      authScope: json['authScope'],
      authAudience: json['authAudience'],
      authIssuer: json['authIssuer'],
      authTokenUrl: json['authTokenUrl'],
    );
  }

  // Method to convert a Company instance into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'authMethod': authMethod.name,
      'authUrl': authUrl,
      'authClientId': authClientId,
      'authClientSecret': authClientSecret,
      'schema': schema,
      'authOpenIdConfigUrl': authOpenIdConfigUrl,
      'authRedirectUrl': authRedirectUrl,
      'authRedirectUrlMobile': authRedirectUrlMobile,
      'authScope': authScope,
      'authAudience': authAudience,
      'authIssuer': authIssuer,
      'authTokenUrl': authTokenUrl,
    };
  }
}
