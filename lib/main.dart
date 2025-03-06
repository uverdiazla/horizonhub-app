import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:horizon_hub/app/app_root.dart';
import 'package:horizon_hub/app/config/app_config.dart';
import 'package:horizon_hub/core/contracts/i_app_config.dart';
import 'package:horizon_hub/core/contracts/i_date_formatter.dart';
import 'package:horizon_hub/core/contracts/i_size_config.dart';
import 'package:horizon_hub/core/contracts/i_text_formatter.dart';
import 'package:horizon_hub/core/contracts/i_theme_config.dart';
import 'package:horizon_hub/core/responsive/size_config.dart';
import 'package:horizon_hub/core/theme/app_theme.dart';
import 'package:horizon_hub/shared/utils/date_formatter.dart';
import 'package:horizon_hub/shared/utils/html_text_formatter.dart';

final GetIt locator = GetIt.instance;

/// Sets up the service locator and registers the necessary dependencies.
void setupLocator() {
  // Register the app configuration
  locator.registerLazySingleton<IAppConfig>(() => AppConfig());

  // Register the theme configuration
  locator.registerLazySingleton<IThemeConfig>(() => AppTheme());

  // Register the HTML text formatter for cleaning up HTML tags.
  locator.registerLazySingleton<ITextFormatter>(() => HtmlTextFormatter());

  // Register the responsive size configuration
  locator.registerLazySingleton<ISizeConfig>(() => SizeConfig());

  // Register DateFormatter for date formatting
  locator.registerLazySingleton<IDateFormatter>(() => DateFormatter());

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const AppRoot());
}