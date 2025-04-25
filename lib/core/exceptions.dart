//Exception that is thrown when http request call response is not 200

import 'package:flutter/foundation.dart';
import 'package:sample_app/core/locale_provider.dart';

class HttpRequestException implements Exception {
  // final String message;

  // HttpRequestException(this.message) {
  //   Print(toString());
  // }
}

//Exception that is thrown when value is not presented in Local Db
class LocalDbExceptionimplements implements Exception {}

//Exception that is thrown when Entity to Model conversion is performed
class EntityModelMapperException implements Exception {
  final String message;

  EntityModelMapperException({required this.message});
}

class RemoteServerException implements Exception {}

class LocalDatabaseException implements Exception {}

String _handleError(int? statusCode, dynamic error) {
  switch (statusCode) {
    case 400:
      return 'Bad request';
    case 401:
      return 'Unauthorized';
    case 403:
      return 'Forbidden';
    case 404:
      return error['message'];
    case 500:
      return 'Internal server error';
    case 502:
      return 'Bad gateway';
    default:
      return 'Oops something went wrong';
  }
}

Map<String, String> ErrorMessages = {
  'user_isnt_active': Localization.tr.needActivatingUserMessage,
  'user_not_found': Localization.tr.noitemsFound,
  'ACCOUNT_EXIST': Localization.tr.account_exist,
  'USERNAME_EXIST': Localization.tr.username_exist,
  'NAME_EXIST': Localization.tr.name_exist,
};

void Print(Object? object) {
  if (kDebugMode) {
    print(object);
  }
  // talker.error(object);
}
