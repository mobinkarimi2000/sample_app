import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as gql;
import 'package:sample_app/core/exceptions.dart';

import 'locale_provider.dart';

extension IsOk on Response {
  bool get ok {
    return (statusCode! ~/ 100) == 2;
  }
}

enum ActionType {
  NON,
  ADD,
  DEL,
  UPDATE,
  GET,
  SHARE,
  NEW,
  VIEW,
  EDIT,
  MENU,
  REFRESH,
  FOCUSE,
}

class DataState<T> {
  final T? data;
  final Exception? exption;
  final DioException? dioexption;
  final gql.OperationException? gqlexption;
  final String? customError;
  ActionType action;

  bool isSuccess() {
    return dioexption == null &&
        gqlexption == null &&
        exption == null &&
        customError == null;
  }

  Map? get info =>
      dioexption!.response == null
          ? null
          : dioexption!.response!.data['message'] is List
          ? {'message': dioexption!.response!.data['message'][0]}
          : dioexption!.response!.data;

  String get message {
    final errorinfo = dioexption!.response!.data['error'];
    if (errorinfo != null) {
      final msg = ErrorMessages[errorinfo];
      if (msg != null) return msg;
    }
    return jsonEncode(dioexption!.response!.data);
  }

  String shortErrorMessage() {
    if (dioexption != null && dioexption!.response != null) {
      if (dioexption!.response!.data['errors'] != null) {
        return dioexption!.response!.data['errors'][0].toString();
      } else {
        //Print(message);
        //Print(jsonEncode(info));
        return message;
      }
    }

    if (dioexption != null) {
      if (dioexption!.error is SocketException) {
        return '${Localization.tr.checkInternetConnection}\r\n${(dioexption!.error as SocketException).message}';
      }
      return dioexption!.message ?? dioexption.toString();
    }
    if (gqlexption != null) {
      return gqlexption.toString();
    }
    if (exption != null) {
      return exption.toString();
    }
    return customError == null ? 'unknown' : customError!;
  }

  DataState({
    this.data,
    this.exption,
    this.dioexption,
    this.gqlexption,
    this.customError,
    this.action = ActionType.NON,
  }) {
    if (dioexption != null) {
      if (dioexption!.error is SocketException) {
        Print(dioexption!.error);
        //final err = (error!.error as SocketException);
        //Print(err.osError!.errorCode);
        // if (checkConnection.value == false) {
        //   checkConnection.value = true;
        // }
      } else {
        Print(dioexption);
      }
    }
    if (gqlexption != null) {
      if (gqlexption!.linkException != null &&
          gqlexption!.linkException!.originalException is SocketException) {
        {
          Print(gqlexption);
        }
        // if (checkConnection.value == false) checkConnection.value = true;
      }
    }
    if (exption != null) {
      if (dioexption!.error is SocketException) {
        {
          Print(dioexption!.error);
        }
        //final err = (error!.error as SocketException);
        //Print(err.osError!.errorCode);
        // if (checkConnection.value == false) checkConnection.value = true;
      }
    }
    if (customError != null) {
      Print(customError);
    }
  }

  DataState<T> copyWith({
    T? data,
    Exception? exption,
    DioException? error,
    gql.OperationException? gqlexption,
    String? customError,
    ActionType? action,
  }) => DataState<T>(
    data: data ?? this.data,
    exption: exption ?? this.exption,
    dioexption: error ?? this.dioexption,
    gqlexption: gqlexption ?? this.gqlexption,
    customError: customError ?? this.customError,
    action: action ?? this.action,
  );
}

///////////////////////////////////////

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data, {ActionType? action})
    : super(data: data, action: action ?? ActionType.NON);
}

///////////////////////////////////////

class DataFaild<T> extends DataState<T> {
  DataFaild(Exception ex) : super(exption: ex);
}

///////////////////////////////////////

class DataDioException<T> extends DataState<T> {
  DataDioException(DioException error) : super(dioexption: error);
}

///////////////////////////////////////

class DataQqlException<T> extends DataState<T> {
  DataQqlException(gql.OperationException exp) : super(gqlexption: exp);
}

///////////////////////////////////////

class DataError<T> extends DataState<T> {
  DataError(String msg, {super.data}) : super(customError: msg);
}

///////////////////////////////////////

class DataSuccessAction<T> extends DataState<T> {
  DataSuccessAction(T data, ActionType action)
    : super(data: data, action: action);
}

class DataFaildAction<T> extends DataState<T> {
  DataFaildAction(String msg, ActionType action)
    : super(customError: msg, action: action);
}

///////////////////////////////////////
