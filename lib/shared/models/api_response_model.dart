import 'package:horizon_hub/core/contracts/i_localization_type_response_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class ApiResponse<T> {
  final int statusCode;
  final String message;
  final T? data;

  ApiResponse({
    required this.statusCode,
    required this.message,
    this.data,
  });
}

ApiResponse<T> handleResponse<T>(
    http.Response response,
    ILocalizationTypeResponsesServices localizationService,
    AppLocalizations localizations,
    T? parsedData,
    ) {
  switch (response.statusCode) {
    case 200:
      return ApiResponse<T>(
        statusCode: response.statusCode,
        message: localizationService.success(response.body, localizations),
        data: parsedData, // Use the provided parsed data
      );
    case 400:
      return ApiResponse<T>(
        statusCode: response.statusCode,
        message: localizationService.jsonError(response.body, localizations),
      );
    case 500:
      return ApiResponse<T>(
        statusCode: response.statusCode,
        message: localizationService.unexpectedError(response.body, localizations),
      );
    default:
      return ApiResponse<T>(
        statusCode: response.statusCode,
        message: localizationService.unexpectedError(response.body, localizations),
      );
  }
}

ApiResponse<T> handleException<T>(Exception e, ILocalizationTypeResponsesServices localizationService, AppLocalizations localizations) {
  if (e is http.ClientException) {
    return ApiResponse<T>(
      statusCode: 0,
      message: localizationService.networkError(e.message, localizations),
    );
  } else if (e is FormatException) {
    return ApiResponse<T>(
      statusCode: 0,
      message: localizationService.jsonError(e.message, localizations),
    );
  } else {
    return ApiResponse<T>(
      statusCode: 0,
      message: localizationService.unexpectedError(e.toString(), localizations),
    );
  }
}