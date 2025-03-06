import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:horizon_hub/app/routes/app_routes.dart';
import 'package:horizon_hub/core/responsive/size_config.dart';
import 'package:horizon_hub/core/theme/app_theme.dart';

/// The root of the application, responsible for initializing
/// theme, routes, and responsive settings.
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize GoRouter for navigation
    final GoRouter router = AppRoutes.router;

    // LayoutBuilder allows us to initialize responsive design based on screen size
    return LayoutBuilder(
      builder: (context, constraints) {
        // Initialize responsive settings (e.g., text size, layout size)
        SizeConfig().init(context);

        // Define the main structure of the app
        return MaterialApp.router(
          title: 'Horizon Hub',
          theme: AppTheme().getTheme(),
          routerConfig: router, // Use GoRouter for route configuration

          // Localizations settings for multiple languages
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('es', ''),
          ],
          locale: const Locale('es'), // Default locale is Spanish
        );
      },
    );
  }
}
