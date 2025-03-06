import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class ILocalizationTypeResponsesServices {
  String networkError(String message, AppLocalizations localizations);
  String jsonError(String message, AppLocalizations localizations);
  String unexpectedError(String message, AppLocalizations localizations);
  String success(String message, AppLocalizations localizations);
}
