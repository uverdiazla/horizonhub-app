
import 'package:horizon_hub/core/contracts/i_app_config.dart';

/// Concrete implementation of the IAppConfig interface.
/// This class provides the actual values for the configuration settings.
class AppConfig implements IAppConfig {
  @override
  String get baseUrl => 'https://api.example.com'; // URL

  @override
  String get apiKey => ''; // Replace with your actual API key
}