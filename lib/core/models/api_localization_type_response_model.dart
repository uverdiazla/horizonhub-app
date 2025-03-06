import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:horizon_hub/core/contracts/i_localization_type_response_service.dart';


class LocalizationTypeResponsesServices implements ILocalizationTypeResponsesServices {
  @override
  String networkError(String message, AppLocalizations localizations) {
    return localizations.network_error(message);
  }

  @override
  String jsonError(String message, AppLocalizations localizations) {
    return localizations.json_error(message);
  }

  @override
  String unexpectedError(String message, AppLocalizations localizations) {
    return localizations.unexpected_error(message);
  }

  @override
  String success(String message, AppLocalizations localizations) {
    return localizations.success(message);
  }
}
